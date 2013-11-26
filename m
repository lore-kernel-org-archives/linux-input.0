From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv4 0/5] HID: sony: Dualshock3 USB and LED support
Date: Tue, 26 Nov 2013 10:44:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311261043230.22082@pobox.suse.cz>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>    <alpine.LNX.2.00.1311201002360.31451@pobox.suse.cz> <14946321e34bb704a90c5c95f880dd9d.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab3KZJob (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 04:44:31 -0500
In-Reply-To: <14946321e34bb704a90c5c95f880dd9d.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Sven Eckelmann <sven@narfation.org>, linux-input@vger.kernel.org

On Fri, 22 Nov 2013, simon@mungewell.org wrote:

> I'm a little confused about which kernel this should be in. I believe the
> first in this patch series is required for 3.13 (but does not seemed to be
> included (1)).
> 
> Without this, the kernel will be subject to lockups if anyone actually
> uses the force feedback.

Yes, the lockup fix is queued for 3.13, the rest for 3.14. See 
for-3.13/upstream-fixes and for-3.14/sony branches in hid.git.

for-3.13/upstream-fixes will be going to Linus this week.

-- 
Jiri Kosina
SUSE Labs
