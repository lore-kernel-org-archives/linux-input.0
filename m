From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Tue, 16 Jun 2009 16:42:00 +0100
Message-ID: <20090616154200.GA12715@srcf.ucam.org>
References: <20090615141613.GA7876@sage.bj.intel.com> <20090615143446.GB19451@srcf.ucam.org> <20090615144748.GA25734@thyme.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55965 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbZFPPmW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2009 11:42:22 -0400
Content-Disposition: inline
In-Reply-To: <20090615144748.GA25734@thyme.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, greg@kroah.com, yan.i.li@intel.com

On Mon, Jun 15, 2009 at 10:47:48PM +0800, Li, Yan wrote:
> On Mon, Jun 15, 2009 at 03:34:46PM +0100, Matthew Garrett wrote:
> > On Mon, Jun 15, 2009 at 10:16:13PM +0800, Yan Li wrote:
> > > When testing Moblin on various netbooks, we've got reports that many
> > > MSI Wind clones need the i8042 reset quirks for the keyboard and/or
> > > touchpad's proper function.
> > 
> > Why are we not doing this unconditionally?
> 
> For the majority of sane machines this is not necessary.

So? If the alternative is machines that don't work until they're added 
to a blacklist, then the correct thing to do is to do it 
unconditionally.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
