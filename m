From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Fix the Kconfig option for generic device
 handling
Date: Mon, 25 Jun 2012 17:26:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206251726110.18612@pobox.suse.cz>
References: <1340356390-4614-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1206251537190.18612@pobox.suse.cz> <20120625151615.GA11770@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51630 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab2FYP0d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 11:26:33 -0400
In-Reply-To: <20120625151615.GA11770@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jan Beulich <jbeulich@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 25 Jun 2012, Henrik Rydberg wrote:

> > > The generic HID driver is obviously not a special driver, so move
> > > it outside of the special drivers menu. Explain the usage and make
> > > the default follow the HID setting. This should simplify migration
> > > from older kernels.
> > > 
> > > Reported-by: Jan Beulich <jbeulich@suse.com>
> > > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > > ---
> > > Hi Jiri,
> > > 
> > > As pointed out by Jan Beulich, the generic hid driver Kconfig option
> > > is confusing. This patch ought to fix most of the concerns. For 3.5.
> > 
> > The change makes sense. I'd however propose to perhaps unify 
> > CONFIG_HID_SUPPORT and CONFIG_HID, while we are at it ... ?
> 
> Here is a version putting together both patches sent previously, and in 
> addition removing the HID_SUPPORT option.

Applied, thank you Henrik.

-- 
Jiri Kosina
SUSE Labs
