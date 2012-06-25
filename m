From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: Fix the Kconfig option for generic device handling
Date: Mon, 25 Jun 2012 16:09:24 +0200
Message-ID: <20120625140924.GA489@polaris.bitmath.org>
References: <1340356390-4614-1-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1206251537190.18612@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:33936 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951Ab2FYOGP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 10:06:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1206251537190.18612@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jan Beulich <jbeulich@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 25, 2012 at 03:38:40PM +0200, Jiri Kosina wrote:
> On Fri, 22 Jun 2012, Henrik Rydberg wrote:
> 
> > The generic HID driver is obviously not a special driver, so move
> > it outside of the special drivers menu. Explain the usage and make
> > the default follow the HID setting. This should simplify migration
> > from older kernels.
> > 
> > Reported-by: Jan Beulich <jbeulich@suse.com>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > Hi Jiri,
> > 
> > As pointed out by Jan Beulich, the generic hid driver Kconfig option
> > is confusing. This patch ought to fix most of the concerns. For 3.5.
> 
> The change makes sense. I'd however propose to perhaps unify 
> CONFIG_HID_SUPPORT and CONFIG_HID, while we are at it ... ?

I started out doing precisely that, but I wanted the 3.5 patch to be
as small as possible... I will increase the scope slightly and resend.

Cheers,
Henrik
