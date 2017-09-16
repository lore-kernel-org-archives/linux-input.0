From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 5/7] Support new Alps device that name is T4
Date: Fri, 15 Sep 2017 17:33:49 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709151728190.4703@jbgna.fhfr.qr>
References: <20170912025414.3784-1-masaki.ota@jp.alps.com> <20170912025414.3784-6-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56509 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751143AbdIPAdv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Sep 2017 20:33:51 -0400
In-Reply-To: <20170912025414.3784-6-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Tue, 12 Sep 2017, Masaki Ota wrote:

> From: Masaki Ota <masaki.ota@jp.alps.com>
> -Add T4 device code and Product ID
> -This device is used on HP EliteBook 1000 series and Zbook Stduio
[ ... snip ... ]
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> +static int t4_read_write_register(struct hid_device *hdev, u32 address,
> +	u8 *read_val, u8 write_val, bool read_flag)
> +{
> +	int ret;
> +	u16 check_sum;
> +	u8 *input;
> +	u8 *readbuf;
> +
> +	input = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input[0] = T4_FEATURE_REPORT_ID;
> +	if (read_flag) {
> +		input[1] = T4_CMD_REGISTER_READ;
> +		input[8] = 0x00;
> +	} else {
> +		input[1] = T4_CMD_REGISTER_WRITE;
> +		input[8] = write_val;
> +	}
> +	put_unaligned_le32(address, input + 2);
> +	input[6] = 1;
> +	input[7] = 0;
> +
> +	/* Calculate the checksum */
> +	check_sum = t4_calc_check_sum(input, 1, 8);
> +	input[9] = (u8)check_sum;
> +	input[10] = (u8)(check_sum >> 8);
> +	input[11] = 0;
> +
> +	ret = hid_hw_raw_request(hdev, T4_FEATURE_REPORT_ID, input,
> +			T4_FEATURE_REPORT_LEN,
> +			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +
> +	if (ret < 0) {
> +		dev_err(&hdev->dev, "failed to read command (%d)\n", ret);
> +		goto exit;
> +	}
> +
> +	if (read_flag) {
> +		readbuf = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
> +		if (!readbuf) {
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +
> +		ret = hid_hw_raw_request(hdev, T4_FEATURE_REPORT_ID, readbuf,
> +				T4_FEATURE_REPORT_LEN,
> +				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +		if (ret < 0) {
> +			dev_err(&hdev->dev, "failed read register (%d)\n", ret);
> +			kfree(readbuf);
> +			goto exit;
> +		}
> +
> +		if (*(u32 *)&readbuf[6] != address) {
> +			dev_err(&hdev->dev, "read register address error (%x,%x)\n",
> +			*(u32 *)&readbuf[6], address);
> +			kfree(readbuf);
> +			goto exit;
> +		}
> +
> +		if (*(u16 *)&readbuf[10] != 1) {
> +			dev_err(&hdev->dev, "read register size error (%x)\n",
> +			*(u16 *)&readbuf[10]);
> +			kfree(readbuf);
> +			goto exit;
> +		}
> +
> +		check_sum = t4_calc_check_sum(readbuf, 6, 7);
> +		if (*(u16 *)&readbuf[13] != check_sum) {
> +			dev_err(&hdev->dev, "read register checksum error (%x,%x)\n",
> +			*(u16 *)&readbuf[13], check_sum);
> +			kfree(readbuf);
> +			goto exit;
> +		}
> +
> +		*read_val = readbuf[12];
> +
> +		kfree(readbuf);

You have a lot of

	kfree(readbuf);
	goto exit;

duplicates here, and you're freeing the buffer before returning anyway in 
all cases, so it'd make sense to introduce another label (say 
exit_readbuf) before the exit one, and free it there in a common exit 
path.

[ ... snip ... ]
> +static int t4_raw_event(struct alps_dev *hdata, u8 *data, int size)
> +{
> +	unsigned int x, y, z;
> +	int i;
> +	struct t4_input_report *p_report = (struct t4_input_report *)data;
> +
> +	if (!data)
> +		return 0;
> +	for (i = 0; i < hdata->max_fingers; i++) {
> +		x = p_report->contact[i].x_hi << 8 | p_report->contact[i].x_lo;
> +		y = p_report->contact[i].y_hi << 8 | p_report->contact[i].y_lo;
> +		y = hdata->y_max - y + hdata->y_min;
> +		z = (p_report->contact[i].palm < 0x80 &&
> +			p_report->contact[i].palm > 0) * 62;
> +		if (x == 0xffff) {
> +			x = 0;
> +			y = 0;
> +			z = 0;
> +		}
> +		input_mt_slot(hdata->input, i);
> +
> +		input_mt_report_slot_state(hdata->input,
> +			MT_TOOL_FINGER, z != 0);
> +
> +		if (!z)
> +			continue;
> +
> +		input_report_abs(hdata->input, ABS_MT_POSITION_X, x);
> +		input_report_abs(hdata->input, ABS_MT_POSITION_Y, y);
> +		input_report_abs(hdata->input, ABS_MT_PRESSURE, z);
> +	}
> +	input_mt_sync_frame(hdata->input);
> +
> +	input_report_key(hdata->input, BTN_LEFT,	p_report->button);

Extra tab here?

> -static int alps_post_resume(struct hid_device *hdev)
> +static int __maybe_unused alps_post_reset(struct hid_device *hdev)

Do we really need the __maybe_unused annotation here? Why not just hide 
the whole  post-reset callback handling into a #ifdef CONFIG_PM block?

Thanks,

-- 
Jiri Kosina
SUSE Labs

