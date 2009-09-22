From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/keyboard: new driver for ADP5520 MFD PMICs
Date: Tue, 22 Sep 2009 08:06:22 -0700
Message-ID: <20090922150622.GC9658@core.coreip.homeip.net>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org> <20090922055954.GB9658@core.coreip.homeip.net> <alpine.LRH.2.00.0909220933090.27145@twin.jikos.cz> <8A42379416420646B9BFAC9682273B6D0DFAD237@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f173.google.com ([209.85.222.173]:60891 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbZIVPGY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 11:06:24 -0400
Content-Disposition: inline
In-Reply-To: <8A42379416420646B9BFAC9682273B6D0DFAD237@limkexm3.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Bryan Wu <cooloney@kernel.org>

On Tue, Sep 22, 2009 at 08:53:19AM +0100, Hennerich, Michael wrote:
> 
> >From: Jiri Kosina
> >Sent: Tuesday, September 22, 2009 9:33 AM
> >
> >On Mon, 21 Sep 2009, Dmitry Torokhov wrote:
> >
> >> > +	if (event & KP_INT) {
> >> > +		adp5520_read(dev->master, KP_INT_STAT_1, &reg_val_low);
> >> > +		adp5520_read(dev->master, KP_INT_STAT_2, &reg_val_high);
> >> > +
> >> > +		keymask = (reg_val_high << 8) | reg_val_low;
> >> > +		/* Read twice to clear */
> >> > +		adp5520_read(dev->master, KP_INT_STAT_1, &reg_val_low);
> >> > +		adp5520_read(dev->master, KP_INT_STAT_2, &reg_val_high);
> >> > +		keymask |= (reg_val_high << 8) | reg_val_low;
> >> > +		adp5520_keys_report_event(dev, keymask, 1);
> >> > +	}
> >> > +
> >> > +	if (event & KR_INT) {
> >>
> >> Why do you check the same condition twice?
> >
> >It actually doesn't seem to be the same condition (KP_INT vs. KR_INT), but
> >it's difficult to say, as these constants are apparently added in some
> >other patch I have no idea about.
> 
> KP Key-Press versus Key-Release 
> 

Yeah, my bad... However the constants could be made more distinct.

-- 
Dmitry
