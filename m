From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Re: [PATCH] hid kernel module for wireless remote LC Power model
 RC1000MCE
Date: Thu, 3 Feb 2011 16:42:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102031642260.2160@pobox.suse.cz>
References: <4D4019EC.8060301@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55071 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab1BCPmw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Feb 2011 10:42:52 -0500
In-Reply-To: <4D4019EC.8060301@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Schlund <chrisschlund@gmx.de>
Cc: linux-input@vger.kernel.org

On Wed, 26 Jan 2011, Chris Schlund wrote:

> Hi Jiri,
> 
> >>First, I am missing your Signed-off-by: line, without which I can't apply your driver. Please see Documentation/SubmittingPatches for details..
> >>Second, your mailer has damaged (line-wrapped) the patch..
> >>Also, we are not going the EMBEDDED path any more (see commit 73d5e8f77e88a4 for explanation).
> 
> I attached the newly prepared patch with removed EMBEDDED path and 
> hopefully without line-wrap. I also added the Signed-off-by line.

Applied, thanks Chris.

Oh, how I wish we move all this mapping stuff to udev as soon as possible 
...

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
