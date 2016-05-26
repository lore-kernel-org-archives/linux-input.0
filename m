From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Thu, 26 May 2016 11:54:40 -0700
Message-ID: <20160526185440.GA24380@dtor-ws>
References: <1464237655-2242-1-git-send-email-masaki.ota@jp.alps.com>
 <alpine.LNX.2.00.1605261126510.31937@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35139 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbcEZSyo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 14:54:44 -0400
Received: by mail-pa0-f66.google.com with SMTP id gp3so3105443pac.2
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 11:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1605261126510.31937@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Masaki Ota <012nexus@gmail.com>, benjamin.tissorires@redhat.com, linux-input@vger.kernel.org, peter.hutterer@who-t.net, hdegoede@redhat.com, masaki.ota@jp.alps.com

On Thu, May 26, 2016 at 01:12:19PM +0200, Jiri Kosina wrote:
> On Thu, 26 May 2016, Masaki Ota wrote:
> 
> > Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> 
> Thanks for the patch. However, please supply a changelog; the driver is 
> doing non-trivial operations, so at least a bit of explanation (why 
> generic HID can't be used, what are interesting high-level properties of 
> the protocol, etc.) would be appreciated.
> 
> > ---
> >  drivers/hid/Makefile   |   1 +
> >  drivers/hid/hid-alps.c | 513 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-core.c |   5 +
> >  drivers/hid/hid-ids.h  |   2 +
> >  include/linux/hid.h    |   1 +
> 
> You need to update Kconfig as well, otherwise CONFIG_HID_ALPS wouldn't be 
> selectable.
> 
> [ .. snip .. ]
> > +struct u1_dev *priv;
> 
> Having this global is odd. How do you handle multiple devices connected to 
> the machine? Is there a reason not to use hid_set_drvdata() / 
> hid_get_drvdata() for this?
> 
> [ .. snip .. ]
> > +static int u1_write_register(struct hid_device *hdev, u32 address, u8 value)
> > +{
> > +	int ret, i;
> > +	u8 input[8];
> > +	u8 check_sum;
> > +
> > +	input[0] = U1_FEATURE_REPORT_ID;
> > +	input[1] = U1_CMD_REGISTER_WRITE;
> > +	input[2] = address & 0x000000FF;
> > +	input[3] = (address & 0x0000FF00) >> 8;
> > +	input[4] = (address & 0x00FF0000) >> 16;
> > +	input[5] = (address & 0xFF000000) >> 24;

	put_unaligned_le32(address, input + 2);

> > +	input[6] = value;
> > +
> > +	/* Calculate the checksum */
> > +	check_sum = U1_FEATURE_REPORT_LEN_ALL;
> > +	for (i = 0; i < U1_FEATURE_REPORT_LEN - 1; i++)
> > +		check_sum += input[i];
> > +
> > +	input[7] = check_sum;

You should also factor this out as you are sharing pretty much the same
code with the u1_read_register().

> > +
> > +	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
> 
> Looks like on-stack DMA here.
> 
> > +static int u1_read_register(struct hid_device *hdev, u32 address, u8 *value)
> > +{
> > +	int ret, i;
> > +	u8 input[8];
> > +	u8 readbuf[8];
> > +	u8 check_sum;
> > +
> > +	input[0] = U1_FEATURE_REPORT_ID;
> > +	input[1] = U1_CMD_REGISTER_READ;
> > +	input[2] = address & 0x000000FF;
> > +	input[3] = (address & 0x0000FF00) >> 8;
> > +	input[4] = (address & 0x00FF0000) >> 16;
> > +	input[5] = (address & 0xFF000000) >> 24;
> > +	input[6] = 0x00;
> > +
> > +	/* Calculate the checksum */
> > +	check_sum = U1_FEATURE_REPORT_LEN_ALL;
> > +	for (i = 0; i < U1_FEATURE_REPORT_LEN - 1; i++)
> > +		check_sum += input[i];
> > +
> > +	input[7] = check_sum;
> > +
> > +	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
> 
> The same here.
> 
> [ .. snip .. ]
> 
> > +static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
> > +{
> > +	struct u1_dev *data = hid_get_drvdata(hdev);
> > +	struct input_dev *input = hi->input, *input2;
> > +	struct u1_dev devInfo;
> > +	int ret;
> > +	int res_x, res_y, i;
> > +
> > +	/* Check device product ID*/
> 
> Nit: space before the second asterisk please.
> 
> > +	switch (hdev->product) {
> > +	case HID_PRODUCT_ID_U1:
> > +	case HID_PRODUCT_ID_U1_DUAL:
> > +		break;
> > +	default:
> > +		return 0;
> > +	}
> > +
> > +	priv = kzalloc(sizeof(struct u1_dev), GFP_KERNEL);
> > +	input2 = input_allocate_device();
> > +	if (!priv || !input2)
> > +		return 0;
> 
> You leak memory in case the kzalloc() succeeds but input_allocate_device() 
> fails.

Also we do not really need to allocate input device until we determine
that the device actually has trackstick. And I think we should be
returning -ENOMEM here.

Thanks.

-- 
Dmitry
