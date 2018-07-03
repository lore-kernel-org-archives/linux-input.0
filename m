From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/4] HID: multitouch: drop reports containing invalid values
Date: Tue, 3 Jul 2018 10:13:54 +0200
Message-ID: <CAO-hwJLPm2UgqYU7CgsqX1CNp5JjHu0mZJp-kZnPmZ2qhi1CxQ@mail.gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Joey,

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Avoid processing reports containing invalid values to reduce
> multitouch input stutter.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index c0654db0b736543ca0..08b50e5908cecdda66 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -694,10 +694,19 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>  {
>         if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
>             td->num_received >= td->num_expected)
>                 return;
>
> +       /* drop invalid values after counting them */
> +       if (td->curdata.x == 0xffff &&
> +                       td->curdata.y == 0xffff &&
> +                       td->curdata.w == 0xffff &&
> +                       td->curdata.h == 0xffff) {

You can't really use plain values like that. There is a tiny chance
these values are valid on an other device.
IIRC, MS spec says that we should ignore out of band values if they
are tagged as such. Such input are tagged with NULL values
(http://www.usb.org/developers/hidpage/HID1_11.pdf page 31) and MS
spec mentioned this.

All in all, if you have this bit set, you need to compare the value
with the logical_max/min for each field.

I never encountered a device that required this, so you are probably
the lucky one :)

Cheers,
Benjamin

> +               td->num_received++;
> +               return;
> +       }
> +
>         if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
>                 int active;
>                 int slotnum = mt_compute_slot(td, input);
>                 struct mt_slot *s = &td->curdata;
>                 struct input_mt *mt = input->mt;
> --
> 2.18.0
>
