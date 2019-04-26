From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: input: add mapping for KEY_KBD_LAYOUT_NEXT
Date: Fri, 26 Apr 2019 08:38:29 +0200
Message-ID: <CAO-hwJ+=n0Nh7XbcWRLeO5ay43YVwWK6vmMB=A5H23JKCWCUtg@mail.gmail.com>
References: <20190425163846.51730-1-dmitry.torokhov@gmail.com> <20190425163846.51730-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425163846.51730-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, gwink@chromium.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 25, 2019 at 6:38 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> HUTRR56 defined a new usage code on consumer page to cycle through
> set of keyboard layouts, let's add this mapping.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I don't think this will collide with the HID tree, so IMO, you can
take this through yours if you want.

Cheers,
Benjamin

>  drivers/hid/hid-input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index b607286a0bc8..0579b8d3f912 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1051,6 +1051,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case 0x28b: map_key_clear(KEY_FORWARDMAIL);     break;
>                 case 0x28c: map_key_clear(KEY_SEND);            break;
>
> +               case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT); break;
> +
>                 case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);             break;
>                 case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);             break;
>                 case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);                break;
> --
> 2.21.0.593.g511ec345e18-goog
>
