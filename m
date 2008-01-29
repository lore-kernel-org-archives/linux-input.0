From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 1/12] pxa: rename the pxa27x_keyboard to pxa27x_keypad
Date: Tue, 29 Jan 2008 02:22:47 -0500
Message-ID: <200801290222.48095.dtor@insightbb.com>
References: <f17812d70801222316w52070845r123fd9b54bb27b36@mail.gmail.com> <200801290126.01530.dtor@insightbb.com> <f17812d70801282257x573f2aehd808589344f13f9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxsf03.insightbb.com ([74.128.0.64]:2449 "EHLO
	mxsf03.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbYA2HWt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 02:22:49 -0500
In-Reply-To: <f17812d70801282257x573f2aehd808589344f13f9d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org

On Tuesday 29 January 2008 01:57, eric miao wrote:
> On Jan 29, 2008 2:26 PM, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > Hi Eric,
> >
> > On Wednesday 23 January 2008 02:16, eric miao wrote:
> > > Subject: [PATCH] pxa: rename the pxa27x_keyboard to pxa27x_keypad
> > >
> > > The controller should really be called keypad, and also align
> > > the naming of functions and structures to use "pxa27x_keypad"
> > > as prefix, instead of "pxakbd".
> >
> > Not sure what the difference is... Seems to be a gratuous renaming.
> >
> 
> Yeah, though I used git-mv, the result of git-format-patch still looks horrible.

Probably if you do move commit and rename separately it will be somewhat cleaner.

> Anyway, this is just a naming issue. While other pxa drivers are slowly
> transitioning to a more standard naming convention (if you take a look at
> recent [arch/arm/mach-pxa/devices.c] in Linus's recent tree) I first update
> this to later patches could be more specific.

Let me take a look...

-- 
Dmitry
