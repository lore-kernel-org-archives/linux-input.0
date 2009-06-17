From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Wed, 17 Jun 2009 03:51:01 +0100
Message-ID: <20090617025101.GA27595@srcf.ucam.org>
References: <20090615141613.GA7876@sage.bj.intel.com> <20090615143446.GB19451@srcf.ucam.org> <20090615144748.GA25734@thyme.bj.intel.com> <20090616154200.GA12715@srcf.ucam.org> <20090616173618.353901ee@lxorguk.ukuu.org.uk> <20090616164351.GA14353@srcf.ucam.org> <20090616181549.496ae0f2@lxorguk.ukuu.org.uk> <20090616171732.GA14912@srcf.ucam.org> <20090617010138.GA13479@thyme.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60957 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbZFQCvC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2009 22:51:02 -0400
Content-Disposition: inline
In-Reply-To: <20090617010138.GA13479@thyme.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, akpm@linux-foundation

On Wed, Jun 17, 2009 at 09:01:40AM +0800, Li, Yan I wrote:

> This seems a change too aggressive for me. Do we have a good reason
> for taking this risk? 

It's generally much easier to find regressions (people complain) than it 
is to find things that have never worked (people just assume Linux is 
broken).

> Of course if we found the "actual problem" we'd conjure up a better 
> fix. But before that, I'd prefer the conservative way.

Does stock Windows work on the machine? I think this really ought to be 
a pretty obvious minimal test before adding quirks to the kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
