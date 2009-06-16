From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Tue, 16 Jun 2009 17:43:51 +0100
Message-ID: <20090616164351.GA14353@srcf.ucam.org>
References: <20090615141613.GA7876@sage.bj.intel.com> <20090615143446.GB19451@srcf.ucam.org> <20090615144748.GA25734@thyme.bj.intel.com> <20090616154200.GA12715@srcf.ucam.org> <20090616173618.353901ee@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60679 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbZFPQnw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2009 12:43:52 -0400
Content-Disposition: inline
In-Reply-To: <20090616173618.353901ee@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, greg@kroah.com, yan.i.li@intel.com

On Tue, Jun 16, 2009 at 05:36:18PM +0100, Alan Cox wrote:
> > So? If the alternative is machines that don't work until they're added 
> > to a blacklist, then the correct thing to do is to do it 
> > unconditionally.
> 
> I would disagree: that breaks a whole pile of other machines

I was under the impression that this was the reset path that Windows 
followed. If not then that suggests that we're fixing it wrong in the 
first place?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
