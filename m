From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 3/5] input: bcm5974: Set the average number of events per MT event packet
Date: Wed, 23 Jun 2010 13:14:44 +0200
Message-ID: <1277291686-7153-4-git-send-email-rydberg@euromail.se>
References: <1277291686-7153-1-git-send-email-rydberg@euromail.se>
 <1277291686-7153-2-git-send-email-rydberg@euromail.se>
 <1277291686-7153-3-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:44308 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506Ab0FWLRr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 07:17:47 -0400
In-Reply-To: <1277291686-7153-3-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Benjamin Tissoires <tissoire@cena.fr>, Chase Douglas <chase.douglas@canonical.com>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>

The MT devices produce a lot of data. Tell the underlying input device
approximately how many events will be sent per synchronization, to allow
for better buffering. The number is a template based on continuously
reporting details for each finger on a single hand.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 6dedded..84094bb 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -312,6 +312,8 @@ static void setup_events_to_report(struct input_dev *input_dev,
 	__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
 	__set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
 	__set_bit(BTN_LEFT, input_dev->keybit);
+
+	input_set_events_per_packet(input_dev, 60);
 }
 
 /* report button data as logical button state */
-- 
1.6.3.3

