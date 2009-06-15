From: "Li, Yan" <yanli@infradead.org>
Subject: Re: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Mon, 15 Jun 2009 22:47:48 +0800
Message-ID: <20090615144748.GA25734@thyme.bj.intel.com>
References: <20090615141613.GA7876@sage.bj.intel.com> <20090615143446.GB19451@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:43141 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZFPBml (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2009 21:42:41 -0400
Content-Disposition: inline
In-Reply-To: <20090615143446.GB19451@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, greg@kroah.com, yan.i.li@intel.com

On Mon, Jun 15, 2009 at 03:34:46PM +0100, Matthew Garrett wrote:
> On Mon, Jun 15, 2009 at 10:16:13PM +0800, Yan Li wrote:
> > When testing Moblin on various netbooks, we've got reports that many
> > MSI Wind clones need the i8042 reset quirks for the keyboard and/or
> > touchpad's proper function.
> 
> Why are we not doing this unconditionally?

For the majority of sane machines this is not necessary.

-- 
Li, Yan
