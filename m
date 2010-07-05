From: Michael Poole <mdpoole@troilus.org>
Subject: [PATCH] hid-magicmouse: Correct parsing of large X and Y motions.
Date: Mon, 05 Jul 2010 10:50:09 -0400
Message-ID: <878w5qaspq.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44762 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754038Ab0GEOuN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Jul 2010 10:50:13 -0400
Received: by mail-gy0-f172.google.com with SMTP id 3so2567963gyh.3
        for <linux-input@vger.kernel.org>; Mon, 05 Jul 2010 07:50:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

The X and Y values have two more significant bits in the same byte
that contains click status.  Include these in the reported value.
Thanks to Iain Hibbert of NetBSD for pointing this out.

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 0b89c1c..7cdda23 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -267,8 +267,8 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		 * to have the current touch information before
 		 * generating a click event.
 		 */
-		x = (signed char)data[1];
-		y = (signed char)data[2];
+		x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
+		y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
 		clicks = data[3];
 		break;
 	case 0x20: /* Theoretically battery status (0-100), but I have
-- 
1.7.1
