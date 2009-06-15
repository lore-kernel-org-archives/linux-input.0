From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Mon, 15 Jun 2009 15:34:46 +0100
Message-ID: <20090615143446.GB19451@srcf.ucam.org>
References: <20090615141613.GA7876@sage.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50824 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761032AbZFOOeq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2009 10:34:46 -0400
Content-Disposition: inline
In-Reply-To: <20090615141613.GA7876@sage.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, yanli@infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, greg@kroah.com

On Mon, Jun 15, 2009 at 10:16:13PM +0800, Yan Li wrote:
> When testing Moblin on various netbooks, we've got reports that many
> MSI Wind clones need the i8042 reset quirks for the keyboard and/or
> touchpad's proper function.

Why are we not doing this unconditionally?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
