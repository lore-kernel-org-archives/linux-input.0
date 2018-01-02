From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH 1/2] HID: core: i2c-hid: fix size check and type usage
Date: Wed,  3 Jan 2018 01:30:05 +0800
Message-ID: <20180102173006.506-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, aaron.ma@canonical.com
List-Id: linux-input@vger.kernel.org

When convert char array with signed int, if the inbuf[x] is negative then
upper bits will be set to 1. Fix this by using u8 instead of char.

ret_size has to be at least 3, hid_input_report use it after minus 2 bytes.

size should be more than 0 to keep memset safe.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/hid/hid-core.c        |  4 ++--
 drivers/hid/i2c-hid/i2c-hid.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0c3f608131cf..992547771d96 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1506,7 +1506,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 	if (rsize > HID_MAX_BUFFER_SIZE)
 		rsize = HID_MAX_BUFFER_SIZE;
 
-	if (csize < rsize) {
+	if ((csize < rsize) && (csize > 0)) {
 		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
 				csize, rsize);
 		memset(cdata + csize, 0, rsize - csize);
@@ -1566,7 +1566,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 	report_enum = hid->report_enum + type;
 	hdrv = hid->driver;
 
-	if (!size) {
+	if (size <= 0) {
 		dbg_hid("empty report\n");
 		ret = -1;
 		goto unlock;
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index e054ee43c1e2..09404ffdb08b 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -144,10 +144,10 @@ struct i2c_hid {
 						   * register of the HID
 						   * descriptor. */
 	unsigned int		bufsize;	/* i2c buffer size */
-	char			*inbuf;		/* Input buffer */
-	char			*rawbuf;	/* Raw Input buffer */
-	char			*cmdbuf;	/* Command buffer */
-	char			*argsbuf;	/* Command arguments buffer */
+	u8			*inbuf;		/* Input buffer */
+	u8			*rawbuf;	/* Raw Input buffer */
+	u8			*cmdbuf;	/* Command buffer */
+	u8			*argsbuf;	/* Command arguments buffer */
 
 	unsigned long		flags;		/* device flags */
 	unsigned long		quirks;		/* Various quirks */
@@ -473,7 +473,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 
 	ret_size = ihid->inbuf[0] | ihid->inbuf[1] << 8;
 
-	if (!ret_size) {
+	if (ret_size <= 2) {
 		/* host or device initiated RESET completed */
 		if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags))
 			wake_up(&ihid->wait);
-- 
2.14.3
