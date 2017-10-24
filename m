From: Hendrik Langer <hendrik.langer@gmx.de>
Subject: Re: [PATCH] HID: rmi: Lenovo X1 Cover touchpad is a buttonpad
Date: Tue, 24 Oct 2017 17:13:58 +0200
Message-ID: <da53c108-5cd7-3d32-970d-d25145765147@gmx.de>
References: <20171019082310.8778-1-consume.noise@gmail.com>
 <CADscph1Cc1dZdBrWi--cgo+MgJvqcXJ=otsHvAfkdUOPOfJtCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:63724 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdJXPOB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 11:14:01 -0400
In-Reply-To: <CADscph1Cc1dZdBrWi--cgo+MgJvqcXJ=otsHvAfkdUOPOfJtCA@mail.gmail.com>
 references: <20171019082310.8778-1-consume.noise@gmail.com>
Content-Language: de-DE
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <consume.noise@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hey Daniel, thanks for forwarding this to me.

On 10/19/2017 10:23, Daniel Martin wrote:
> Atm. the touchpad is not tagged as buttonpad. Due to the lack of it,
> RMI F30 adds 3 buttons (BTN_LEFT, BTN_RIGHT and BTN_MIDDLE).
> 
> On the very first click after a boot one can see with evemu-record:
> ...
> E: 0.084899 0001 0110 0001  # EV_KEY / BTN_LEFT             1
> E: 0.084899 0001 0111 0001  # EV_KEY / BTN_RIGHT            1
> ...
> Then BTN_LEFT gets released, but there's no release of BTN_RIGHT. With
> this stuck button further clicks don't work until you switch the VT and
> back (X-Server, xf86-input-synaptics). There're no occurences of
> BTN_RIGHT after a VT switch.
>
> Fix this by tagging the device as buttonpad.

I'm sorry, i'm not an expert on this so i can't make a statement about
the code. But i tested this and i can confirm the annoying behaviour
where the BTN_RIGHT gets stuck is now gone with this patch.
Didn't observe any negative side effects.

evemu-record shows the same changes on my x1 tablet and the device is
now tagged as buttonpad.

If this is enough you can consider this patch
Tested-by: Hendrik Langer <hendrik.langer@gmx.de>

>  The changed report looks
> like:
> --- evemu-record-tm3203-003-wrong.log
> +++ evemu-record-tm3203-003-fixed.log
> @@ -22,8 +22,6 @@
>  #     Event code 14 ((null))
>  #   Event type 1 (EV_KEY)
>  #     Event code 272 (BTN_LEFT)
> -#     Event code 273 (BTN_RIGHT)
> -#     Event code 274 (BTN_MIDDLE)
>  #     Event code 325 (BTN_TOOL_FINGER)
>  #     Event code 330 (BTN_TOUCH)
>  #     Event code 333 (BTN_TOOL_DOUBLETAP)
> @@ -116,15 +114,16 @@
>  #       Resolution 0
>  # Properties:
>  #   Property  type 0 (INPUT_PROP_POINTER)
> +#   Property  type 2 (INPUT_PROP_BUTTONPAD)
>  N: Synaptics TM3203-003
>  I: 0003 17ef 6085 0111
> -P: 01 00 00 00 00 00 00 00
> +P: 05 00 00 00 00 00 00 00
>  B: 00 0b 00 00 00 00 00 00 00
>  B: 01 00 00 00 00 00 00 00 00
>  B: 01 00 00 00 00 00 00 00 00
>  B: 01 00 00 00 00 00 00 00 00
>  B: 01 00 00 00 00 00 00 00 00
> -B: 01 00 00 07 00 00 00 00 00
> +B: 01 00 00 01 00 00 00 00 00
>  B: 01 20 e4 00 00 00 00 00 00
>  B: 01 00 00 00 00 00 00 00 00
>  B: 01 00 00 00 00 00 00 00 00
> 
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---
>  drivers/hid/hid-rmi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index ef241d66562e..e4937deef723 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -39,6 +39,7 @@
>  /* device flags */
>  #define RMI_DEVICE                     BIT(0)
>  #define RMI_DEVICE_HAS_PHYS_BUTTONS    BIT(1)
> +#define RMI_DEVICE_IS_BUTTONPAD                BIT(2)
> 
>  /*
>   * retrieve the ctrl registers
> @@ -692,6 +693,9 @@ static int rmi_probe(struct hid_device *hdev,
> const struct hid_device_id *id)
> 
>         if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
>                 rmi_hid_pdata.f30_data.disable = true;
> +       else
> +       if (data->device_flags & RMI_DEVICE_IS_BUTTONPAD)
> +               rmi_hid_pdata.f30_data.buttonpad = true;
> 
>         data->xport.dev = hdev->dev.parent;
>         data->xport.pdata = rmi_hid_pdata;
> @@ -723,7 +727,8 @@ static void rmi_remove(struct hid_device *hdev)
>  static const struct hid_device_id rmi_id[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14),
>                 .driver_data = RMI_DEVICE_HAS_PHYS_BUTTONS },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER),
> +               .driver_data = RMI_DEVICE_IS_BUTTONPAD },
>         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_RMI, HID_ANY_ID, HID_ANY_ID) },
>         { }
>  };
> --
> 2.13.6
>
