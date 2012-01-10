From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Tue, 10 Jan 2012 12:56:49 +0200
Message-ID: <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
References: <20120110102211.GA7682@polaris.bitmath.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49463 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2AJK4w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 05:56:52 -0500
In-Reply-To: <20120110102211.GA7682@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, linux-input@vger.kernel.org

Some bcm5974 trackpads have a physical button beneath the physical surface.
This patch sets the property bit so user space applications can
detect the trackpad type and act accordingly.

Signed-off-by: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/bcm5974.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..913e9fa 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -433,6 +433,9 @@ static void setup_events_to_report(struct input_dev *input_dev,
 	__set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
 	__set_bit(BTN_LEFT, input_dev->keybit);
 
+	if (cfg->caps & HAS_INTEGRATED_BUTTON)
+		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
+
 	input_set_events_per_packet(input_dev, 60);
 }
 
-- 
1.7.5.4

