From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [bisected regression] Touchpad "paste" stops working after
	suspend to RAM
Date: Sun, 11 Oct 2009 11:01:34 -0700
Message-ID: <20091011180134.GA5197@core.coreip.homeip.net>
References: <20091011162155.GA4260@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17748 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZJKSCs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Oct 2009 14:02:48 -0400
Content-Disposition: inline
In-Reply-To: <20091011162155.GA4260@Pilar.aei.mpg.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org

Hi Carols,

On Sun, Oct 11, 2009 at 06:21:55PM +0200, Carlos R. Mafra wrote:
> Using the latest 2.6.32-rc3+ kernel, the "paste" operation via the 
> touchpad of my Vaio laptop does not work after suspend to RAM.
> 
> It works flawlessly before s2ram; I select the text with the touchpad
> and tap quickly its right corner to paste the selected text.
> After a plain 'echo mem > /sys/power/state' the "paste" does not work.
> 
> I bisected it to commit ffd0db97196c1057f09c2ab42dd5b30e94e511d9 ("Input: 
> add generic suspend and resume for input devices").
> 
> I haven't tested if reverting it from mainline fixes the issue, but 
> from the patch description I guess that bisection landed correctly
> on the culprit.
> 

Please verify that this is the real offending commit by reverting it - I
am surprised that it would give any trouble since it is supposed to
restore LED state and repeat rate and therefore should only be affecting
keyboards.

-- 
Dmitry
