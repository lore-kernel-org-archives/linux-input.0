From: Sebastian Frei <dr.nop@gmx.net>
Subject: Re: [PATCH] wistron_btns.c: Add DMI entry for Medion WIM2030 laptop
Date: Sat, 19 Sep 2009 16:55:54 +0200
Message-ID: <200909191655.54654.dr.nop@gmx.net>
References: <200909191243.09243.dr.nop@gmx.net> <1253366810.6699.56.camel@desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752130AbZISO4P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2009 10:56:15 -0400
In-Reply-To: <1253366810.6699.56.camel@desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mitr@volny.cz
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Am Samstag, 19. September 2009 15:26:50 schrieb Daniel Walker:
> On Sat, 2009-09-19 at 12:43 +0200, Sebastian Frei wrote:
> > This patch adds a DMI entry for the Medion WIM2030 laptop.
> >
> > Signed-off-by: Sebastian Frei <dr.nop@gmx.net>
> >
> > --- linux-2.6.31.orig/drivers/input/misc/wistron_btns.c
> > +++ linux-2.6.31/drivers/input/misc/wistron_btns.c
> > @@ -669,6 +669,15 @@
> >         },
> >         {
> >                 .callback = dmi_matched,
> > +               .ident = "Medion MD 42200",
> > +               .matches = {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "WIM 2030"),
> > +               },
> > +               .driver_data = keymap_fs_amilo_pro_v2000
> > +       },
> > +       {
> > +               .callback = dmi_matched,
> >                 .ident = "Fujitsu N3510",
> >                 .matches = {
> >                         DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> 
> Form email below (your the second person to do this today),
> 
> Your patch is whitespace damaged .. All the tabs have been removed from
> your code, and the context code in the patch. That usually means the
> patch can't be applied .. It can happen when you X copy&paste the patch
> into an email. If your using quilt you can use "quilt mail" , or have
> your mailer "insert text file" instead of copy&paste.
> 
> Daniel
> 
Next try, this time with tab stops:

Signed-off-by: Sebastian Frei <dr.nop@gmx.net>

--- linux-2.6.31/drivers/input/misc/wistron_btns.c.orig	2008-09-12 
20:47:24.000000000 +0200
+++ linux-2.6.31/drivers/input/misc/wistron_btns.c	2008-03-13 
22:18:02.000000000 +0100
@@ -669,6 +669,15 @@
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Medion MD 42200",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "WIM 2030"),
+		},
+		.driver_data = keymap_fs_amilo_pro_v2000
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Fujitsu N3510",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
