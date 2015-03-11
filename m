From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: multitouch: Add support for button type usage
Date: Wed, 11 Mar 2015 16:55:59 -0400
Message-ID: <20150311205559.GC19872@mail.corp.redhat.com>
References: <20150311172525.GB136254@ubuntu-hedt>
 <1426094951-44489-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426094951-44489-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Seth,

On Mar 11 2015 or thereabouts, Seth Forshee wrote:
> According to [1], Windows Precision Touchpad devices must supply
> a button type usage in the device capabilities feature report. A
> value of 0 indicates that the device contains a depressible
> button (i.e. it's a click-pad) whereas a value of 1 indicates
> a non-depressible button. Add support for this usage and set
> INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
> depressible button is present.
> 
> v2: Add string for button type usage in debugfs.
> v3: Fix conflicts with 015fdaa9f8ed ("HID: multitouch: add
>     support of clickpads").
> 
> [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---

[Replying to the previous thread here for convenience]

Sorry I might have overlooked your patch and forgot about it when I sent
mine. I should definitively have looked at this in detail because that's
a better approach IMO.
However, the patch I sent allows to handle clickpads which are not
following MS spec, so I think your v3 on top of mine makes sense.

I have a few bike-shedding if you don't mind:

>  drivers/hid/hid-debug.c      |  1 +
>  drivers/hid/hid-multitouch.c | 19 +++++++++++++++++++
>  include/linux/hid.h          |  1 +
>  3 files changed, 21 insertions(+)
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
> index a8bec33f4764..2e5bb788c0eb 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -71,6 +71,10 @@ MODULE_LICENSE("GPL");
>  #define MT_INPUTMODE_TOUCHSCREEN	0x02
>  #define MT_INPUTMODE_TOUCHPAD		0x03
>  
> +#define MT_BUTTONTYPE_DEPRESSIBLE	0
> +#define MT_BUTTONTYPE_NONDEPRESSIBLE	1
> +#define MT_BUTTONTYPE_MAX		MT_BUTTONTYPE_NONDEPRESSIBLE

As mentioned later, just use CLICKPAD and not DEPRESSIBLE.
Also, please use '0x' prefixed values. It does not matter now but I like
having all things which deals with hardware in the hexa form.

> +
>  struct mt_slot {
>  	__s32 x, y, cx, cy, p, w, h;
>  	__s32 contactid;	/* the device ContactID assigned to this slot */
> @@ -116,6 +120,7 @@ struct mt_device {
>  				* 1 means we should use a serial protocol
>  				* > 1 means hybrid (multitouch) protocol */
>  	__u8 buttons_count;	/* number of physical buttons per touchpad */
> +	__u8 buttontype;	/* depressible or non-depressible touchpad */

In the kernel we use button pad. On the user space more likely clickpad,
so I would rather not adding a third denomination for these touchpads.

Also, I would prefer having a is_buttonpad boolean instead of a
buttontype.

This would allow to get rid of MT_BUTTONTYPE_NONDEPRESSIBLE and
MT_BUTTONTYPE_MAX in one shot.

>  	bool serial_maybe;	/* need to check for serial protocol */
>  	bool curvalid;		/* is the current contact valid? */
>  	unsigned mt_flags;	/* flags to pass to input-mt */
> @@ -334,6 +339,16 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  			td->maxcontacts = td->mtclass.maxcontacts;
>  
>  		break;
> +	case HID_DG_BUTTONTYPE:
> +		if (usage->usage_index >= field->report_count) {
> +			dev_err(&hdev->dev, "HID_DG_BUTTONTYPE out of range\n");
> +			break;
> +		}
> +
> +		if (field->value[usage->usage_index] <= MT_BUTTONTYPE_MAX)
> +			td->buttontype = field->value[usage->usage_index];

This can then be replaced by:
		td->is_buttonpad = field->value[usage->usage_index] == MT_BUTTONTYPE_CLICKPAD;

> +
> +		break;
>  	}
>  }
>  
> @@ -734,6 +749,9 @@ static void mt_touch_input_configured(struct hid_device *hdev,
>  
>  	/* check for clickpads */
>  	if ((td->mt_flags & INPUT_MT_POINTER) && (td->buttons_count == 1))
> +		td->buttontype = MT_BUTTONTYPE_DEPRESSIBLE;
> +
> +	if (td->buttontype == MT_BUTTONTYPE_DEPRESSIBLE)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  
>  	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
> @@ -1017,6 +1035,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
>  	td->cc_index = -1;
>  	td->mt_report_id = -1;
> +	td->buttontype = MT_BUTTONTYPE_NONDEPRESSIBLE;

with the boolean, no need to init it to a special value.

Cheers,
Benjamin

>  	hid_set_drvdata(hdev, td);
>  
>  	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
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
