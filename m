From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Tue, 16 Jun 2009 18:15:49 +0100
Message-ID: <20090616181549.496ae0f2@lxorguk.ukuu.org.uk>
References: <20090615141613.GA7876@sage.bj.intel.com>
	<20090615143446.GB19451@srcf.ucam.org>
	<20090615144748.GA25734@thyme.bj.intel.com>
	<20090616154200.GA12715@srcf.ucam.org>
	<20090616173618.353901ee@lxorguk.ukuu.org.uk>
	<20090616164351.GA14353@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41625 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754276AbZFPRPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2009 13:15:01 -0400
In-Reply-To: <20090616164351.GA14353@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, greg@kroah.com, yan.i.li@intel.com

On Tue, 16 Jun 2009 17:43:51 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Jun 16, 2009 at 05:36:18PM +0100, Alan Cox wrote:
> > > So? If the alternative is machines that don't work until they're added 
> > > to a blacklist, then the correct thing to do is to do it 
> > > unconditionally.
> > 
> > I would disagree: that breaks a whole pile of other machines
> 
> I was under the impression that this was the reset path that Windows 
> followed. If not then that suggests that we're fixing it wrong in the 
> first place?

You need to magically divine what various random windows driver
patches do and also allow for the fact that your i8042 may be completely
faked SMM, partially faked, or just randomly confused. Resetting loses
various bits of config/status that get put back by windows drivers we
don't have enough info on and in machine specific ways.

Alan
