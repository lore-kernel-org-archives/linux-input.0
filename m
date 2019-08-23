From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] hid-logitech-dj: add the new Lightspeed receiver
Date: Fri, 23 Aug 2019 12:06:51 +0200
Message-ID: <CAO-hwJJ2kFoAp8at_a+KRfjivZ2VnbNDXsx=BBQbiEDLZ==3Sg@mail.gmail.com>
References: <20190730122458.5275-1-lains@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730122458.5275-1-lains@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 30, 2019 at 2:26 PM Filipe Laíns <lains@archlinux.org> wrote:
>
> This patchs adds the new Lightspeed receiver. Currently it seems to only
> be used in the G305.
>
> Signed-off-by: Filipe Laíns <lains@archlinux.org>

Applied to for-5.4/logitech

Cheers,
Benjamin

> ---
>  drivers/hid/hid-ids.h         |  3 ++-
>  drivers/hid/hid-logitech-dj.c | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index fb19eefbc0b3..61b954fcfc2e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -768,7 +768,8 @@
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER           0xc52f
>  #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2     0xc532
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2         0xc534
> -#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED        0xc539
> +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1      0xc539
> +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1    0xc53f
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY 0xc53a
>  #define USB_DEVICE_ID_SPACETRAVELLER   0xc623
>  #define USB_DEVICE_ID_SPACENAVIGATOR   0xc626
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 4a68960b131f..d718f01f56d3 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -968,7 +968,12 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>                 logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>                 break;
>         case 0x0c:
> -               device_type = "eQUAD Lightspeed";
> +               device_type = "eQUAD Lightspeed 1";
> +               logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
> +               workitem.reports_supported |= STD_KEYBOARD;
> +               break;
> +       case 0x0d:
> +               device_type = "eQUAD Lightspeed 1_1";
>                 logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>                 workitem.reports_supported |= STD_KEYBOARD;
>                 break;
> @@ -1832,7 +1837,11 @@ static const struct hid_device_id logi_dj_receivers[] = {
>          .driver_data = recvr_type_hidpp},
>         { /* Logitech lightspeed receiver (0xc539) */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> -               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED),
> +               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1),
> +        .driver_data = recvr_type_gaming_hidpp},
> +       { /* Logitech lightspeed receiver (0xc53f) */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1),
>          .driver_data = recvr_type_gaming_hidpp},
>         { /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
> --
> 2.22.0
