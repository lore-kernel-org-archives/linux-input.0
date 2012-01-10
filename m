From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: [PATCH v2] Set buttonpad property on those bcm5974 devices that have a physical button.
Date: Tue, 10 Jan 2012 12:08:30 +0200
Message-ID: <1326190110-6991-1-git-send-email-jussi.pakkanen@canonical.com>
References: <20120110094520.GA7582@polaris.bitmath.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49220 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab2AJKIc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 05:08:32 -0500
In-Reply-To: <20120110094520.GA7582@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, linux-input@vger.kernel.org

---
 drivers/input/mouse/bcm5974.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..88fabfb 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -434,6 +434,10 @@ static void setup_events_to_report(struct input_dev *input_dev,
 	__set_bit(BTN_LEFT, input_dev->keybit);
 
 	input_set_events_per_packet(input_dev, 60);
+
+	if (cfg->caps & HAS_INTEGRATED_BUTTON) {
+		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
+	}
 }
 
 /* report button data as logical button state */
-- 
1.7.5.4

