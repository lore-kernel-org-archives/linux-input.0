From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/3] HID: hid-penmount can support multi-touch devices
Date: Wed, 19 Aug 2015 09:44:49 -0400
Message-ID: <CAN+gG=Gfg9FgpEyZGfvHnRT4frJGkxgVHRKmCeTeHVF-yT3fzQ@mail.gmail.com>
References: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35898 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbHSNov (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 09:44:51 -0400
In-Reply-To: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Sung <penmount.touch@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 19, 2015 at 3:29 AM, John Sung <penmount.touch@gmail.com> wrote:
> Expand the functionality of hid-penmount to support both PenMount 6000
> and PCI devices.

Could you elaborate a little bit more here? From the look of your
code, I think your panels should be handled by hid-multitouch directly
and I really don't see the point of adding a duplicate of the code in
this particular driver.

Cheers,
Benjamin

>
> Signed-off-by: John Sung <penmount.touch@gmail.com>
> ---
>  drivers/hid/hid-core.c     |    1 +
>  drivers/hid/hid-penmount.c |  242 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 242 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index bcd914a..32b2226 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1955,6 +1955,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_PCI) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
> diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
> index c11dce8..68c5721 100644
> --- a/drivers/hid/hid-penmount.c
> +++ b/drivers/hid/hid-penmount.c
> @@ -2,6 +2,7 @@
>   *  HID driver for PenMount touchscreens
>   *
>   *  Copyright (c) 2014 Christian Gmeiner <christian.gmeiner <at> gmail.com>
> + *  Copyright (c) 2015 John Sung <penmount.touch <at> gmail.com>
>   *
>   *  based on hid-penmount copyrighted by
>   *    PenMount Touch Solutions <penmount <at> seed.net.tw>
> @@ -16,22 +17,255 @@
>
>  #include <linux/module.h>
>  #include <linux/hid.h>
> +#include <linux/version.h>
> +#include <linux/input/mt.h>
>  #include "hid-ids.h"
>
> +#define PM_MAX_CONTACT         10
> +#define PM_DEF_CONTACT_PCI     5
> +#define PM_DEF_CONTACT_6000    1
> +
> +struct mt_slot {
> +       unsigned char id;
> +       unsigned short x, y;
> +       unsigned char active; /* is the touch valid? */
> +       unsigned char updated;
> +};
> +
> +struct penmount {
> +       unsigned short model;
> +       struct hid_device *hid;
> +       struct input_dev *input;
> +       unsigned char maxcontacts;
> +       struct mt_slot slots[PM_MAX_CONTACT];
> +       struct mt_slot curdata;
> +};
> +
> +static void penmount_send_event(struct penmount *pm)
> +{
> +       int i;
> +
> +       for (i = 0; i < pm->maxcontacts; ++i) {
> +               input_mt_slot(pm->input, i);
> +               input_mt_report_slot_state(pm->input, MT_TOOL_FINGER,
> +                               pm->slots[i].active);
> +               if (pm->slots[i].active) {
> +                       input_event(pm->input, EV_ABS, ABS_MT_POSITION_X,
> +                               pm->slots[i].x);
> +                       input_event(pm->input, EV_ABS, ABS_MT_POSITION_Y,
> +                               pm->slots[i].y);
> +               }
> +       }
> +
> +       input_mt_report_pointer_emulation(pm->input, true);
> +       input_sync(pm->input);
> +}
> +
> +static void penmount_process_event(struct penmount *pm)
> +{
> +       unsigned char i = 0;
> +
> +       if (pm->curdata.id >= PM_MAX_CONTACT)
> +               return;
> +
> +       pm->slots[pm->curdata.id].active = pm->curdata.active;
> +       pm->slots[pm->curdata.id].x = pm->curdata.x;
> +       pm->slots[pm->curdata.id].y = pm->curdata.y;
> +
> +       if ((!pm->slots[pm->curdata.id].updated) && (pm->curdata.active)) {
> +               pm->slots[pm->curdata.id].updated = 1;
> +               return;
> +       }
> +
> +       penmount_send_event(pm);
> +       for (i = 0; i < PM_MAX_CONTACT; i++)
> +               pm->slots[pm->curdata.id].updated = 0;
> +}
> +
> +static int penmount_event(struct hid_device *hdev, struct hid_field *field,
> +               struct hid_usage *usage, __s32 value)
> +{
> +       struct penmount *pm = (struct penmount *) hid_get_drvdata(hdev);
> +
> +       if (pm == NULL)
> +               return 0;
> +
> +       if (pm->model == USB_DEVICE_ID_PENMOUNT_6000) {
> +               /* Fallback to the generic hidinput handling */
> +               return 0;
> +       }
> +
> +       if (hdev->claimed & HID_CLAIMED_INPUT) {
> +               switch (usage->hid) {
> +               case HID_DG_CONTACTID:
> +                       pm->curdata.id = value;
> +                       break;
> +               case HID_DG_TIPSWITCH:
> +                       pm->curdata.active = value;
> +                       break;
> +               case HID_GD_X:
> +                       pm->curdata.x = value;
> +                       break;
> +               case HID_GD_Y:
> +                       pm->curdata.y = value;
> +                       penmount_process_event(pm);
> +                       break;
> +               default:
> +                       /* Fallback to the generic hidinput handling */
> +                       return 0;
> +               }
> +       }
> +
> +       if ((hdev->claimed & HID_CLAIMED_HIDDEV) && (hdev->hiddev_hid_event))
> +               hdev->hiddev_hid_event(hdev, field, usage, value);
> +
> +       return 1;
> +}
> +
>  static int penmount_input_mapping(struct hid_device *hdev,
>                 struct hid_input *hi, struct hid_field *field,
>                 struct hid_usage *usage, unsigned long **bit, int *max)
>  {
> -       if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
> +       struct penmount *pm = (struct penmount *) hid_get_drvdata(hdev);
> +
> +       switch (usage->hid) {
> +       case HID_GD_X:
> +               if (pm->maxcontacts > 1) {
> +                       hid_map_usage(hi, usage, bit, max, EV_ABS,
> +                               ABS_MT_POSITION_X);
> +                       input_set_abs_params(hi->input, ABS_MT_POSITION_X,
> +                               field->logical_minimum, field->logical_maximum,
> +                               0, 0);
> +               }
> +               hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_X);
> +               input_set_abs_params(hi->input, ABS_X, field->logical_minimum,
> +                               field->logical_maximum, 0, 0);
> +               return 1;
> +       case HID_GD_Y:
> +               if (pm->maxcontacts > 1) {
> +                       hid_map_usage(hi, usage, bit, max, EV_ABS,
> +                               ABS_MT_POSITION_Y);
> +                       input_set_abs_params(hi->input, ABS_MT_POSITION_Y,
> +                               field->logical_minimum, field->logical_maximum,
> +                               0, 0);
> +               }
> +               hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Y);
> +               input_set_abs_params(hi->input, ABS_Y, field->logical_minimum,
> +                               field->logical_maximum, 0, 0);
> +               return 1;
> +       case HID_UP_BUTTON | 0x0001:
> +       case HID_DG_TIPSWITCH:
>                 hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> +               input_set_capability(hi->input, EV_KEY, BTN_TOUCH);
>                 return 1;
> +       case HID_DG_CONTACTID:
> +               input_mt_init_slots(hi->input, pm->maxcontacts,
> +                       INPUT_MT_DIRECT);
> +               return 1;
> +       default:
> +       case HID_UP_BUTTON | 0x0002:
> +               /* Ignore PenMount 6000 button 2, its value is always 0. */
> +               return -1;
>         }
>
>         return 0;
>  }
>
> +static int penmount_input_mapped(struct hid_device *hdev, struct hid_input *hi,
> +               struct hid_field *field, struct hid_usage *usage,
> +               unsigned long **bit, int *max)
> +{
> +       if (usage->type == EV_KEY || usage->type == EV_ABS)
> +               set_bit(usage->type, hi->input->evbit);
> +
> +       return -1;
> +}
> +
> +
> +static void penmount_feature_mapping(struct hid_device *hdev,
> +               struct hid_field *field, struct hid_usage *usage)
> +{
> +       struct penmount *pm = (struct penmount *) hid_get_drvdata(hdev);
> +
> +       if (pm == NULL)
> +               return;
> +
> +       switch (usage->hid) {
> +       case HID_DG_CONTACTMAX:
> +               pm->maxcontacts = field->value[0];
> +               /* field->value[0] value can be 0, in this case, use the
> +                       maximum value. */
> +               if (!pm->maxcontacts)
> +                       pm->maxcontacts = field->logical_maximum;
> +               break;
> +       }
> +}
> +
> +static int penmount_probe(struct hid_device *hdev,
> +               const struct hid_device_id *id)
> +{
> +       struct penmount *pm = NULL;
> +       struct hid_input *hidinput = NULL;
> +       int ret = 0;
> +
> +       pm = kmalloc(sizeof(struct penmount), GFP_KERNEL | __GFP_ZERO);
> +       if (pm == NULL)
> +               return -ENOMEM;
> +
> +       hid_set_drvdata(hdev, pm);
> +       pm->hid = hdev;
> +       pm->model = id->product;
> +       switch (id->product) {
> +       case USB_DEVICE_ID_PENMOUNT_PCI:
> +               pm->maxcontacts = PM_DEF_CONTACT_PCI;
> +               break;
> +       default:
> +       case USB_DEVICE_ID_PENMOUNT_6000:
> +               pm->maxcontacts = PM_DEF_CONTACT_6000;
> +               break;
> +       }
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "Failed to parse HID report !(%d)\n", ret);
> +               kfree(pm);
> +               return ret;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "Failed to start device !(%d)\n", ret);
> +               kfree(pm);
> +               return ret;
> +       }
> +
> +       hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
> +       if (hidinput != NULL) {
> +               pm->input = hidinput->input;
> +               set_bit(INPUT_PROP_DIRECT, hidinput->input->propbit);
> +       }
> +
> +       hid_info(hdev, "Device supports %d touch contacts !\n",
> +               pm->maxcontacts);
> +       return ret;
> +}
> +
> +static void penmount_remove(struct hid_device *hdev)
> +{
> +       struct penmount *pm = NULL;
> +
> +       pm = hid_get_drvdata(hdev);
> +       if (pm != NULL) {
> +               kfree(pm);
> +               hid_set_drvdata(hdev, NULL);
> +       }
> +
> +       hid_hw_stop(hdev);
> +}
> +
>  static const struct hid_device_id penmount_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_PCI) },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, penmount_devices);
> @@ -40,10 +274,16 @@ static struct hid_driver penmount_driver = {
>         .name = "hid-penmount",
>         .id_table = penmount_devices,
>         .input_mapping = penmount_input_mapping,
> +       .input_mapped = penmount_input_mapped,
> +       .feature_mapping = penmount_feature_mapping,
> +       .probe = penmount_probe,
> +       .remove = penmount_remove,
> +       .event = penmount_event,
>  };
>
>  module_hid_driver(penmount_driver);
>
>  MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
> +MODULE_AUTHOR("John Sung <penmount.touch@gmail.com>");
>  MODULE_DESCRIPTION("PenMount HID TouchScreen driver");
>  MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
