From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCHv4 0/5] HID: sony: Dualshock3 USB and LED support
Date: Sat, 23 Nov 2013 10:38:50 +0100
Message-ID: <2707561.oVPDB3qvoQ@sven-edge>
References: <1384889192-18488-1-git-send-email-sven@narfation.org> <alpine.LNX.2.00.1311201002360.31451@pobox.suse.cz> <14946321e34bb704a90c5c95f880dd9d.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42445 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3KWJjC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Nov 2013 04:39:02 -0500
In-Reply-To: <14946321e34bb704a90c5c95f880dd9d.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Friday 22 November 2013 21:35:28 simon@mungewell.org wrote:
> I'm a little confused about which kernel this should be in. I believe the
> first in this patch series is required for 3.13 (but does not seemed to be
> included (1)).
> 
> Without this, the kernel will be subject to lockups if anyone actually
> uses the force feedback.
> Simon

No, the first patch is for 3.14 and the rest is also for 3.13. The fix for the
lockup is in the patch "[PATCHv3 0/5] HID: sony: Dualshock3 USB FF deadlock
fix and LED support" and its v2 version. Unfortunately, the v2 was applied for
3.13 and the first patch in this series just contains the renaming stuff
between v2 and v3 of this patch.

The pull request may still have to be made by Jiri. But it is already queued up
in his 3.13 fixes branch [1]

Kind regards,
	Sven

[1] https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-3.13/upstream-fixes

