From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 1/4] input: synaptics - fix pressure values calculation on image sensors
Date: Mon,  5 Jan 2015 23:28:32 +0100
Message-ID: <1420496915-31560-2-git-send-email-gabriele.mzt@gmail.com>
References: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

The pressure values retrieved from secondary packets was incorrectly
shifted, making them lower than what they actually were.
Since this only happened with secondary packets, the values reported
when only one finger was present on the touchpad were correct.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f89de89..4d22ebd 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -588,7 +588,7 @@ static void synaptics_parse_agm(const unsigned char buf[],
 		agm->w = hw->w;
 		agm->x = (((buf[4] & 0x0f) << 8) | buf[1]) << 1;
 		agm->y = (((buf[4] & 0xf0) << 4) | buf[2]) << 1;
-		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 1;
+		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 2;
 		break;
 
 	case 2:
-- 
2.1.4
