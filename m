From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] Input: focaltech - mark focaltech_set_resolution() static
Date: Wed, 31 Aug 2016 16:37:41 +0800
Message-ID: <1472632661-32159-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: pali.rohar@gmail.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn
List-Id: linux-input@vger.kernel.org

We get 1 warning when building kernel with W=1:
drivers/input/mouse/focaltech.c:393:6: warning: no previous prototype for 'focaltech_set_resolution' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
So this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/input/mouse/focaltech.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index c8c6a8c..d3ca02a 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -390,7 +390,8 @@ static int focaltech_read_size(struct psmouse *psmouse)
 	return 0;
 }
 
-void focaltech_set_resolution(struct psmouse *psmouse, unsigned int resolution)
+static void
+focaltech_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 {
 	/* not supported yet */
 }
-- 
2.7.4
