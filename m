From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: mt: update the status of the Multitouch X driver project
Date: Sat, 20 Mar 2010 23:19:56 +0100
Message-ID: <1269123596-2674-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:43630 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752206Ab0CTWV5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 18:21:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The Multitouch X driver project has moved to alpha status.
This patch updates the documentation accordingly.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 Documentation/input/multi-touch-protocol.txt |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index eacb226..c0fc1c7 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -233,11 +233,6 @@ where examples can be found.
 difference between the contact position and the approaching tool position
 could be used to derive tilt.
 [2] The list can of course be extended.
-[3] The multi-touch X driver is currently in the prototyping stage. At the
-time of writing (April 2009), the MT protocol is not yet merged, and the
-prototype implements finger matching, basic mouse support and two-finger
-scrolling. The project aims at improving the quality of current multi-touch
-functionality available in the Synaptics X driver, and in addition
-implement more advanced gestures.
+[3] Multitouch X driver project: http://bitmath.org/code/multitouch/.
 [4] See the section on event computation.
 [5] See the section on finger tracking.
-- 
1.6.3.3

