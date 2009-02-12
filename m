From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [HID : improvement] Allow drivers to replace report
 descriptors
Date: Thu, 12 Feb 2009 11:59:18 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902121142250.31014@jikos.suse.cz>
References: <54bbe4e00901041135r37af208hae69cc9df6e407e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:48550 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZBLK7U (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2009 05:59:20 -0500
In-Reply-To: <54bbe4e00901041135r37af208hae69cc9df6e407e6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Tolysz <tolysz@gmail.com>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, 4 Jan 2009, Marcin Tolysz wrote:

> [HID : improvement] Allow drivers to replace report descriptors completely
>    Some devices present themselves as a HID device, however if we pass
> their device descriptor to HID subsystem they
>   might be bogus or broken. The idea behind this patch is to allow a
> device driver to decide how descriptor should look at the end.

Hi Marcin,

sorry for late response, I have been buried by other things.

>   Once we will be able to fix broken descriptors we could look into
> other bits of system i.e. completing support for other HID
>   extensions and then improving descriptors to support that new
> extensions.  And descriptors are static, one we have one
>   it act as a "firmware" for a kernel to tell how device's events
> should be interpreted.

In an ideal world this shouldn't be needed, because in ideal world there 
are vendors who create devices that are compliant with the standard ... oh 
well.

Could you please separate the patches, so that we have one that introduces 
that possibility to perform the complete report descriptor replacement, 
and the second one which uses this framework to implement better support 
for Sony PS3 controller? Thanks.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 40df3e1..9c04e23 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -643,7 +643,9 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
>  	struct hid_parser *parser;
>  	struct hid_item item;
>  	__u8 *end;
> -	int ret;
> +	int ret,n;

Please add a space here.

> +	unsigned int possibly_new_size=size;

Some spaces would also be nice here. And the variable name isn't really 
descriptive; new_size or nsize would work as well.

> -	if (device->driver->report_fixup)
> -		device->driver->report_fixup(device, start, size);
> +	if (device->driver->report_fixup){

Please add a space before the opening bracket.

> +	if (sc->quirks & PS3_SIXAXIS_REMAP ){
> +		/*The goal is to replace it, with rdesc supplied from user-space*/
> +		memcpy (rdesc , six_rep  , sizeof (six_rep));
> +		*rsize=sizeof (six_rep);
> +	}
>  }

I don't see a possibility to supply a replacement report descriptor from 
userspace, which contradicts the comment? (and BTW some spaces in the 
comment would also be nice, to be compatible with the rest of the kernel).

Also, please keep the proper formatting/spacing.

> +static int sony_set_operational_bluetooth(struct hid_device *hdev)
> +{
> +	/*TODO: Add bluetooth fix for dualshock/sixaxis */
> +	return 0;
> +}
> +

Are you planning to implement this for the final version of the patch?

> @@ -81,7 +97,7 @@ static int sony_probe(struct hid_device *hdev, const
> struct hid_device_id *id)
> 
>  	sc = kzalloc(sizeof(*sc), GFP_KERNEL);
>  	if (sc == NULL) {
> -		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
> +		dev_err(&hdev->dev, "can't alloc sony descriptor\n");

Ah, good catch, there is indeed a typo in sony_probe(). Could you please 
send this to me as a separate fix?

> -
> -	ret = sony_set_operational(hdev);
> -	if (ret)
> +
> +    if(quirks & PS3_SIXAXIS_OPERATIONAL){
> +    	switch (hdev->bus) {
> +			case BUS_USB:
> +				ret = sony_set_operational(hdev);
> +				break;
> +			case BUS_BLUETOOTH:
> +				ret = sony_set_operational_bluetooth(hdev);
> +				break;
> +			//default:

What is the purpose of this //default? (also please don't use this comment 
style in kernel source).

> +
> +/*
> +* Comments show connection between a descriptor and a report i.e. a position.
> +*/
> +
> +
> +__u8  six_rep[] ={
> +	0x05 , 0x01, //   Generic Desktop Controls
> +	0x09 , 0x04, //   Usage  Joystick
> +
> +	0xA1 , 0x01, //  Collection   Application
> +	0xA1 , 0x02, //  Collection   Logical
> +	0x85 , 0x01, //  Report ID  1

I'd prefer also the standard kernel commenting style here, please.

Also, the patch was whitespace-damaged, so please fix that up for your 
following submissions.

Thanks!

-- 
Jiri Kosina
SUSE Labs
