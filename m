From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Thu, 26 May 2016 13:12:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1605261126510.31937@cbobk.fhfr.pm>
References: <1464237655-2242-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47728 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbcEZLMT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 07:12:19 -0400
In-Reply-To: <1464237655-2242-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissorires@redhat.com, linux-input@vger.kernel.org, peter.hutterer@who-t.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com, masaki.ota@jp.alps.com

On Thu, 26 May 2016, Masaki Ota wrote:

> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

Thanks for the patch. However, please supply a changelog; the driver is 
doing non-trivial operations, so at least a bit of explanation (why 
generic HID can't be used, what are interesting high-level properties of 
the protocol, etc.) would be appreciated.

> ---
>  drivers/hid/Makefile   |   1 +
>  drivers/hid/hid-alps.c | 513 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c |   5 +
>  drivers/hid/hid-ids.h  |   2 +
>  include/linux/hid.h    |   1 +

You need to update Kconfig as well, otherwise CONFIG_HID_ALPS wouldn't be 
selectable.

[ .. snip .. ]
> +struct u1_dev *priv;

Having this global is odd. How do you handle multiple devices connected to 
the machine? Is there a reason not to use hid_set_drvdata() / 
hid_get_drvdata() for this?

[ .. snip .. ]
> +static int u1_write_register(struct hid_device *hdev, u32 address, u8 value)
> +{
> +	int ret, i;
> +	u8 input[8];
> +	u8 check_sum;
> +
> +	input[0] = U1_FEATURE_REPORT_ID;
> +	input[1] = U1_CMD_REGISTER_WRITE;
> +	input[2] = address & 0x000000FF;
> +	input[3] = (address & 0x0000FF00) >> 8;
> +	input[4] = (address & 0x00FF0000) >> 16;
> +	input[5] = (address & 0xFF000000) >> 24;
> +	input[6] = value;
> +
> +	/* Calculate the checksum */
> +	check_sum = U1_FEATURE_REPORT_LEN_ALL;
> +	for (i = 0; i < U1_FEATURE_REPORT_LEN - 1; i++)
> +		check_sum += input[i];
> +
> +	input[7] = check_sum;
> +
> +	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,

Looks like on-stack DMA here.

> +static int u1_read_register(struct hid_device *hdev, u32 address, u8 *value)
> +{
> +	int ret, i;
> +	u8 input[8];
> +	u8 readbuf[8];
> +	u8 check_sum;
> +
> +	input[0] = U1_FEATURE_REPORT_ID;
> +	input[1] = U1_CMD_REGISTER_READ;
> +	input[2] = address & 0x000000FF;
> +	input[3] = (address & 0x0000FF00) >> 8;
> +	input[4] = (address & 0x00FF0000) >> 16;
> +	input[5] = (address & 0xFF000000) >> 24;
> +	input[6] = 0x00;
> +
> +	/* Calculate the checksum */
> +	check_sum = U1_FEATURE_REPORT_LEN_ALL;
> +	for (i = 0; i < U1_FEATURE_REPORT_LEN - 1; i++)
> +		check_sum += input[i];
> +
> +	input[7] = check_sum;
> +
> +	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,

The same here.

[ .. snip .. ]

> +static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
> +{
> +	struct u1_dev *data = hid_get_drvdata(hdev);
> +	struct input_dev *input = hi->input, *input2;
> +	struct u1_dev devInfo;
> +	int ret;
> +	int res_x, res_y, i;
> +
> +	/* Check device product ID*/

Nit: space before the second asterisk please.

> +	switch (hdev->product) {
> +	case HID_PRODUCT_ID_U1:
> +	case HID_PRODUCT_ID_U1_DUAL:
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	priv = kzalloc(sizeof(struct u1_dev), GFP_KERNEL);
> +	input2 = input_allocate_device();
> +	if (!priv || !input2)
> +		return 0;

You leak memory in case the kzalloc() succeeds but input_allocate_device() 
fails.

> +
> +	priv->input2 = input2;
> +	data->input = input;
> +
> +	hid_dbg(hdev, "Opening low level driver\n");
> +	ret = hid_hw_open(hdev);
> +	if (ret)
> +		return ret;

Looks like another priv/input2 leak here in case hid_hw_open() fails.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 7e89288..124fc38 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -833,6 +833,11 @@ static int hid_scan_report(struct hid_device *hid)
>  				 */
>  				hid->group = HID_GROUP_RMI;
>  		break;
> +	case USB_VENDOR_ID_ALPS_JP:
> +		if ((hid->group == HID_GROUP_GENERIC) &&
> +			(hid->bus == BUS_I2C))
> +			hid->group = HID_GROUP_ALPS;
> +		break;
>  	}
>  
>  	vfree(parser);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b6ff6e7..cac68c7 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -67,6 +67,8 @@
>  #define USB_VENDOR_ID_ALPS		0x0433
>  #define USB_DEVICE_ID_IBM_GAMEPAD	0x1101
>  
> +#define USB_VENDOR_ID_ALPS_JP		0x044E
> +
>  #define USB_VENDOR_ID_ANTON		0x1130
>  #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
>  
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 75b66ec..e35cabf 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -345,6 +345,7 @@ struct hid_item {
>  #define HID_GROUP_RMI				0x0100
>  #define HID_GROUP_WACOM				0x0101
>  #define HID_GROUP_LOGITECH_DJ_DEVICE		0x0102
> +#define HID_GROUP_ALPS				0x0103

Especially the explanation why you need a separate HID group needs to be 
in the changelog.

Thanks,

-- 
Jiri Kosina
SUSE Labs

