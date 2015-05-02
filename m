From: John Reid <owlman.lists@gmail.com>
Subject: Re: [PATCH] HID: lenovo: add support for Lenovo ThinkPad Keyboard
 Pro unit
Date: Sat, 02 May 2015 17:45:00 +1000
Message-ID: <5544807C.1080301@gmail.com>
References: <1430511765-28209-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32816 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbEBHpO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 May 2015 03:45:14 -0400
Received: by pablf10 with SMTP id lf10so22593552pab.0
        for <linux-input@vger.kernel.org>; Sat, 02 May 2015 00:45:14 -0700 (PDT)
In-Reply-To: <1430511765-28209-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Jonathan Oppenheim <lejono@gmail.com>, linux-input@vger.kernel.org

Hi Benjamin, all,

Keyboard works just fine now, along with the Wacom digitiser. Thank you
very much for you help linux-input folks :)

Might I suggest that the macro is renamed from
USB_DEVICE_ID_LENOVO_TPPRODOCK to something like
USB_DEVICE_ID_LENOVO_TPHELIXPROKDB as this better reflects the product
name in self documenting code? Technically this is a dockable keyboard
specific to the Helix tablet, and there is also a separate "dock" available.

Sorry for the tardy response. Been setting up a development environment.
Jono, I did a merge between
https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-next
tag v4.1-rc1 and
https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-next
at commit d92189ebbdcd0eb180317d8cd6d46c57ac9a3dc0. That way I pulled in
all the latest changes so that I'm not testing bugs that have already
been fixed. I'll update the ThinkWiki page to reflect this. I'm also
going to try my hand at setting up a launchpad PPA for packaging patched
kernels, xf86-input-libinput etc. until they make it into the ubuntu
mainline repositories.

cheers,
John

On 02/05/15 06:22, Benjamin Tissoires wrote:
> This dock is used with the Thinkpad Helix 2 but suffers from an error
> in the report descriptor where an usage max is 65535.
> 
> Add a report fixup for it and make the keyboard working.
> 
> Tested-by: Jonathan Oppenheim <lejono@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Jonathan,
> 
> Compared to the patch I sent you last week, the only difference is that
> I removed a remnant debug line :)
> 
> Cheers,
> Benjamin
> 
>  drivers/hid/hid-core.c   |  1 +
>  drivers/hid/hid-ids.h    |  1 +
>  drivers/hid/hid-lenovo.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 722a925..c2baf8c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1851,6 +1851,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
>  #endif
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b24caf8..e5b86e0 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -585,6 +585,7 @@
>  #define USB_DEVICE_ID_LENOVO_TPKBD	0x6009
>  #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
>  #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
> +#define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
>  
>  #define USB_VENDOR_ID_LG		0x1fd2
>  #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 78608d6..4e291d5 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -43,6 +43,35 @@ struct lenovo_drvdata_cptkbd {
>  
>  #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
>  
> +static const __u8 lenovo_pro_dock_need_fixup_collection[] = {
> +	0x05, 0x88,		/* Usage Page (Vendor Usage Page 0x88)	*/
> +	0x09, 0x01,		/* Usage (Vendor Usage 0x01)		*/
> +	0xa1, 0x01,		/* Collection (Application)		*/
> +	0x85, 0x04,		/*  Report ID (4)			*/
> +	0x19, 0x00,		/*  Usage Minimum (0)			*/
> +	0x2a, 0xff, 0xff,	/*  Usage Maximum (65535)		*/
> +};
> +
> +static __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +		unsigned int *rsize)
> +{
> +	switch (hdev->product) {
> +	case USB_DEVICE_ID_LENOVO_TPPRODOCK:
> +		/* the fixups that need to be done:
> +		 *   - get a reasonable usage max for the vendor collection
> +		 *     0x8801 from the report ID 4
> +		 */
> +		if (*rsize >= 153 &&
> +		    memcmp(&rdesc[140], lenovo_pro_dock_need_fixup_collection,
> +			  sizeof(lenovo_pro_dock_need_fixup_collection)) == 0) {
> +			rdesc[151] = 0x01;
> +			rdesc[152] = 0x00;
> +		}
> +		break;
> +	}
> +	return rdesc;
> +}
> +
>  static int lenovo_input_mapping_tpkbd(struct hid_device *hdev,
>  		struct hid_input *hi, struct hid_field *field,
>  		struct hid_usage *usage, unsigned long **bit, int *max)
> @@ -784,6 +813,7 @@ static const struct hid_device_id lenovo_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
>  	{ }
>  };
>  
> @@ -797,6 +827,7 @@ static struct hid_driver lenovo_driver = {
>  	.probe = lenovo_probe,
>  	.remove = lenovo_remove,
>  	.raw_event = lenovo_raw_event,
> +	.report_fixup = lenovo_report_fixup,
>  };
>  module_hid_driver(lenovo_driver);
>  
> 
