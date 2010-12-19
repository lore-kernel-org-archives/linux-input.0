From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: Fix double equality sign in uevent
Date: Sun, 19 Dec 2010 09:37:47 +0100
Message-ID: <20101219083746.GA5892@polaris.bitmath.org>
References: <1292700717-1610-1-git-send-email-rydberg@euromail.se>
 <20101219080427.GA10074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:57051 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090Ab0LSIiB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 03:38:01 -0500
Content-Disposition: inline
In-Reply-To: <20101219080427.GA10074@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

On Sun, Dec 19, 2010 at 12:04:28AM -0800, Dmitry Torokhov wrote:
> On Sat, Dec 18, 2010 at 08:31:57PM +0100, Henrik Rydberg wrote:
> > Looking at the uevent stream for input devices, all properties
> > are on the form "A=B" except the bitmap values, which are on the
> > form "A==B". Remedied with this patch.
> > 
> > Cc: stable@kernel.org
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > Hi Dmitry,
> > 
> > Unless the input bitmap properties should really behave differently,
> > this patch ought to be a candidate for 2.6.37.
> > 
> 
> Hmm, I do not think so because:
> 
> - either nobody uses bitmap variables and then it is not priority
> - users worked around the problem and by applying fix we'd be
>   breaking their setups.
> 
> I think we should apply it but at the beginning of .38 cycle to give us
> a chance to evaluate and maybe revert.
> 
> Does this make sense?

Indeed, since the problem has been around at least since 2007, it makes perfect sense.

Thanks,
Henrik
