From: Athira Sharikkal <athirasnamby@gmail.com>
Subject: [PATCH v2] Drivers: input: mousedev.c: Fixed trailing statement on the next line
Date: Mon,  1 Dec 2014 18:06:42 +0530
Message-ID: <1417437402-3365-1-git-send-email-athirasnamby@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Athira Sharikkal <athirasnamby@gmail.com>
List-Id: linux-input@vger.kernel.org

Fixed checkpatch error:
trailing statements should be on next line

Signed-off-by: Athira Sharikkal <athirasnamby@gmail.com>
---
v2: corrected indentation
 drivers/input/mousedev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index b604564..28988f5 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -248,7 +248,8 @@ static void mousedev_key_event(struct mousedev *mousedev,
 	case BTN_4:
 	case BTN_EXTRA:		index = 4; break;
 
-	default:		return;
+	default:	
+				return;
 	}
 
 	if (value) {
-- 
1.9.1
