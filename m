From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 1/2] HID: add hid_type
Date: Sun, 19 Oct 2008 12:08:01 -0700
Message-ID: <dd18b0c30810191208p62bc8b1eub53b79de2d2d6261@mail.gmail.com>
References: <1224425749-22652-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752021AbYJSTIT@vger.kernel.org>
In-Reply-To: <1224425749-22652-1-git-send-email-jirislaby@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Noonan <steven@uplinklabs.net>, Sven Anders <anders@anduras.de>, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 19, 2008 at 7:15 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
> Add type to the hid structure to distinguish to which device type
> (mouse/kbd) we are talking to. Needed for per device type ignore
> list support.
>
> Note: this patch leaves the type as unknown for bluetooth devices,
> there is not support for this in the hidp code.
>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c |    8 ++++++++
>  include/linux/hid.h           |    7 +++++++
>  2 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 1d3b8a3..20617d8 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -972,6 +972,14 @@ static int hid_probe(struct usb_interface *intf, const struct usb_device_id *id)
>        hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
>        hid->product = le16_to_cpu(dev->descriptor.idProduct);
>        hid->name[0] = 0;
> +       switch (intf->cur_altsetting->desc.bInterfaceProtocol) {
> +       case USB_INTERFACE_PROTOCOL_KEYBOARD:
> +               hid->type = HID_TYPE_KEYBOARD;
> +               break;
> +       case USB_INTERFACE_PROTOCOL_MOUSE:
> +               hid->type = HID_TYPE_MOUSE;
> +               break;
> +       }
>
>        if (dev->manufacturer)
>                strlcpy(hid->name, dev->manufacturer, sizeof(hid->name));
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index f13bca2..36a3953 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -417,6 +417,12 @@ struct hid_input {
>        struct input_dev *input;
>  };
>
> +enum hid_type {
> +       HID_TYPE_UNKNOWN = 0,
> +       HID_TYPE_MOUSE,
> +       HID_TYPE_KEYBOARD
> +};
> +
>  struct hid_driver;
>  struct hid_ll_driver;
>
> @@ -431,6 +437,7 @@ struct hid_device {                                                 /* device report descriptor */
>        __u32 vendor;                                                   /* Vendor ID */
>        __u32 product;                                                  /* Product ID */
>        __u32 version;                                                  /* HID version */
> +       enum hid_type type;                                             /* device type (mouse, kbd, ...) */
>        unsigned country;                                               /* HID country */
>        struct hid_report_enum report_enum[HID_REPORT_TYPES];
>
> --
> 1.6.0.2
>
>

O.k. reverted the old patch and
applied the two new ones.
appletouchpad is working;
I didn't use patch -p1,
just manually applied the two.

-- 
Justin P. Mattock
