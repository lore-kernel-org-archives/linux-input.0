From: Archana Patni <archana.patni@linux.intel.com>
Subject: [PATCH] HID: i2c-hid: hid report descriptor retrieval changes
Date: Thu,  8 May 2014 09:26:19 -0400
Message-ID: <1399555579-10747-1-git-send-email-archana.patni@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57134 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbaEHISd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 May 2014 04:18:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: jic23@kernel.org, linux-input@vger.kernel.org, mika.westerberg@intel.com, srinivas.pandruvada@intel.com, Archana Patni <archana.patni@linux.intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

Reading the partial HID Descriptor is causing a firmware lockup in some
sensor hubs. Instead of a partial read, this patch implements the
i2c hid fetch using a fixed descriptor size (30 bytes) followed by a
verification of the BCDVersion (V01.00), and value stored in
wHIDDescLength (30 Bytes) for V1.00 descriptors.

As per i2c hid spec, this is the preferred model.

>From hid-over-i2c-protocol-spec-v1-0:

  There are a variety of ways a HOST may choose to retrieve
  the HID Descriptor from the DEVICE. The following is a preferred
  implementation but should not be considered the only implementation.
  A HOST may read the entire HID Descriptor in a single read by
  issuing a read for 30 Bytes to get the entire HID Descriptor
  from the DEVICE.However, the HOST is responsible for validating that

  1. The BCDVersion is V01.00 (later revisions may have different
     descriptor lengths), and

  2. The value stored in wHIDDescLength is 30 (Bytes) for V1.00
     descriptors.

Reported-by: Joe Tijerina <joe.tijerina@st.com>
Signed-off-by: Archana Patni <archana.patni@intel.com>
Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c |   45 ++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b50860d..21aafc8 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -807,34 +807,18 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 	unsigned int dsize;
 	int ret;
 
-	/* Fetch the length of HID description, retrieve the 4 first bytes:
-	 * bytes 0-1 -> length
-	 * bytes 2-3 -> bcdVersion (has to be 1.00) */
-	ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer, 4);
-
-	i2c_hid_dbg(ihid, "%s, ihid->hdesc_buffer: %4ph\n", __func__,
-			ihid->hdesc_buffer);
-
+	/* i2c hid fetch using a fixed descriptor size (30 bytes) */
+	i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
+	ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer,
+				sizeof(struct i2c_hid_desc));
 	if (ret) {
-		dev_err(&client->dev,
-			"unable to fetch the size of HID descriptor (ret=%d)\n",
-			ret);
-		return -ENODEV;
-	}
-
-	dsize = le16_to_cpu(hdesc->wHIDDescLength);
-	/*
-	 * the size of the HID descriptor should at least contain
-	 * its size and the bcdVersion (4 bytes), and should not be greater
-	 * than sizeof(struct i2c_hid_desc) as we directly fill this struct
-	 * through i2c_hid_command.
-	 */
-	if (dsize < 4 || dsize > sizeof(struct i2c_hid_desc)) {
-		dev_err(&client->dev, "weird size of HID descriptor (%u)\n",
-			dsize);
+		dev_err(&client->dev, "hid_descr_cmd failed\n");
 		return -ENODEV;
 	}
 
+	/* Validate the length of HID descriptor, the 4 first bytes:
+	 * bytes 0-1 -> length
+	 * bytes 2-3 -> bcdVersion (has to be 1.00) */
 	/* check bcdVersion == 1.0 */
 	if (le16_to_cpu(hdesc->bcdVersion) != 0x0100) {
 		dev_err(&client->dev,
@@ -843,17 +827,14 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 		return -ENODEV;
 	}
 
-	i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
-
-	ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer,
-				dsize);
-	if (ret) {
-		dev_err(&client->dev, "hid_descr_cmd Fail\n");
+	/* Descriptor length should be 30 bytes as per the specification */
+	dsize = le16_to_cpu(hdesc->wHIDDescLength);
+	if (dsize != sizeof(struct i2c_hid_desc)) {
+		dev_err(&client->dev, "weird size of HID descriptor (%u)\n",
+			dsize);
 		return -ENODEV;
 	}
-
 	i2c_hid_dbg(ihid, "HID Descriptor: %*ph\n", dsize, ihid->hdesc_buffer);
-
 	return 0;
 }
 
-- 
1.7.9.5

