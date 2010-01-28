From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Generic PS/2 mouse detected on Fujitsu Lifebook B-Series
  model laptop instead of LBPS/2 Fujitsu Lifebook TouchScreen
Date: Wed, 27 Jan 2010 16:15:01 -0800
Message-ID: <20100128001500.GA17185@core.coreip.homeip.net>
References: <a05e21071001250812x4461e4a0re7f46f7cd28c4162@mail.gmail.com>
 <20100127155514.cc743fa4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57513 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0A1APN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 19:15:13 -0500
Content-Disposition: inline
In-Reply-To: <20100127155514.cc743fa4.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jon - <crayzeejon@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jan 27, 2010 at 03:55:14PM -0800, Andrew Morton wrote:
> (suitable cc's added)
> 
> On Mon, 25 Jan 2010 16:12:43 +0000
> jon - <crayzeejon@gmail.com> wrote:
> 
> > From: Jon Dodgson <crayzeejon@gmail.com>
> > 
> > Fix Detection of Lifebook B-Series Laptop touch screen with DMI
> > product Name string 'Lifebook B Series'
> > 
> > Signed-off-by: Jon Dodgson <crayzeejon@gmail.com>
> > 
> > ---
> > diff -Nurb linux-2.6.26.2/drivers/input/mouse/lifebook.c
> > linux-2.6.26.2_patched/drivers/input/mouse/lifebook.c
> > --- linux-2.6.26.2/drivers/input/mouse/lifebook.c    2008-08-06
> > 17:19:01.000000000 +0100
> > +++ linux-2.6.26.2_patched/drivers/input/mouse/lifebook.c    2010-01-25
> > 02:56:41.000000000 +0000
> > @@ -51,6 +51,12 @@
> >     {
> >         .ident = "LifeBook B",
> >         .matches = {
> > +            DMI_MATCH(DMI_PRODUCT_NAME, "Lifebook B Series"),
> > +        },
> > +    },
> > +    {
> > +        .ident = "LifeBook B",
> > +        .matches = {
> >             DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook B Series"),
> >         },
> >     },
> 
> So the problem is "LifeBook" versus "Lifebook"?  These matches are
> case-sensitive?

Yep. And trust to the BIOS writers wil fill this data with as many
permutations as possible.

> 
> I don't know what kernel you were patching, but current kernels no
> longer have the ".ident" initialisation in that table.  If it _was_
> still there then I'd wonder why you set the ident to "LifeBook B"
> rather than "Lifebook B".

Ident is just for information purposes only (and is was not used by
input that's why it was removed.

> 
> Your email client wordwrapped the patch and replaced its tabs with
> spaces.

Yeah ;( Anyway, I ahve it now, thanks.

-- 
Dmitry
