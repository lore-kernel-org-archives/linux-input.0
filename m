From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Input: synaptics-rmi4 - pr_err() strings should end with newlines
Date: Tue, 26 Sep 2017 12:31:47 +0530
Message-ID: <bd3d877929973f6da9d9be35c3fa395294b27239.1506409239.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/rmi4/rmi_f11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index bc5e37f..28296a9 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -596,7 +596,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 			/* Possible of having 4 fingers per f_state register */
 			finger_state = rmi_f11_parse_finger_state(f_state, i);
 			if (finger_state == F11_RESERVED) {
-				pr_err("Invalid finger state[%d]: 0x%02x", i,
+				pr_err("Invalid finger state[%d]: 0x%02x\n", i,
 					finger_state);
 				continue;
 			}
-- 
1.9.1
