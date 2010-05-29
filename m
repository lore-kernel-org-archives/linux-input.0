From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/3] input: evdev: Dynamic buffers (rev2)
Date: Sat, 29 May 2010 17:57:41 +0200
Message-ID: <1275148664-6238-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:44687 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328Ab0E2P61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 11:58:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>

Ok, second version of the evdev buffer patches.

In the first patch, the locking has been completely reworked. The
buffer locking is now similar to seqlock, except the readers only
block while there is an update affecting the current read. Should be
fairly optimal, but we can always revert to seqlocks in case the
scatter of smp instructions feels inadequate.

The second patch only has trivial changes, and the third patch is
unchanged, but included for completeness.

Cheers,
Henrik

---

Henrik Rydberg (3):
  input: evdev: use multi-reader buffer to save space (rev2)
  input: evdev: convert to dynamic event buffer (rev2)
  input: use driver hint to compute the evdev buffer size

 drivers/input/evdev.c |   90 +++++++++++++++++++++++++++++++++---------------
 include/linux/input.h |    7 ++++
 2 files changed, 69 insertions(+), 28 deletions(-)

