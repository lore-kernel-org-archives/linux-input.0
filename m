From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH V2] hp_sdc_rtc: fixed y2038 problem in proc_show
Date: Wed, 16 Sep 2015 21:45:38 +0800
Message-ID: <1442411138-773-1-git-send-email-pingbo.wen@linaro.org>
References: <3021182.6jgkaVHA9u@wuerfel>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3021182.6jgkaVHA9u@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, WEN Pingbo <pingbo.wen@linaro.org>, Y2038 <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

hp_sdc_rtc_proc_show() use timeval to store the time, which will
overflowed in 2038.

This patch fixes this problem by replacing timeval with timespec64.
hp_sdc_rtc_proc_show() only output string, so that userspace will work
normally if we apply this patch.

Not all timer in i8042 have y2038 risk(handshake, match timer, etc),
Replacements in those timer are just for consistency.

Version 2 Updates:
- compiled in m68k gcc cross compiler(4.6.3), no extra warnings
- placed s64 type cast in tv.tv_sec, making sure it work properly in
both 32bit and 64bit platform.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
Cc: Y2038 <y2038@lists.linaro.org>
---
 drivers/input/misc/hp_sdc_rtc.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 45e0e3e..1c8c56e 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -198,7 +198,7 @@ static int64_t hp_sdc_rtc_read_i8042timer (uint8_t loadcmd, int numreg)
 
 
 /* Read the i8042 real-time clock */
-static inline int hp_sdc_rtc_read_rt(struct timeval *res) {
+static inline int hp_sdc_rtc_read_rt(struct timespec64 *res) {
 	int64_t raw;
 	uint32_t tenms; 
 	unsigned int days;
@@ -209,15 +209,15 @@ static inline int hp_sdc_rtc_read_rt(struct timeval *res) {
 	tenms = (uint32_t)raw & 0xffffff;
 	days  = (unsigned int)(raw >> 24) & 0xffff;
 
-	res->tv_usec = (suseconds_t)(tenms % 100) * 10000;
-	res->tv_sec =  (time_t)(tenms / 100) + days * 86400;
+	res->tv_nsec = (long)(tenms % 100) * 10000 * 1000;
+	res->tv_sec =  (tenms / 100) + (time64_t)days * 86400;
 
 	return 0;
 }
 
 
 /* Read the i8042 fast handshake timer */
-static inline int hp_sdc_rtc_read_fhs(struct timeval *res) {
+static inline int hp_sdc_rtc_read_fhs(struct timespec64 *res) {
 	int64_t raw;
 	unsigned int tenms;
 
@@ -226,15 +226,15 @@ static inline int hp_sdc_rtc_read_fhs(struct timeval *res) {
 
 	tenms = (unsigned int)raw & 0xffff;
 
-	res->tv_usec = (suseconds_t)(tenms % 100) * 10000;
-	res->tv_sec  = (time_t)(tenms / 100);
+	res->tv_nsec = (long)(tenms % 100) * 10000 * 1000;
+	res->tv_sec  = (time64_t)(tenms / 100);
 
 	return 0;
 }
 
 
 /* Read the i8042 match timer (a.k.a. alarm) */
-static inline int hp_sdc_rtc_read_mt(struct timeval *res) {
+static inline int hp_sdc_rtc_read_mt(struct timespec64 *res) {
 	int64_t raw;	
 	uint32_t tenms; 
 
@@ -243,15 +243,15 @@ static inline int hp_sdc_rtc_read_mt(struct timeval *res) {
 
 	tenms = (uint32_t)raw & 0xffffff;
 
-	res->tv_usec = (suseconds_t)(tenms % 100) * 10000;
-	res->tv_sec  = (time_t)(tenms / 100);
+	res->tv_nsec = (long)(tenms % 100) * 10000 * 1000;
+	res->tv_sec  = (time64_t)(tenms / 100);
 
 	return 0;
 }
 
 
 /* Read the i8042 delay timer */
-static inline int hp_sdc_rtc_read_dt(struct timeval *res) {
+static inline int hp_sdc_rtc_read_dt(struct timespec64 *res) {
 	int64_t raw;
 	uint32_t tenms;
 
@@ -260,15 +260,15 @@ static inline int hp_sdc_rtc_read_dt(struct timeval *res) {
 
 	tenms = (uint32_t)raw & 0xffffff;
 
-	res->tv_usec = (suseconds_t)(tenms % 100) * 10000;
-	res->tv_sec  = (time_t)(tenms / 100);
+	res->tv_nsec = (long)(tenms % 100) * 10000 * 1000;
+	res->tv_sec  = (time64_t)(tenms / 100);
 
 	return 0;
 }
 
 
 /* Read the i8042 cycle timer (a.k.a. periodic) */
-static inline int hp_sdc_rtc_read_ct(struct timeval *res) {
+static inline int hp_sdc_rtc_read_ct(struct timespec64 *res) {
 	int64_t raw;
 	uint32_t tenms;
 
@@ -277,8 +277,8 @@ static inline int hp_sdc_rtc_read_ct(struct timeval *res) {
 
 	tenms = (uint32_t)raw & 0xffffff;
 
-	res->tv_usec = (suseconds_t)(tenms % 100) * 10000;
-	res->tv_sec  = (time_t)(tenms / 100);
+	res->tv_nsec = (long)(tenms % 100) * 10000 * 1000;
+	res->tv_sec  = (time64_t)(tenms / 100);
 
 	return 0;
 }
@@ -433,7 +433,7 @@ static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
 #define YN(bit) ("no")
 #define NY(bit) ("yes")
         struct rtc_time tm;
-	struct timeval tv;
+	struct timespec64 tv;
 
 	memset(&tm, 0, sizeof(struct rtc_time));
 
@@ -452,36 +452,36 @@ static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
 	if (hp_sdc_rtc_read_rt(&tv)) {
 		seq_puts(m, "i8042 rtc\t: READ FAILED!\n");
 	} else {
-		seq_printf(m, "i8042 rtc\t: %ld.%02d seconds\n", 
-			     tv.tv_sec, (int)tv.tv_usec/1000);
+		seq_printf(m, "i8042 rtc\t: %lld.%02ld seconds\n",
+			     (s64)tv.tv_sec, (long)tv.tv_nsec/1000000L);
 	}
 
 	if (hp_sdc_rtc_read_fhs(&tv)) {
 		seq_puts(m, "handshake\t: READ FAILED!\n");
 	} else {
-        	seq_printf(m, "handshake\t: %ld.%02d seconds\n", 
-			     tv.tv_sec, (int)tv.tv_usec/1000);
+		seq_printf(m, "handshake\t: %lld.%02ld seconds\n",
+			     (s64)tv.tv_sec, (long)tv.tv_nsec/1000000L);
 	}
 
 	if (hp_sdc_rtc_read_mt(&tv)) {
 		seq_puts(m, "alarm\t\t: READ FAILED!\n");
 	} else {
-		seq_printf(m, "alarm\t\t: %ld.%02d seconds\n", 
-			     tv.tv_sec, (int)tv.tv_usec/1000);
+		seq_printf(m, "alarm\t\t: %lld.%02ld seconds\n",
+			     (s64)tv.tv_sec, (long)tv.tv_nsec/1000000L);
 	}
 
 	if (hp_sdc_rtc_read_dt(&tv)) {
 		seq_puts(m, "delay\t\t: READ FAILED!\n");
 	} else {
-		seq_printf(m, "delay\t\t: %ld.%02d seconds\n", 
-			     tv.tv_sec, (int)tv.tv_usec/1000);
+		seq_printf(m, "delay\t\t: %lld.%02ld seconds\n",
+			     (s64)tv.tv_sec, (long)tv.tv_nsec/1000000L);
 	}
 
 	if (hp_sdc_rtc_read_ct(&tv)) {
 		seq_puts(m, "periodic\t: READ FAILED!\n");
 	} else {
-		seq_printf(m, "periodic\t: %ld.%02d seconds\n", 
-			     tv.tv_sec, (int)tv.tv_usec/1000);
+		seq_printf(m, "periodic\t: %lld.%02ld seconds\n",
+			     (s64)tv.tv_sec, (long)tv.tv_nsec/1000000L);
 	}
 
         seq_printf(m,
-- 
1.9.1
