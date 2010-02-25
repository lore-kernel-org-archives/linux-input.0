From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - re-add thaw (and add freeze)
Date: Wed, 24 Feb 2010 23:38:49 -0800
Message-ID: <201002242338.49873.dmitry.torokhov@gmail.com>
References: <4B69C7AA.7000904@tuffmail.co.uk> <20100216172233.GA14229@core.coreip.homeip.net> <20100225070302.GB1601@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64548 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0BYHiy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Feb 2010 02:38:54 -0500
In-Reply-To: <20100225070302.GB1601@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Wednesday 24 February 2010 11:03:03 pm Pavel Machek wrote:
> On Tue 2010-02-16 09:22:33, Dmitry Torokhov wrote:
> > On Tue, Feb 16, 2010 at 04:48:30PM +0000, Alan Jenkins wrote:
> > > On 2/4/10, Alan Jenkins <alan-jenkins@tuffmail.co.uk> wrote:
> > > > Dmitry Torokhov wrote:
> > > >> On Wed, Feb 03, 2010 at 06:59:54PM +0000, Alan Jenkins wrote:
> > > >>> 633aae2 "Input: i8042 - switch to using dev_pm_ops"
> > > >>> removed handling for PMSG_THAW, causing obscure breakage.
> > > >>> 
> > > >>> It can break if you press keys during hibernation,
> > > >>> which causes subsequent keypresses to be lost -
> > > >>> so you can't cancel s2disk by pressing backspace -
> > > >>> and then just before system poweroff you get
> > > >>> "psmouse.c: Failed to deactivate mouse".
> > > >>> 
> > > >>> So let's add the thaw handler back.
> > > >>> 
> > > >>> Also set the freeze handler.  It looks like PMSG_FREEZE
> > > >>> didn't do anything in the past, but I think that must
> > > >>> have been an oversight.
> > > >> 
> > > >> We do not need to do anything special at freeze time that is why
> > > >> there wasn't freeze handler. And so thaw should be pretty much noop
> > > >> as well.
> > > 
> > > Ok, so I did some more mindless fiddling.  It seems that all it needs
> > > is to call the interrupt handler at thaw time.
> > 
> > Yep, this makes more sense. If you happen to press the key(s) while
> > interrupts are off the keyboard controller becomes "jammed". Your sign
> > off please?
> 
> Dmitry wants your Signed-off-by: line, to easily apply the patch.
>

Pavel, I already have it and it is in mainline.

Thanks.

-- 
Dmitry
