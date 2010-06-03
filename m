From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/4] input: evdev: Dynamic buffers (rev3)
Date: Thu,  3 Jun 2010 10:00:58 +0200
Message-ID: <1275552062-8153-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44357 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755646Ab0FCIBZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Jun 2010 04:01:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>

Dmitry,

Please find enclosed the third version of the evdev buffer patches.

This version has one more patch; the locking mechanism has been broken
out into its own file, buflock.h, adding a fair amount of
documentation. The mechanism has been moderately tested, showing
graceful dropping of packets as the buffer size gets smaller and the
number of simultaneous readers gets larger.

In the second patch, the per-client buffer is replaced by the buflock
reader, and the spinlock name is changed to reflect the reduced area
it covers. The third patch only has trivial changes, and the fourth
patch is unchanged, but included for completeness.

Cheers,
Henrik

---

Henrik Rydberg (4):
  input: Introduce buflock, a one-to-many circular buffer mechanism
  input: evdev: Use multi-reader buffer to save space (rev3)
  input: evdev: Convert to dynamic event buffer (rev3)
  input: Use driver hint to compute the evdev buffer size

 drivers/input/buflock.h |  133 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/evdev.c   |   77 +++++++++++++++++-----------
 include/linux/input.h   |    7 +++
 3 files changed, 187 insertions(+), 30 deletions(-)
 create mode 100644 drivers/input/buflock.h

