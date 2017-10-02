From: Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] HID: usbhid: Add mechanism to blacklist based on device release
Date: Mon, 2 Oct 2017 11:27:59 +0200
Message-ID: <CAP_ceTxAiOU6TByzOcCA4+e=+uzULyteyt6Deg-quBKeiWBMjg@mail.gmail.com>
References: <1506935094-18139-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:56457 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdJBJ2V (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Oct 2017 05:28:21 -0400
Received: by mail-it0-f51.google.com with SMTP id g18so6568020itg.5
        for <linux-input@vger.kernel.org>; Mon, 02 Oct 2017 02:28:21 -0700 (PDT)
In-Reply-To: <1506935094-18139-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Seems a reasonable mechanism for everybody,
Thanks for working it Niels !
Adding my Acked-by and a couple of suggestions.

On Mon, Oct 2, 2017 at 11:04 AM,  <nolsen@jabra.com> wrote:
> From: Niels Skou Olsen <nolsen@jabra.com>
>
> Modify usbhid_exists_squirk() to consider the device release number
> (bcdDevice) of devices marked for HID_QUIRK_IGNORE. This allows for
> conditional blacklisting of devices older than a known good release.
>
> Also, use this mechanism to un-blacklist two Jabra speakerphone devices
> that were blacklisted in 2013, and now have fixed the firmware. These
> devices encode firmware version in bcdDevice.
>
> For reference, see the original blacklist commit:
> Commit 31b9779cb292 ("HID: ignore Jabra speakerphones HID interface")
>
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>


Acked-by: Vincent Palatin <vpalatin@chromium.org>


> ---
>  drivers/hid/hid-core.c          |  2 -
>  drivers/hid/usbhid/hid-core.c   |  7 +++-
>  drivers/hid/usbhid/hid-quirks.c | 86 +++++++++++++++++++++++++++++++++++++----
>  include/linux/hid.h             |  4 +-
>  4 files changed, 87 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9bc9116..b49d7c4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2697,8 +2697,6 @@ static const struct hid_device_id hid_ignore_list[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1006) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1007) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_IMATION, USB_DEVICE_ID_DISC_STAKKA) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_GN9350E) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_KWORLD, USB_DEVICE_ID_KWORLD_RADIO_FM700) },
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 089bad8..2cde551 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -977,7 +977,8 @@ static int usbhid_parse(struct hid_device *hid)
>         int ret, n;
>
>         quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
> -                       le16_to_cpu(dev->descriptor.idProduct));
> +                                    le16_to_cpu(dev->descriptor.idProduct),
> +                                    le16_to_cpu(dev->descriptor.bcdDevice));
>
>         if (quirks & HID_QUIRK_IGNORE)
>                 return -ENODEV;
> @@ -1289,6 +1290,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
>         unsigned int n, has_in = 0;
>         size_t len;
>         int ret;
> +       const u16 bcdDevice = le16_to_cpu(dev->descriptor.bcdDevice);
>
>         dbg_hid("HID probe called for ifnum %d\n",
>                         intf->altsetting->desc.bInterfaceNumber);
> @@ -1319,7 +1321,8 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
>         hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
>         hid->product = le16_to_cpu(dev->descriptor.idProduct);
>         hid->name[0] = 0;
> -       hid->quirks = usbhid_lookup_quirk(hid->vendor, hid->product);
> +       hid->quirks = usbhid_lookup_quirk(hid->vendor, hid->product, bcdDevice);
> +
>         if (intf->cur_altsetting->desc.bInterfaceProtocol ==
>                         USB_INTERFACE_PROTOCOL_MOUSE)
>                 hid->type = HID_TYPE_USBMOUSE;
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index a83fa76..c19b8a8 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -99,6 +99,8 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
> +       { USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410, HID_QUIRK_IGNORE },
> +       { USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C007, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS, HID_QUIRK_NOGET },
> @@ -173,6 +175,27 @@ static const struct hid_blacklist {
>         { 0, 0 }
>  };
>
> +/*
> + * Entries in hid_ignore_by_release[] specify a known good version of a
> + * device. Version is the bcdDevice field of the device descriptor, which
> + * according to the USB spec is defined as a 'device release number'. Some
> + * vendors encode firmware version in this field.
> + *
> + * A device with a HID_QUIRK_IGNORE entry in hid_blacklist[] _and_ an
> + * entry in hid_ignore_by_release[], will have its bcdDevice value checked


Is there really a value in putting it in both lists ? can we put it
only in the latter ?


> + * against the good_release value. If the bcdDevice value is less than
> + * good_release the device is ignored.
> + */
> +static const struct hid_ignore_by_release {
> +       __u16 idVendor;
> +       __u16 idProduct;
> +       __u16 good_release;
> +} hid_ignore_by_release[] = {
> +       { USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410, 0x111 },
> +       { USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510, 0x214 },
> +       { 0, 0 }
> +};


Maybe we should use here 'struct usb_device_id' as done in other drivers.
(and maybe put the flags in  .driver_info)
It conveniently  has a .bcdDevice_lo and .bcdDevice_hi fields.
Then we can use the more generic usb_match_id() function.

> +
>  /* Dynamic HID quirks list - specified at runtime */
>  struct quirks_list_struct {
>         struct hid_blacklist hid_bl_item;
> @@ -335,18 +358,62 @@ void usbhid_quirks_exit(void)
>  }
>
>  /**
> + * usbhid_ignore_based_on_device_release: conditionally ignore based
> + *                                        on bcdDevice
> + *
> + * Description:
> + *
> + *     Given a HID_QUIRK_IGNORE blacklist entry and a bcdDevice value,
> + *     check to see if the bcdDevice is less than a known good release.
> + *
> + * Returns: pointer if the device must be ignored, NULL otherwise
> + */
> +static const struct hid_blacklist *
> +usbhid_ignore_based_on_device_release(const struct hid_blacklist *bl_entry,
> +                                     const u16 bcdDevice)
> +{
> +       const struct hid_ignore_by_release *entry = NULL;
> +       int n = 0;
> +
> +       if (bl_entry == NULL || bl_entry->quirks != HID_QUIRK_IGNORE)
> +               return bl_entry;
> +
> +       for (; hid_ignore_by_release[n].idVendor; n++)
> +               if (hid_ignore_by_release[n].idVendor == bl_entry->idVendor &&
> +                   (hid_ignore_by_release[n].idProduct == (__u16) HID_ANY_ID ||
> +                    hid_ignore_by_release[n].idProduct == bl_entry->idProduct))
> +                       entry = &hid_ignore_by_release[n];
> +
> +       if (entry != NULL) {
> +               if (bcdDevice < entry->good_release)
> +                       /* Go on and let the ignore happen */
> +                       return bl_entry;
> +
> +               /* Override the passed blacklist entry, and allow the device */
> +               return NULL;
> +       }
> +
> +       /* We found no device release based ignore info, so the passed
> +        * HID_QUIRK_IGNORE blacklist entry must be used
> +        */
> +       return bl_entry;
> +}
> +
> +/**
>   * usbhid_exists_squirk: return any static quirks for a USB HID device
>   * @idVendor: the 16-bit USB vendor ID, in native byteorder
>   * @idProduct: the 16-bit USB product ID, in native byteorder
> + * @bcdDevice: the 16-bit USB device release number, in native byteorder
>   *
>   * Description:
> - *     Given a USB vendor ID and product ID, return a pointer to
> - *     the hid_blacklist entry associated with that device.
> + *     Given a USB vendor, product ID, and device release number return a
> + *     pointer to the hid_blacklist entry associated with that device.
>   *
>   * Returns: pointer if quirk found, or NULL if no quirks found.
>   */
>  static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
> -               const u16 idProduct)
> +                                                       const u16 idProduct,
> +                                                       const u16 bcdDevice)
>  {
>         const struct hid_blacklist *bl_entry = NULL;
>         int n = 0;
> @@ -357,6 +424,8 @@ static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
>                                 hid_blacklist[n].idProduct == idProduct))
>                         bl_entry = &hid_blacklist[n];
>
> +       bl_entry = usbhid_ignore_based_on_device_release(bl_entry, bcdDevice);
> +
>         if (bl_entry != NULL)
>                 dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
>                                 bl_entry->quirks, bl_entry->idVendor,
> @@ -368,14 +437,17 @@ static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
>   * usbhid_lookup_quirk: return any quirks associated with a USB HID device
>   * @idVendor: the 16-bit USB vendor ID, in native byteorder
>   * @idProduct: the 16-bit USB product ID, in native byteorder
> + * @bcdDevice: the 16-bit USB device release number, in native byteorder
>   *
>   * Description:
> - *     Given a USB vendor ID and product ID, return any quirks associated
> - *     with that device.
> + *     Given a USB vendor ID, product ID and device release number, return
> + *     any quirks associated with that device.
>   *
>   * Returns: a u32 quirks value.
>   */
> -u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct)
> +u32 usbhid_lookup_quirk(const u16 idVendor,
> +                       const u16 idProduct,
> +                       const u16 bcdDevice)
>  {
>         u32 quirks = 0;
>         const struct hid_blacklist *bl_entry = NULL;
> @@ -389,7 +461,7 @@ u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct)
>         down_read(&dquirks_rwsem);
>         bl_entry = usbhid_exists_dquirk(idVendor, idProduct);
>         if (!bl_entry)
> -               bl_entry = usbhid_exists_squirk(idVendor, idProduct);
> +               bl_entry = usbhid_exists_squirk(idVendor, idProduct, bcdDevice);
>         if (bl_entry)
>                 quirks = bl_entry->quirks;
>         up_read(&dquirks_rwsem);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ab05a86..273795a 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -1096,7 +1096,9 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
>                 int interrupt);
>
>  /* HID quirks API */
> -u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);
> +u32 usbhid_lookup_quirk(const u16 idVendor,
> +                       const u16 idProduct,
> +                       const u16 bcdDevice);
>  int usbhid_quirks_init(char **quirks_param);
>  void usbhid_quirks_exit(void);
>
> --
> 2.7.4
>
