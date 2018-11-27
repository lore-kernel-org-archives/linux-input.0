From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
Date: Mon, 26 Nov 2018 18:30:04 -0800
Message-ID: <CAHk-=widz0eGFuV=bPdXenOEipZg-OTjhfownHUM7gwiZ=4tHw@mail.gmail.com>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net> <20181122232839.GA10747@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122232839.GA10747@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 22, 2018 at 3:28 PM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> The device sends hi-res values of 4, so it should end up as REL_WHEEL_HI_RES
> 30. We are getting 28 instead which doesn't add up to a nice 120.

I think you're just doing the math in the wrong order.

Why don't you just do

    update = val * 120 / multiplier

which gives you the expected "30".

It seems you have done the "120 / multiplier" too early, and you force
that value into "wheel_factor". Don't. Do all the calculations
(including all the accumulated ones) in the original values, and only
do the "multiply by 120 and divide by multiplier" at the very end.

Hmm?

              Linus
