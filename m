From: Jeff Brown <jeffbrown@android.com>
Subject: [PATCH 2/4] hid: hid-input: Remove obsolete default events per packet setting.
Date: Tue, 22 Mar 2011 18:04:02 -0700
Message-ID: <1300842244-42723-3-git-send-email-jeffbrown@android.com>
References: <1300842244-42723-1-git-send-email-jeffbrown@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300842244-42723-1-git-send-email-jeffbrown@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Brown <jeffbrown@google.com>, jeffbrown@android.com
List-Id: linux-input@vger.kernel.org

From: Jeff Brown <jeffbrown@google.com>

The hardcoded default is no longer needed because the input core now
calculates an appropriate value when the input device is registered.

Signed-off-by: jeffbrown@android.com
---
 drivers/hid/hid-input.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 33dde87..4b348e0 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -665,10 +665,6 @@ mapped:
 
 		input_abs_set_res(input, usage->code,
 				  hidinput_calc_abs_res(field, usage->code));
-
-		/* use a larger default input buffer for MT devices */
-		if (usage->code == ABS_MT_POSITION_X && input->hint_events_per_packet == 0)
-			input_set_events_per_packet(input, 60);
 	}
 
 	if (usage->type == EV_ABS &&
-- 
1.7.0.4
