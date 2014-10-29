From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mfd: stmpe: add pull up/down register offsets for STMPE
Date: Wed, 29 Oct 2014 10:55:14 +0100
Message-ID: <CACRpkdbsswGBy69+EGJTbTpxD7j2FnruyGdyUZRBVtt-JaScfg@mail.gmail.com>
References: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
	<20141020064605.GB25349@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:56325 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbaJ2JzP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2014 05:55:15 -0400
Received: by mail-ig0-f179.google.com with SMTP id r10so2780944igi.6
        for <linux-input@vger.kernel.org>; Wed, 29 Oct 2014 02:55:14 -0700 (PDT)
In-Reply-To: <20141020064605.GB25349@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

On Mon, Oct 20, 2014 at 8:46 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 18 Oct 2014, Linus Walleij wrote:
>
>> This adds the register offsets for pull up/down for the STMPE
>> 1601, 1801 and 24xx expanders. This is used to bias GPIO lines
>> and keypad lines.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi Sam, Lee: I think you should just ACK this so Dmitry can take the
>> patch series through the input tree, where the registers need to be
>> used to enable the keypad on the STMPE2401.
>> ---
>>  drivers/mfd/stmpe.c       | 4 ++++
>>  drivers/mfd/stmpe.h       | 3 +++
>>  include/linux/mfd/stmpe.h | 2 ++
>>  3 files changed, 9 insertions(+)
>
> Does this need to go in with the other patches in the set?
>
> I'm _guessing_ that, as you've sent them separately, they can be
> applied separately?

No sorry if it was unclear, the series need to go in toghether.
So this patch adds some infrastructure to the MFD device which
is then utilized by the input driver in a later patch.

> This needs to go in via MFD, but for my own reference:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Dmitry can you merge this & the rest with Lee's ACK?

Yours,
Linus Walleij
