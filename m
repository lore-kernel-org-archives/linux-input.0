From: Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCH] drivers/input/joystick/analog.c: enable precise timer
Date: Fri, 1 Feb 2013 12:59:36 -0500
Message-ID: <201302012043.r11KhGbQ024367@farm-0021.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Like nm10300, tile can just use get_cycles() for this.

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
 drivers/input/joystick/analog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 358cd7e..7cd74e2 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -162,7 +162,7 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"PCC"
-#elif defined(CONFIG_MN10300)
+#elif defined(CONFIG_MN10300) || defined(CONFIG_TILE)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x, y)	((x) - (y))
 #define TIME_NAME	"TSC"
-- 
1.7.10.3
