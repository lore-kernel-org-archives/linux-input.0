From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 2/2] HID: wacom: Support switching from vendor-defined
 device mode on G9 and G11
Date: Tue, 5 Apr 2016 17:22:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604051722170.27368@cbobk.fhfr.pm>
References: <56FD84F4.6060707@gmail.com> <1459794412-10306-1-git-send-email-killertofu@gmail.com> <1459794412-10306-2-git-send-email-killertofu@gmail.com> <20160404205452.GC3443@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56357 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbcDEPWc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Apr 2016 11:22:32 -0400
In-Reply-To: <20160404205452.GC3443@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 4 Apr 2016, Benjamin Tissoires wrote:

> On Apr 04 2016 or thereabouts, Jason Gerecke wrote:
> > A tablet PC booted into Windows may have its pen/touch hardware switched
> > into "Wacom mode" similar to what we do with explicitly-supported hardware.
> > Some devices appear to maintain this state across reboots, preventing their
> > use with the generic HID driver. This patch adds support for detecting the
> > presence of the mode switch feature report used by devices based on the G9
> > and G11 chips and has the HID codepath always attempt to reset the device
> > back to sending standard HID reports.
> > 
> > Fixes: https://sourceforge.net/p/linuxwacom/bugs/307/
> > Fixes: https://sourceforge.net/p/linuxwacom/bugs/310/
> > Fixes: https://github.com/linuxwacom/input-wacom/issues/15
> > 
> > Co-authored-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> > ---
> 
> Not sure how much this matters now, but for the series:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Both applied to for-4.6/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

