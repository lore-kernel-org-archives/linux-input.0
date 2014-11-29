From: Athira S <athirasnamby@gmail.com>
Subject: [PATCH] Drivers:input:mousedev.c: Fixed trailing statement on the next line
Date: Sat, 29 Nov 2014 21:50:43 +0530
Message-ID: <1417278043-4870-1-git-send-email-athirasnamby@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Athira S <athirasnamby@gmail.com>
List-Id: linux-input@vger.kernel.org

Fixed checkpatch error:
trailing statements should be on next line

signed-off-by: Athira S <athirasnamby@gmail.com>
---
 drivers/input/mousedev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index be2cc5c..28988f5 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -248,8 +248,8 @@ static void mousedev_key_event(struct mousedev *mousedev,
 	case BTN_4:
 	case BTN_EXTRA:		index = 4; break;
 
-	default:
-	return;
+	default:	
+				return;
 	}
 
 	if (value) {
-- 
1.9.1
