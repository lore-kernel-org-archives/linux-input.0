From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mfd: stmpe: add pull up/down register offsets for STMPE
Date: Mon, 3 Nov 2014 10:27:08 +0100
Message-ID: <CACRpkdYNBZdB14fjj0LnQ8GchaGLTgfpvxhe4J9nc3XF80dFgQ@mail.gmail.com>
References: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
	<20141020064605.GB25349@x1>
	<CACRpkdbsswGBy69+EGJTbTpxD7j2FnruyGdyUZRBVtt-JaScfg@mail.gmail.com>
	<58957675.Bh6LToE4gg@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58957675.Bh6LToE4gg@dtor-glaptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 29, 2014 at 8:31 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wednesday, October 29, 2014 10:55:14 AM Linus Walleij wrote:
>> On Mon, Oct 20, 2014 at 8:46 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Sat, 18 Oct 2014, Linus Walleij wrote:
>> >> This adds the register offsets for pull up/down for the STMPE
>> >> 1601, 1801 and 24xx expanders. This is used to bias GPIO lines
>> >> and keypad lines.
>> >>
>> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> >> ---
>> >> Hi Sam, Lee: I think you should just ACK this so Dmitry can take the
>> >> patch series through the input tree, where the registers need to be
>> >> used to enable the keypad on the STMPE2401.
>> >> ---
>> >>
>> >>  drivers/mfd/stmpe.c       | 4 ++++
>> >>  drivers/mfd/stmpe.h       | 3 +++
>> >>  include/linux/mfd/stmpe.h | 2 ++
>> >>  3 files changed, 9 insertions(+)
>> >
>> > Does this need to go in with the other patches in the set?
>> >
>> > I'm _guessing_ that, as you've sent them separately, they can be
>> > applied separately?
>>
>> No sorry if it was unclear, the series need to go in toghether.
>> So this patch adds some infrastructure to the MFD device which
>> is then utilized by the input driver in a later patch.
>>
>> > This needs to go in via MFD, but for my own reference:
>> >
>> > Acked-by: Lee Jones <lee.jones@linaro.org>
>>
>> Dmitry can you merge this & the rest with Lee's ACK?
>
> I'd be delighted, but it _sounded_ like Lee wanted it to go though MFD?

Lee, can Dmitry take these through input?

Yours,
Linus Walleij
