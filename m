From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/5] [input] add mc13783 touchscreen driver
Date: Wed, 12 Aug 2009 13:34:20 +0200
Message-ID: <20090812113419.GD17992@pengutronix.de>
References: <1249981667-4366-1-git-send-email-s.hauer@pengutronix.de> <1249981667-4366-2-git-send-email-s.hauer@pengutronix.de> <1249981667-4366-3-git-send-email-s.hauer@pengutronix.de> <20090812024609.5EB8B526EC9@mailhub.coreip.homeip.net> <20090812111018.GC17992@pengutronix.de> <20090812111646.GB11227@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752241AbZHLLeV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090812111646.GB11227@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 12, 2009 at 12:16:46PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2009 at 01:10:18PM +0200, Sascha Hauer wrote:
> > On Tue, Aug 11, 2009 at 07:15:33PM -0700, Dmitry Torokhov wrote:
> 
> > > This device does not appear to privide pressure readings, use BTN_TOUCH
> > > alone to indicate touches instead of fake ABS_PRESSURE event. Yes, I
> > > know that older versions of tslib only recognize ABS_PRESSURE...
> 
> > In fact no released version of tslib supports this :( Anyway, fixed.
> 
> Android uses this.  No idea if they've got tslib or their own thing.
> 

tslib supports this in -trunk. Maybe I can trigger a release of tslib
soon. It's a PITA to use trunk versions with build systems.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
