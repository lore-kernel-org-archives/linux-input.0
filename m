From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] sh: maple: add support for the Maple mouse on the SEGA Dreamcast
Date: Tue, 30 Dec 2008 00:17:44 -0800
Message-ID: <200812300017.45336.dmitry.torokhov@gmail.com>
References: <1230578246.6496.25.camel@localhost.localdomain> <1230589073.6496.30.camel@localhost.localdomain> <200812291719.47754.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <200812291719.47754.vapier@gentoo.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-input@vger.kernel.org

On Monday 29 December 2008 14:19:42 Mike Frysinger wrote:
> On Monday 29 December 2008 17:17:53 Adrian McMenamin wrote:
> > On Mon, 2008-12-29 at 22:46 +0100, Sam Ravnborg wrote:
> > > Look for an increase in section mismatch warning or try to
> > > build with:
> > > make CONFIG_DEBUG_SECTION_MISMATCH=y
> >
> > Just rebuilt the whole thing from scratch with that turned on and no
> > extra warnings at all.
>
> regardless, please add the aforementioned wrapping.  this comes up from
> time to time in various configurations.

It could be that neither of the platforms this driver is running on defines
CONFIG_HOTPLUG and then I think it is harmless but yes, we better have
__devexit_p() there.
 
-- 
Dmitry
