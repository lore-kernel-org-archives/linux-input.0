From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: synaptics-rmi4 - fix endianness issue in SMBus transport
Date: Fri, 24 Mar 2017 23:00:48 -0700
Message-ID: <20170325060050.39867-2-dmitry.torokhov@gmail.com>
References: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35645 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967314AbdCYGAy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 02:00:54 -0400
In-Reply-To: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

The mapping table holds address in LE form, so we should convert it
to CPU when comparing it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 76752555d809..c8bf49686460 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -89,17 +89,16 @@ static int rmi_smb_get_command_code(struct rmi_transport_dev *xport,
 
 	mutex_lock(&rmi_smb->mappingtable_mutex);
 	for (i = 0; i < RMI_SMB2_MAP_SIZE; i++) {
-		if (rmi_smb->mapping_table[i].rmiaddr == rmiaddr) {
+		struct mapping_table_entry *entry = &rmi_smb->mapping_table[i];
+		if (le16_to_cpu(entry->rmiaddr) == rmiaddr) {
 			if (isread) {
-				if (rmi_smb->mapping_table[i].readcount
-							== bytecount) {
+				if (entry->readcount == bytecount) {
 					*commandcode = i;
 					retval = 0;
 					goto exit;
 				}
 			} else {
-				if (rmi_smb->mapping_table[i].flags &
-							RMI_SMB2_MAP_FLAGS_WE) {
+				if (entry->flags & RMI_SMB2_MAP_FLAGS_WE) {
 					*commandcode = i;
 					retval = 0;
 					goto exit;
-- 
2.12.1.578.ge9c3154ca4-goog

