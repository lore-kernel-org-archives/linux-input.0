From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.30] input:  dm355evm_keys uses threaded IRQs
Date: Mon, 29 Jun 2009 19:32:59 -0700
Message-ID: <20090630023259.GF10652@dtor-d630.eng.vmware.com>
References: <200901171315.08019.david-b@pacbell.net> <200906211710.50537.david-b@pacbell.net> <20090623050519.GA14724@dtor-d630.eng.vmware.com> <200906241021.06141.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:56034 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbZF3Cc7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 22:32:59 -0400
Received: by mail-px0-f190.google.com with SMTP id 28so3762523pxi.33
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 19:33:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200906241021.06141.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, Jun 24, 2009 at 10:21:05AM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Convert the dm355evm keys driver to use IRQ threading instead of
> a private workqueue.  IRQ threads were added to Linux after this
> driver was written, and in this case fit what the driver needs.
> (Although the non-shared thread costs more runtime memory.)
> 

Applied the 'next' branch, thank you David.

-- 
Dmitry
