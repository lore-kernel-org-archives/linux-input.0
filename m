From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/3] HID: sony: Add force-feedback support for the
 Dualshock 4
Date: Thu, 16 Jan 2014 22:46:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401162246320.23018@pobox.suse.cz>
References: <alpine.DEB.2.10.1401111429090.2563@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53253 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbaAPVqw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 16:46:52 -0500
In-Reply-To: <alpine.DEB.2.10.1401111429090.2563@franz-virtual-machine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Sat, 11 Jan 2014, Frank Praznik wrote:

> Adds the Dualshock 4 to the HID device list and enables force-feedback.
> 
> Adds a Dualshock 4 specific worker function since the Dualshock 4 needs a 
> different report than the Sixaxis.
> 
> The right motor in the Dualshock 4 is variable so the full rumble value 
> is now passed to the worker function and clamped there if necessary.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

I have now applied the whole series, thanks Frank.

-- 
Jiri Kosina
SUSE Labs
