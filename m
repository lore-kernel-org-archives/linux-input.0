From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 4/5] hid-input: Use a larger event buffer for MT devices
Date: Wed, 23 Jun 2010 13:14:45 +0200
Message-ID: <1277291686-7153-5-git-send-email-rydberg@euromail.se>
References: <1277291686-7153-1-git-send-email-rydberg@euromail.se>
 <1277291686-7153-2-git-send-email-rydberg@euromail.se>
 <1277291686-7153-3-git-send-email-rydberg@euromail.se>
 <1277291686-7153-4-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277291686-7153-4-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Benjamin Tissoires <tissoire@cena.fr>, Chase Douglas <chase.douglas@canonical.com>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

The MT devices produce a lot of data. Tell the underlying input device
approximately how many events will be sent per synchronization, to allow
for better buffering. The number is a template based on continuously
reporting details for each finger on a single hand.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-input.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7a0d2e4..69d152e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -534,6 +534,9 @@ mapped:
 			input_set_abs_params(input, usage->code, a, b, (b - a) >> 8, (b - a) >> 4);
 		else	input_set_abs_params(input, usage->code, a, b, 0, 0);
 
+		/* use a larger default input buffer for MT devices */
+		if (usage->code == ABS_MT_POSITION_X && input->hint_events_per_packet == 0)
+			input_set_events_per_packet(input, 60);
 	}
 
 	if (usage->type == EV_ABS &&
-- 
1.6.3.3
