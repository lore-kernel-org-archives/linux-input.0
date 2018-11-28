From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH 8/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Wed, 28 Nov 2018 15:03:13 -0800
Message-ID: <CA+jURcs30_4Lw0ZvAj2C_XG9TjSNfJs6AKtw+TmZdSE+_ithfQ@mail.gmail.com>
References: <20181122063409.15816-1-peter.hutterer@who-t.net> <20181122063409.15816-9-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122063409.15816-9-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Hi Peter,

Thanks for the work you've put into this!

On Wed, 21 Nov 2018 at 22:35, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> * HID++ 1.0: Anywhere MX, Performance MX
> * x2120: M560
> * x2121: MX Anywhere 2, MX Master 2S
> [snip]
> This was tested on an MX Anywhere 2S, Harry, please re-test on the other
> mice, thanks.

Sure, I've tested the V2 patch with the original five mice quoted
above, as well as the M325, which doesn't have a high-resolution wheel
but which I used to check that it still reports a REL_WHEEL_HI_RES
axis and reports movements of 120 on it.

The only issue I noticed is that the M560 doesn't report a
REL_HWHEEL_HI_RES axis, even though it has horizontal tilt scrolling.
(The M325 also has horizontal tilt scrolling and does report a
REL_HWHEEL_HI_RES axis.) This is probably because the M560 has a lot
of special treatment in the driver (see `m560_populate_input` and
`m560_raw_event` in particular).

Other than that:
Verified-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team
