From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: intel-ish-hid: initialize ts_format.reserved
Date: Sat, 5 Nov 2016 16:15:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611051613470.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

ts_format.reserved is not used anywhere yet, but the compiler generates a 
warning when the struct's (uninitialized) field is being copied around

drivers/hid/intel-ish-hid/ipc/ipc.c: In function ¡write_ipc_from_queue¢:
drivers/hid/intel-ish-hid/ipc/ipc.c:316: warning: ¡ts_format.reserved¢ may be used uninitialized in this function

Avoid this by force-initializing the field to zero.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 0c9ac4d..417cd07 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -310,6 +310,7 @@ static int write_ipc_from_queue(struct ishtp_device *dev)
 						((uint32_t)tv_utc.tv_usec);
 		ts_format.ts1_source = HOST_SYSTEM_TIME_USEC;
 		ts_format.ts2_source = HOST_UTC_TIME_USEC;
+		ts_format.reserved = 0;
 
 		time_update.primary_host_time = usec_system;
 		time_update.secondary_host_time = usec_utc;
-- 
1.9.2
