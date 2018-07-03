From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/4] HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8
 for serial protocol
Date: Tue, 3 Jul 2018 10:16:01 +0200
Message-ID: <CAO-hwJJpAfvvP+s9Cqmi8v7pHsEw3tKTrySQaEg8TUzPTFcQfA@mail.gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> The HID_GROUP_MULTITOUCH_WIN_8 group never needs to check for the serial
> protocol, so avoid setting `td->serial_maybe = true;` in order to avoid
> an unnecessary mt_post_parse_default_settings() call
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index a793076139d7d0db9b..c0654db0b736543ca0 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1460,11 +1460,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (!td->fields) {
>                 dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
>                 return -ENOMEM;
>         }
>
> -       if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
> +       if (id->vendor == HID_ANY_ID
> +                       && id->product == HID_ANY_ID
> +                       && id->group != HID_GROUP_MULTITOUCH_WIN_8)

There is a tiny difference between the HID group (this device looks
like it is used as a Win 8 device) and the device class (this is
effectively a Win8 device)

It makes sense to remove this check for Win8 devices, but I don't
think it should be done for all devices.

All in all, it won't change much.

Cheers,
Benjamin

>                 td->serial_maybe = true;
>
>         /* This allows the driver to correctly support devices
>          * that emit events over several HID messages.
>          */
> --
> 2.18.0
>
