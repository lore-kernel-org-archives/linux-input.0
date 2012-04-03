From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 4/5] hid: Add idtags to modalias
Date: Tue, 3 Apr 2012 10:45:04 +0200
Message-ID: <CAN+gG=F0v1NnBd5G_Z77m3Qf8FuSs5Nj2-W97k=GhFdWmZDiKg@mail.gmail.com>
References: <1333436730-13008-1-git-send-email-rydberg@euromail.se>
	<1333436730-13008-5-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39535 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab2DCIpE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 04:45:04 -0400
In-Reply-To: <1333436730-13008-5-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 3, 2012 at 09:05, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> HID devices are only partially presented to userland. =A0Hotplugged
> devices emit events containing a modalias based on the basic bus,
> vendor and product entities. However, in practise a hid device can
> depend on details such as a single usb interface or a particular item
> in a report descriptor.
>
> This patch adds a special interface tag to the hid device id, and
> broadcasts it using both uevent and modalias. Matching ids are
> introduced for the hid-multitouch driver. As a consequence, generic
> hid will no longer match multitouch devices, and udev will
> automatically load hid-multitouch instead.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 =A0 =A0| =A0 28 +++++++++++++++=
++++++++++---
> =A0drivers/hid/hid-multitouch.c =A0 =A0| =A0 =A07 ++++++-
> =A0include/linux/hid.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +++++++
> =A0include/linux/mod_devicetable.h | =A0 =A02 +-
> =A0scripts/mod/file2alias.c =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A05 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 8a7b59e..1cf6cb5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -205,6 +205,10 @@ static int hid_add_usage(struct hid_parser *pars=
er, unsigned usage)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parser->collection_stack_ptr ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parser->collection_stack[parser->colle=
ction_stack_ptr - 1] : 0;
> =A0 =A0 =A0 =A0parser->local.usage_index++;
> +
> + =A0 =A0 =A0 if (usage =3D=3D HID_DG_CONTACTID)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parser->device->idtags |=3D HID_IDTAG_M=
ULTITOUCH;
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -1154,7 +1158,7 @@ EXPORT_SYMBOL_GPL(hid_input_report);
> =A0static bool hid_match_one_id(struct hid_device *hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct hid_device_id *id)
> =A0{
> - =A0 =A0 =A0 return id->bus =3D=3D hdev->bus &&
> + =A0 =A0 =A0 return id->bus =3D=3D hdev->bus && id->idtags =3D=3D hd=
ev->idtags &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(id->vendor =3D=3D HID_ANY_ID || id->v=
endor =3D=3D hdev->vendor) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(id->product =3D=3D HID_ANY_ID || id->=
product =3D=3D hdev->product);
> =A0}
> @@ -1723,6 +1727,23 @@ static int hid_device_remove(struct device *de=
v)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static ssize_t modalias_show(struct device *dev, struct device_attri=
bute *a,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev =3D container_of(dev, struct hi=
d_device, dev);
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 len =3D snprintf(buf, PAGE_SIZE, "hid:b%04Xi%04Xv%08Xp%=
08X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev->bus, hdev->idtags,=
 hdev->vendor, hdev->product);
> +
> + =A0 =A0 =A0 return (len >=3D PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
> +}
> +
> +static struct device_attribute hid_dev_attrs[] =3D {
> + =A0 =A0 =A0 __ATTR_RO(modalias),
> + =A0 =A0 =A0 __ATTR_NULL,
> +};
> +
> =A0static int hid_uevent(struct device *dev, struct kobj_uevent_env *=
env)
> =A0{
> =A0 =A0 =A0 =A0struct hid_device *hdev =3D container_of(dev, struct h=
id_device, dev);
> @@ -1740,8 +1761,8 @@ static int hid_uevent(struct device *dev, struc=
t kobj_uevent_env *env)
> =A0 =A0 =A0 =A0if (add_uevent_var(env, "HID_UNIQ=3D%s", hdev->uniq))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 if (add_uevent_var(env, "MODALIAS=3Dhid:b%04Xv%08Xp%08X=
",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->bus, hdev->vendor=
, hdev->product))
> + =A0 =A0 =A0 if (add_uevent_var(env, "MODALIAS=3Dhid:b%04Xi%04Xv%08X=
p%08X",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev->bus, hdev-=
>idtags, hdev->vendor, hdev->product))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0return 0;
> @@ -1749,6 +1770,7 @@ static int hid_uevent(struct device *dev, struc=
t kobj_uevent_env *env)
>
> =A0static struct bus_type hid_bus_type =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "hid",
> + =A0 =A0 =A0 .dev_attrs =A0 =A0 =A0=3D hid_dev_attrs,
> =A0 =A0 =A0 =A0.match =A0 =A0 =A0 =A0 =A0=3D hid_bus_match,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D hid_device_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D hid_device_remove,
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 421b16c..80ceab5 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -104,7 +104,7 @@ struct mt_device {
> =A0#define MT_DEFAULT_MAXCONTACT =A010
>
> =A0#define HID_USB_MT_DEVICE(v, p) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> - =A0 =A0 =A0 HID_USB_DEVICE(v, p)
> + =A0 =A0 =A0 .idtags =3D HID_IDTAG_MULTITOUCH, HID_USB_DEVICE(v, p)
>
> =A0/*
> =A0* these device-dependent functions determine what slot corresponds
> @@ -886,6 +886,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_MT_DEVICE(USB_VENDOR_ID_XIROKU=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_XIROKU_C=
SR2) },
>
> + =A0 =A0 =A0 /* Generic MT device */
> + =A0 =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_MT_DEVICE(HID_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_ANY_ID) },

This breaks the mechanism used to detect serial protocol.
A better solution would be to keep .driver_data =3D 0 -> this would tel=
l
us that the device is unknown and that we can override the given
settings.

Thanks,
Benjamin

> +
> =A0 =A0 =A0 =A0{ }
> =A0};
> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 5b3be43..1e68543 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -62,6 +62,12 @@
>
> =A0#define HID_MAX_DESCRIPTOR_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0409=
6
>
> +/*
> + * HID identifying tags extracted from reports
> + */
> +#define HID_IDTAG_MULTITOUCH =A0 =A0 =A0 =A0 =A0 0x0001
> +
> +
> =A0#ifdef __KERNEL__
>
> =A0#include <linux/types.h>
> @@ -473,6 +479,7 @@ struct hid_device { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* dev=
ice report descriptor */
> =A0 =A0 =A0 =A0unsigned maxcollection; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Number of parsed co=
llections */
> =A0 =A0 =A0 =A0unsigned maxapplication; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Number of applicatio=
ns */
> =A0 =A0 =A0 =A0__u16 bus; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* BUS =
ID */
> + =A0 =A0 =A0 __u16 idtags; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Identifying=
 tags extracted from reports */
> =A0 =A0 =A0 =A0__u32 vendor; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Vendor I=
D */
> =A0 =A0 =A0 =A0__u32 product; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Product =
ID */
> =A0 =A0 =A0 =A0__u32 version; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HID vers=
ion */
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devi=
cetable.h
> index 83ac071..25446f0 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -135,7 +135,7 @@ struct usb_device_id {
>
> =A0struct hid_device_id {
> =A0 =A0 =A0 =A0__u16 bus;
> - =A0 =A0 =A0 __u16 pad1;
> + =A0 =A0 =A0 __u16 idtags;
> =A0 =A0 =A0 =A0__u32 vendor;
> =A0 =A0 =A0 =A0__u32 product;
> =A0 =A0 =A0 =A0kernel_ulong_t driver_data
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index b89efe6..d0c3a2b 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -336,10 +336,12 @@ static int do_hid_entry(const char *filename,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_de=
vice_id *id, char *alias)
> =A0{
> =A0 =A0 =A0 =A0id->bus =3D TO_NATIVE(id->bus);
> + =A0 =A0 =A0 id->idtags =3D TO_NATIVE(id->idtags);
> =A0 =A0 =A0 =A0id->vendor =3D TO_NATIVE(id->vendor);
> =A0 =A0 =A0 =A0id->product =3D TO_NATIVE(id->product);
>
> =A0 =A0 =A0 =A0sprintf(alias, "hid:b%04X", id->bus);
> + =A0 =A0 =A0 ADD(alias, "i", true, id->idtags);
> =A0 =A0 =A0 =A0ADD(alias, "v", id->vendor !=3D HID_ANY_ID, id->vendor=
);
> =A0 =A0 =A0 =A0ADD(alias, "p", id->product !=3D HID_ANY_ID, id->produ=
ct);
>
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
