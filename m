From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: hidraw: enforce minors_lock locking via lockdep
Date: Thu, 8 Nov 2018 22:38:42 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811082237460.21975@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

lockdep is much more powerful enforcing the locking rules than code comments,
so let's switch to it.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hidraw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 4a44e48e08b2..cf2af069204f 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -107,8 +107,6 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 
 /*
  * The first byte of the report buffer is expected to be a report number.
- *
- * This function is to be called with the minors_lock mutex held.
  */
 static ssize_t hidraw_send_report(struct file *file, const char __user *buffer, size_t count, unsigned char report_type)
 {
@@ -117,6 +115,8 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 	__u8 *buf;
 	int ret = 0;
 
+	lockdep_assert_held(&minors_lock);
+
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		ret = -ENODEV;
 		goto out;
@@ -192,6 +192,8 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	int ret = 0, len;
 	unsigned char report_number;
 
+	lockdep_assert_held(&minors_lock);
+
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		ret = -ENODEV;
 		goto out;
-- 
Jiri Kosina
SUSE Labs
