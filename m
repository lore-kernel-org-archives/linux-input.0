From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH 0/3] input: appletouch: fixes for jagged/uneven cursor movement
Date: Fri, 17 Jan 2014 19:52:58 -0600
Message-ID: <52D9DE7A.7040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:57618 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaARBxA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 20:53:00 -0500
Received: by mail-ig0-f179.google.com with SMTP id c10so3200268igq.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 17:53:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Resubmitting the appletouch patches from last week with a couple of
updates, as no one's taken a look yet.

The appletouch driver can make some trackpads feel insensitive, with movement
that tends to jerk in steps. This is particularly evident when moving
diagonally. This can greatly hamper the trackpad's usability. These patches
address this by dialing back the fuzz and threshold parameters, by
implementing a new cursor movement smoothing algorithm and by discarding
movements that directly coincide with a change in the number of fingers
detected on the trackpad.

Revisions since last week:

Patch 1/3: Fuzz/threshold fix is identical, except for a typo (2 -> 3)

Patch 2/3: Smoothing algorithm is no longer inertia-based and is more
predictable / less complicated. I also dropped a change in atp_calculate_abs
that I couldn't definitively prove was beneficial.

Patch 3/3: (New) Addresses issues related to when a second finger enters
or leaves the trackpad, causing the cursor to jump or the page to scroll
unexpectedly; now, we discard any movement that happens at the exact moment
we detect a change in the number of fingers touching the trackpad.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>

 drivers/input/mouse/appletouch.c |  206 ++++++++++++++++++++++++++++++--------
 1 file changed, 162 insertions(+), 44 deletions(-)

-- 
1.7.9.5
