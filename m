From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] mfd: stmpe: add pull up/down register offsets for
 STMPE
Date: Fri, 24 Oct 2014 14:42:06 -0700
Message-ID: <20141024214206.GG19933@dtor-ws>
References: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
 <20141020064605.GB25349@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60782 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaJXVmL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 17:42:11 -0400
Content-Disposition: inline
In-Reply-To: <20141020064605.GB25349@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Oct 20, 2014 at 07:46:05AM +0100, Lee Jones wrote:
> On Sat, 18 Oct 2014, Linus Walleij wrote:
> 
> > This adds the register offsets for pull up/down for the STMPE
> > 1601, 1801 and 24xx expanders. This is used to bias GPIO lines
> > and keypad lines.
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Hi Sam, Lee: I think you should just ACK this so Dmitry can take the
> > patch series through the input tree, where the registers need to be
> > used to enable the keypad on the STMPE2401.
> > ---
> >  drivers/mfd/stmpe.c       | 4 ++++
> >  drivers/mfd/stmpe.h       | 3 +++
> >  include/linux/mfd/stmpe.h | 2 ++
> >  3 files changed, 9 insertions(+)
> 
> Does this need to go in with the other patches in the set?
> 
> I'm _guessing_ that, as you've sent them separately, they can be
> applied separately?
> 
> This needs to go in via MFD, but for my own reference:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

The new register definitions are needed for patch #3.  If you insist on
this going through MFD then please take the other 2 patches with my Ack
through MFD tree as well I do not think we need the whole song and dance
trying to synchronize 2 trees.

Thanks.

-- 
Dmitry
