From: Robert Gerlach <khnz@gmx.de>
Subject: Re: [PATCH] Fujitsu application panel driver
Date: Wed, 19 Dec 2007 10:04:41 +0100
Message-ID: <200712191004.42565.khnz@gmx.de>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net> <200711191350.31965.khnz@gmx.de> <20071119151918.19ebd8aa@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755101AbXLSJFI@vger.kernel.org>
In-Reply-To: <20071119151918.19ebd8aa@freepuppy.rosehill>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Dienstag 20 November 2007 00:19:18 schrieb Stephen Hemminger:
> On Mon, 19 Nov 2007 13:50:30 +0100
>
> Robert Gerlach <khnz@gmx.de> wrote:
> > Am Montag 19 November 2007 05:43:07 schrieb Stephen Hemminger:
> > > On Sun, 18 Nov 2007 23:36:58 +0100
> > >
> > > Robert Gerlach <khnz@gmx.de> wrote:
> > > > Am Dienstag 23 Oktober 2007 21:55:55 schrieb Stephen Hemminger:
> > > > > +MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
> > > > > +MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
> > > >
> > > > Please make sure that this module is not autoload on Lifebook tablets
> > > > (T series and P1[56]10). It works fine, but only supports a subset of
> > > > features (4 of 7 buttons and no display orientation for my T4010).
> > >
> > > I would rather get those tablets working (with help). Rather than
> > > trying to enumerate all the possible DMI values of the full range of
> > > different laptops.
> >
> > I've played with apanel some month ago. I've never found the keys and the
> > switch over the I2C bus. So I was starting my own module (fsc_btns) to
> > play with the IO range announced by ACPI. There I found it all. But my
> > module doesn't work on all Lifebooks (S7110 for example; has no such ACPI
> > device).
>
> Are you sure the IO range isn't really the same as the I2C bus.

No, I'm not sure. But, I was looking through the spec and played with my 
Lifebook, and again with no success.

> See: http://apanel.sourceforge.net/tech.php

Doesn't help ether.


  Robert
