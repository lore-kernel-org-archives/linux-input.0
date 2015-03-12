From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4] HID: multitouch: Add support for button type usage
Date: Wed, 11 Mar 2015 21:13:19 -0400
Message-ID: <20150312011318.GE19872@mail.corp.redhat.com>
References: <20150311215523.GC136254@ubuntu-hedt>
 <1426112801-120860-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbbCLBN0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 21:13:26 -0400
Content-Disposition: inline
In-Reply-To: <1426112801-120860-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 11 2015 or thereabouts, Seth Forshee wrote:
> According to [1], Windows Precision Touchpad devices must supply
> a button type usage in the device capabilities feature report. A
> value of 0 indicates that the device contains a depressible
> button (i.e. it's a click-pad) whereas a value of 1 indicates
> a non-depressible button. Add support for this usage and set
> INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
> depressible button is present.
> 
> [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for the quick re-spin

Cheers,
Benjamin

>  drivers/hid/hid-debug.c      |  1 +
>  drivers/hid/hid-multitouch.c | 16 ++++++++++++++++
>  include/linux/hid.h          |  1 +
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 8bf61d295ffd..4b2a18a8b7ec 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -165,6 +165,7 @@ static const struct hid_usage_entry hid_usage_table[] = {
>      {0, 0x53, "DeviceIndex"},
>      {0, 0x54, "ContactCount"},
>      {0, 0x55, "ContactMaximumNumber"},
> +    {0, 0x59, "ButtonType"},
>      {0, 0x5A, "SecondaryBarrelSwitch"},
>      {0, 0x5B, "TransducerSerialNumber"},
>    { 15, 0, "PhysicalInterfaceDevice" },
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index a8bec33f4764..6a9b05b328a9 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -71,6 +71,8 @@ MODULE_LICENSE("GPL");
>  #define MT_INPUTMODE_TOUCHSCREEN	0x02
>  #define MT_INPUTMODE_TOUCHPAD		0x03
>  
> +#define MT_BUTTONTYPE_CLICKPAD		0
> +
>  struct mt_slot {
>  	__s32 x, y, cx, cy, p, w, h;
>  	__s32 contactid;	/* the device ContactID assigned to this slot */
> @@ -116,6 +118,7 @@ struct mt_device {
>  				* 1 means we should use a serial protocol
>  				* > 1 means hybrid (multitouch) protocol */
>  	__u8 buttons_count;	/* number of physical buttons per touchpad */
> +	bool is_buttonpad;	/* is this device a button pad? */
>  	bool serial_maybe;	/* need to check for serial protocol */
>  	bool curvalid;		/* is the current contact valid? */
>  	unsigned mt_flags;	/* flags to pass to input-mt */
> @@ -334,6 +337,16 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  			td->maxcontacts = td->mtclass.maxcontacts;
>  
>  		break;
> +	case HID_DG_BUTTONTYPE:
> +		if (usage->usage_index >= field->report_count) {
> +			dev_err(&hdev->dev, "HID_DG_BUTTONTYPE out of range\n");
> +			break;
> +		}
> +
> +		if (field->value[usage->usage_index] == MT_BUTTONTYPE_CLICKPAD)
> +			td->is_buttonpad = true;
> +
> +		break;
>  	}
>  }
>  
> @@ -734,6 +747,9 @@ static void mt_touch_input_configured(struct hid_device *hdev,
>  
>  	/* check for clickpads */
>  	if ((td->mt_flags & INPUT_MT_POINTER) && (td->buttons_count == 1))
> +		td->is_buttonpad = true;
> +
> +	if (td->is_buttonpad)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  
>  	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 69f9cf7f078d..0167e0e0bf88 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -270,6 +270,7 @@ struct hid_item {
>  #define HID_DG_DEVICEINDEX	0x000d0053
>  #define HID_DG_CONTACTCOUNT	0x000d0054
>  #define HID_DG_CONTACTMAX	0x000d0055
> +#define HID_DG_BUTTONTYPE	0x000d0059
>  #define HID_DG_BARRELSWITCH2	0x000d005a
>  #define HID_DG_TOOLSERIALNUMBER	0x000d005b
>  
> -- 
> 1.9.1
> 
