From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc0
Date: Sat, 13 Mar 2010 00:44:19 -0800
Message-ID: <20100313084419.GE22494@core.coreip.homeip.net>
References: <20100301080342.GH765@core.coreip.homeip.net>
 <201003091439.49023.rgetz@blackfin.uclinux.org>
 <544AC56F16B56944AEC3BD4E3D5917712D6B1D98DB@LIMKCMBX1.ad.analog.com>
 <201003121555.37998.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.210.174]:62501 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab0CMIoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Mar 2010 03:44:24 -0500
Content-Disposition: inline
In-Reply-To: <201003121555.37998.rgetz@blackfin.uclinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Mike Frysinger <vapier.adi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Mar 12, 2010 at 03:55:37PM -0500, Robin Getz wrote:
> On Wed 10 Mar 2010 03:30, Hennerich, Michael pondered:
> > Robin Getz wrote on 2010-03-09:
> > > On Tue 9 Mar 2010 13:20, Dmitry Torokhov pondered:
> > >> On Tue, Mar 09, 2010 at 01:13:34PM -0500, Mike Frysinger wrote:
> > >>> On Tue, Mar 9, 2010 at 13:10, Dmitry Torokhov wrote:
> > >>>> On Tue, Mar 09, 2010 at 12:58:24PM -0500, Mike Frysinger wrote:
> > >>>>> On Tue, Mar 9, 2010 at 12:51, Dmitry Torokhov wrote:
> > >>>>>> On Tue, Mar 09, 2010 at 09:44:08AM -0500, Mike Frysinger
> > > wrote:
> > > [snip]
> > >>>>> i understand the ADXL34x is a bit wonky, but what else would you
> > >>>>> propose ?  or just leave the driver in limbo forever until people
> > >>>>> forget about it ?
> > >>>>
> > >>>> No, just till we have proper framework for it to be merged into.
> > >>>
> > >>> that sounds fine, but is there actually something in progress for
> > >>> that ?  waiting for a framework no one is working on is the same
> > >>> in practice ...
> > >>
> > >> I have high hopes that IIO will fill the needs of these kinds of
> > > devices.
> > >
> > > The fact of things is that many people are using this as pointing device.
> > >
> > > I'm not convinced that IIO is the best place for these types of
> > > things...
> > 
> > Very true - this driver was originally targeted and designed as a 
> > typical human interface input device. 
> > 
> 
> Dmitry:
> 
> Care to comment? I would prefer to come to some sort of conclusion. As Mike 
> said - leaving the driver in limbo forever isn't really a solution for 
> anyone....

OK, you swayed my opinion about 3-axis accelerometers, I will review the
patch again (although IIRC I was pretty satisfied with it) and apply.

-- 
Dmitry
