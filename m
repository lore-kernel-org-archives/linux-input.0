From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/2] fix channel allocation in the touch screen driver
Date: Wed, 25 Aug 2010 15:22:10 +0100
Message-ID: <20100825142200.2831.42013.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40987 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab0HYPBu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Aug 2010 11:01:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, greg@kroah.com

From: Arjan van de Ven <arjan@linux.intel.com>

the touch screen driver tries to find a range of free channels (which
are an array of bytes), by scanning for the "end of used channel" marker.
however it tries to be WAAAAY too smart and does 32 bit logic on 8 bit
quantities, and in the process completely gets it wrong
(repeatedly read the same register instead of incrementing in the loop,
assuming that if any of the 4 bytes in the 32 byte quantity is free,
all four are free, returning the channel number divided by 4 rather than
the actual first free channel number)

On the setting side, the same mistakes are made by and large; changed
this to just use the byte SCU write functions....

with these fixes we go from a completely non detected touchscreen to
something that appears to completely get detected.
(after also fixing the ordering issue that Jacobs patch should solve)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/mrst-touchscreen/intel-mid-touch.c |   29 ++++++++------------
 1 files changed, 12 insertions(+), 17 deletions(-)


diff --git a/drivers/staging/mrst-touchscreen/intel-mid-touch.c b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
index 97c7b7f..2a1a692 100644
--- a/drivers/staging/mrst-touchscreen/intel-mid-touch.c
+++ b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
@@ -157,8 +157,8 @@ static int mrstouch_pmic_id(uint *vendor, uint *rev)
  */
 static int mrstouch_chan_parse(struct mrstouch_dev *tsdev)
 {
-	int err, i, j, found;
-	u32 r32;
+	int err, i, found;
+	u8 r8;
 
 	found = -1;
 
@@ -166,15 +166,13 @@ static int mrstouch_chan_parse(struct mrstouch_dev *tsdev)
 		if (found >= 0)
 			break;
 
-		err = intel_scu_ipc_ioread32(PMICADDR0, &r32);
+		err = intel_scu_ipc_ioread8(PMICADDR0 + i, &r8);
 		if (err)
 			return err;
 
-		for (j = 0; j < 32; j+= 8) {
-			if (((r32 >> j) & 0xFF) == END_OF_CHANNEL) {
-				found = i;
-				break;
-			}
+		if (r8 == END_OF_CHANNEL) {
+			found = i;
+			break;
 		}
 	}
 	if (found < 0)
@@ -284,20 +282,17 @@ static int mrstouch_ts_chan_read(u16 offset, u16 chan, u16 *vp, u16 *vm)
  */
 static int mrstouch_ts_chan_set(uint offset)
 {
-	int count;
 	u16 chan;
-	u16 reg[5];
-	u8 data[5];
+
+	int ret, count;
 
 	chan = PMICADDR0 + offset;
 	for (count = 0; count <= 3; count++) {
-		reg[count] = chan++;
-		data[count] = MRST_TS_CHAN10 + count;
+		ret = intel_scu_ipc_iowrite8(chan++, MRST_TS_CHAN10 + count);
+		if (ret)
+			return ret;
 	}
-	reg[count] = chan;
-	data[count] = END_OF_CHANNEL;
-
-	return intel_scu_ipc_writev(reg, data, 5);
+	return intel_scu_ipc_iowrite8(chan++, END_OF_CHANNEL);
 }
 
 /* Initialize ADC */

