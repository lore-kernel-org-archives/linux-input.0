From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 10/17] input/joystick/analog: Switch from rdtscl() to native_read_tsc()
Date: Fri, 12 Jun 2015 16:44:50 -0700
Message-ID: <0c3efbd7b70f76c5dea1d6a9958566cd5fb4a4da.1434152603.git.luto@kernel.org>
References: <cover.1434152603.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434152603.git.luto@kernel.org>
In-Reply-To: <cover.1434152603.git.luto@kernel.org>
References: <cover.1434152603.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This timing code is hideous, and this doesn't help.  It gets rid of
one of the last users of rdtscl, though.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/input/joystick/analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 4284080e481d..f871b4f00056 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -143,7 +143,7 @@ struct analog_port {
 
 #include <linux/i8253.h>
 
-#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
+#define GET_TIME(x)	do { if (cpu_has_tsc) x = (unsigned int)native_read_tsc(); else x = get_time_pit(); } while (0)
 #define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? PIT_TICK_RATE / HZ : 0)))
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
@@ -160,7 +160,7 @@ static unsigned int get_time_pit(void)
         return count;
 }
 #elif defined(__x86_64__)
-#define GET_TIME(x)	rdtscl(x)
+#define GET_TIME(x)	do { x = (unsigned int)native_read_tsc(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
 #elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE)
-- 
2.4.2
