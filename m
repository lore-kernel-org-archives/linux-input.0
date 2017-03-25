From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: synaptics-rmi4 - cleanup SMbus mapping handling
Date: Fri, 24 Mar 2017 23:00:49 -0700
Message-ID: <20170325060050.39867-3-dmitry.torokhov@gmail.com>
References: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35383 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967364AbdCYGA4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 02:00:56 -0400
In-Reply-To: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

There is no reason to copy structures field-by-filed when we can copy
eements at once.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 43 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index c8bf49686460..724643bf31a6 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -83,62 +83,55 @@ static int rmi_smb_get_command_code(struct rmi_transport_dev *xport,
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
+	struct mapping_table_entry new_map;
 	int i;
-	int retval;
-	struct mapping_table_entry mapping_data[1];
+	int retval = 0;
 
 	mutex_lock(&rmi_smb->mappingtable_mutex);
+
 	for (i = 0; i < RMI_SMB2_MAP_SIZE; i++) {
 		struct mapping_table_entry *entry = &rmi_smb->mapping_table[i];
 		if (le16_to_cpu(entry->rmiaddr) == rmiaddr) {
 			if (isread) {
-				if (entry->readcount == bytecount) {
-					*commandcode = i;
-					retval = 0;
+				if (entry->readcount == bytecount)
 					goto exit;
-				}
 			} else {
 				if (entry->flags & RMI_SMB2_MAP_FLAGS_WE) {
-					*commandcode = i;
-					retval = 0;
 					goto exit;
 				}
 			}
 		}
 	}
+
 	i = rmi_smb->table_index;
 	rmi_smb->table_index = (i + 1) % RMI_SMB2_MAP_SIZE;
 
 	/* constructs mapping table data entry. 4 bytes each entry */
-	memset(mapping_data, 0, sizeof(mapping_data));
-
-	mapping_data[0].rmiaddr = cpu_to_le16(rmiaddr);
-	mapping_data[0].readcount = bytecount;
-	mapping_data[0].flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
-
-	retval = smb_block_write(xport, i + 0x80, mapping_data,
-				 sizeof(mapping_data));
+	memset(&new_map, 0, sizeof(new_map));
+	new_map.rmiaddr = cpu_to_le16(rmiaddr);
+	new_map.readcount = bytecount;
+	new_map.flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
 
+	retval = smb_block_write(xport, i + 0x80, &new_map, sizeof(new_map));
 	if (retval < 0) {
 		/*
 		 * if not written to device mapping table
 		 * clear the driver mapping table records
 		 */
-		rmi_smb->mapping_table[i].rmiaddr = 0x0000;
-		rmi_smb->mapping_table[i].readcount = 0;
-		rmi_smb->mapping_table[i].flags = 0;
-		goto exit;
+		memset(&new_map, 0, sizeof(new_map));
 	}
+
 	/* save to the driver level mapping table */
-	rmi_smb->mapping_table[i].rmiaddr = rmiaddr;
-	rmi_smb->mapping_table[i].readcount = bytecount;
-	rmi_smb->mapping_table[i].flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
-	*commandcode = i;
+	rmi_smb->mapping_table[i] = new_map;
 
 exit:
 	mutex_unlock(&rmi_smb->mappingtable_mutex);
 
-	return retval;
+	if (retval < 0)
+		return retval;
+
+	*commandcode = i;
+	return 0;
 }
 
 static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
-- 
2.12.1.578.ge9c3154ca4-goog

