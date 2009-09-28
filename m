From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] wistron_btns.c: Add DMI entry for Medion WIM2030 laptop
Date: Mon, 28 Sep 2009 10:02:52 -0700
Message-ID: <20090928170251.GF21455@core.coreip.homeip.net>
References: <200909191243.09243.dr.nop@gmx.net> <1253366810.6699.56.camel@desktop> <200909191655.54654.dr.nop@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59075 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZI1RCy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 13:02:54 -0400
Content-Disposition: inline
In-Reply-To: <200909191655.54654.dr.nop@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Frei <dr.nop@gmx.net>
Cc: mitr@volny.cz, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Sep 19, 2009 at 04:55:54PM +0200, Sebastian Frei wrote:
> Am Samstag, 19. September 2009 15:26:50 schrieb Daniel Walker:
> > On Sat, 2009-09-19 at 12:43 +0200, Sebastian Frei wrote:
> > > This patch adds a DMI entry for the Medion WIM2030 laptop.
> > >
> > > Signed-off-by: Sebastian Frei <dr.nop@gmx.net>
> > >
> > > --- linux-2.6.31.orig/drivers/input/misc/wistron_btns.c
> > > +++ linux-2.6.31/drivers/input/misc/wistron_btns.c
> > > @@ -669,6 +669,15 @@
> > >         },
> > >         {
> > >                 .callback = dmi_matched,
> > > +               .ident = "Medion MD 42200",
> > > +               .matches = {
> > > +                       DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
> > > +                       DMI_MATCH(DMI_PRODUCT_NAME, "WIM 2030"),
> > > +               },
> > > +               .driver_data = keymap_fs_amilo_pro_v2000
> > > +       },
> > > +       {
> > > +               .callback = dmi_matched,
> > >                 .ident = "Fujitsu N3510",
> > >                 .matches = {
> > >                         DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > 
> > Form email below (your the second person to do this today),
> > 
> > Your patch is whitespace damaged .. All the tabs have been removed from
> > your code, and the context code in the patch. That usually means the
> > patch can't be applied .. It can happen when you X copy&paste the patch
> > into an email. If your using quilt you can use "quilt mail" , or have
> > your mailer "insert text file" instead of copy&paste.
> > 
> > Daniel
> > 
> Next try, this time with tab stops:
> 
> Signed-off-by: Sebastian Frei <dr.nop@gmx.net>
> 

Applied, thanks Sebastian.

-- 
Dmitry
