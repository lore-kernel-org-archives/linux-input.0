From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to
 MT_CLS_WIN_8 quirks
Date: Tue, 3 Jul 2018 09:53:19 +0200
Message-ID: <CAO-hwJ+1PEH7VJjQThoihqBUK0yVNvak78GEiAZ7VpDEQ5EFiQ@mail.gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> The firmware found in the touch screen of the Surface Pro 3 is slightly
> buggy and occasionally doesn't send lift off reports for contacts; add
> MT_QUIRK_NOT_SEEN_MEANS_UP to .quirks to compensate for the missed
> reports.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 45968f7970f87775fa..a793076139d7d0db9b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -242,11 +242,12 @@ static struct mt_class mt_classes[] = {
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
>                         MT_QUIRK_IGNORE_DUPLICATES |
>                         MT_QUIRK_HOVERING |
>                         MT_QUIRK_CONTACT_CNT_ACCURATE |
>                         MT_QUIRK_STICKY_FINGERS |
> -                       MT_QUIRK_WIN8_PTP_BUTTONS },
> +                       MT_QUIRK_WIN8_PTP_BUTTONS |
> +                       MT_QUIRK_NOT_SEEN_MEANS_UP },

NACK on this.
If the Surface has a buggy firmware, we should handle it as a special
case, not as a common failure.
Also, I am not sure this quirk is compatible with Win 8 specification.
Last, we now have a timeout for unreleased touches, so I really don't
think you need that in recent kernels.

Cheers,
Benjamin

>         { .name = MT_CLS_EXPORT_ALL_INPUTS,
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
>                         MT_QUIRK_CONTACT_CNT_ACCURATE,
>                 .export_all_inputs = true },
>         { .name = MT_CLS_WIN_8_DUAL,
> --
> 2.18.0
>
