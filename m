From: Andreas Mohr <andi@lisas.de>
Subject: psmouse: ultimate lockup occurred, yet reload worked (incomplete
 handling?)
Date: Sun, 13 Jan 2013 15:19:58 +0100
Message-ID: <20130113141958.GA4392@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:51271 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3AMOUA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jan 2013 09:20:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

currently on 3.8.0-rc2, and I've got a nice PS/2 mouse with semi-broken
cable (yeah, going to have a fix soonish, but I digress).

In almost all cases of the mouse acting up (not reacting,
or wildly moving in one direction only, opening many browser tabs at
once etc., or at some times even temporarily locking up the whole machine),
psmouse eventually had no trouble getting things stitched back together
(e.g. after a wait of at most about a minute some recovery took place
and things started to react again).
However, I once experienced a situation where the mouse was completely
dead (no amount of fiddling got it to work again, over several minutes).
At this time the machine was alive, however.
In utmost despair I then decided to rmmod psmouse and reload it,
and that instantly fixed it. Repeat after me: "Huh??".

So to me that strongly indicates that state machine handling (reset handling)
in psmouse is somehow incomplete, since the currently running instance
of psmouse module ought to have been able to rescue the situation, too,
rather than the user having to resort to the non-enduser-compatible action
of completely reloading the module, to get PS/2 command processing back
to working.

dmesg log snippet at that time was:

PLAYBACK period done (#2), @ c40000
psmouse serio1: bad data from KBC - timeout
psmouse serio1: bad data from KBC - timeout
als4000: irq 0x0080 0x0002

(note the duplicate timeout logging - perhaps duplicate occurrence
somehow ends up treated differently state-wise?)

This was with default (i.e., 0?) psmouse_resync_time parameter.



And psmouse module in some cases being able
to completely lock up the whole system is a bit weird, too.
OTOH I just realized that this probably simply means that both PS/2 key
and PS/2 mouse controller transfer was blocked (i.e. machine not
steerable via both key and mouse --> effectively appearing "dead")
rather than the entire machine actually dead
(I haven't done network reachability testing yet).


Any ideas/comments about areas in which the implementation might have a
reset weakness here?

Thanks!

Andreas Mohr
