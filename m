From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/3] input: evdev: Dynamic buffers
Date: Fri, 28 May 2010 17:10:31 +0200
Message-ID: <1275059434-2110-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44349 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751691Ab0E1PLU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 11:11:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>

Hi Dmitry,

Here is a first stab at the problem of overrun buffers in evdev, when
running MT devices.

The approach is to first convert the current evdev client fifos to a
single multi-reader buffer, to save memory and increase resilience
towards many listeners. Locking is sparsely utilized in favor of
atomic operations, and there might be a memory barrier missing.  In
the second patch, the (single) static buffer is converted to a dynamic
one, leaving the current buffer size intact. The third patch
introduces the events_per_packet interface in input_dev, and utilizes
the information to compute the evdev buffer size.

The patches are lightly tested, anticipating some discussion.

Cheers,
Henrik

---

Henrik Rydberg (3):
  input: evdev: use multi-reader buffer to save space
  input: evdev: convert to dynamic event buffer
  input: use driver hint to compute the evdev buffer size

 drivers/input/evdev.c |   82 ++++++++++++++++++++++++++++++------------------
 include/linux/input.h |    7 ++++
 2 files changed, 58 insertions(+), 31 deletions(-)

