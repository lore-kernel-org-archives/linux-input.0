Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC41D5174
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338565; cv=none; b=iYKWWMTI5mln3lB+QrlJyKxPKFCxPGUmjv3LC22pyvBfxkyCyIClzD2/CMOZBbgmzYRm3vlB6FbAWBpg1E9WKFd8GiT+VckIkerl32xHei3xSQF9g4+4Mh62LESK++8wktecKvFLuEsivx/vDjFvzKW0GmJKBKeF5lRA8tsE1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338565; c=relaxed/simple;
	bh=d9+1G5guTxGxgDF7AlZCYAyVE/dspri7a/S+NXBm2Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJiLPKX3pTO3z8K29V6MLqVADxiGf8woTEk5Oe8GE/aiyVqW+yg6kOM+KBY3P65n2eP66Dha0wl4L4mxUYyVtUrTsrf0QuIaZzeiO+kyl1xJGshlaUbie8oyrng75hFHNk7RKYIZMztP11QovdhBtOZP8zDB2BTUyB6J2HsCpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5jklr5a; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5jklr5a"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2dee127b3c5so709558eec.1
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338563; x=1777943363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqyLeCB0LHzwlyW313c4IdDkpLsyRNtNhHpc7DsBWxc=;
        b=f5jklr5aaApywTGu8JT1SSiIyIeyOlPEyMuSkHwheHMzGMrA/EMXVqmYm+MRBLio7N
         aq2299CZ8I7KcKMUnXFe1+ZzCQHyLPTO9cyRTyqKJDo+Obp1PiIF5mIItjG7aElewNiE
         uMrFb09Vx3sOpL1s8vxK3v8ftcO2ahBp8lb88Saz8mNIgkhev2/ErWT/cJqg/SJNaIdu
         zOZnrech9v4T9Cbryx+eef6YqDEyGnqFH+At6oxiZAVD+PniGJRZNaP20XDaSFZQQ4qi
         xbpTKxuCLobTYgcZnlicYnQUGyNmu3PafkklZ10yq62iqaMp1oDmlB/Jk9Oz9AUEcFuG
         Al5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338563; x=1777943363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqyLeCB0LHzwlyW313c4IdDkpLsyRNtNhHpc7DsBWxc=;
        b=n4BflINjUMcW9UvSJFsS3i82D3S3mgQ+xA55uRSYwWqFYGD3Tp81oReBXoDk9HX/qX
         xxJY9JHOt5VorTUgZx7pjr/c6I8bcEJcmbK6F2SPbqC0QaNF3qSngRzlK/pQFz3inRNG
         /bLZszdrzi44J6UlkH36AAEPrbyeeJwkBQAuNscBsMNg9c/ef6cTiwxsvpb/w2ePH0xp
         h6hneBvGNMV0PTdSx84J3PizMbIAs1ALADpNBr17BLghafHC43R1Y1WmuEL4uKs6mz2g
         sFnHUpyxN6dxZ55grPU7X0ItqsgeRBtMJyCoQlP3uOmGT71MUKyUC9W1pAKW7GgsQn2z
         sEYg==
X-Gm-Message-State: AOJu0YzIGnK/HdpeGFLKKpdsaxBq8ccfVhW2b2E/Ks3QHOavFhEBzURz
	It48eJaXFFLJkDY2mbdrIdsgTIW0JleAYgpc3mZVFRZC48gpcU88318AMWd29g==
X-Gm-Gg: AeBDiesdCjtbl6W6vJ7ciC1rFyJSjMzkYacmkJCSW8Bdo8eZ/4ceKzDI8f8XLW1FHVp
	OI4Pffjs06c8UvKtewL3GJT5rPD6bDUiOheN7fev3ljRdYjzglGp5vPc9UL1I3/ZB7LoXJIx5+2
	+TT5FIVhgYJwWTd/R07y78xtr/FJW4S8u29rfAmhsC7KVAsG95nEOGVZkVKpd6AalrENKeh7UZL
	UB7UT7tDY41PDPdnu9agd/RbYAq+E6gLQabbhH2soz2qwriYIjaGiN7y4MEmKf8bqQ7rm2OsfdY
	37ZpVcfMWaPAR3EOan1ZO496taXmLQIYnItguqhTk959K7MkwDMmF71wKzYF7FSO4kSKCHPpVO2
	rTB5yLqyw3G9WdBwKpCEC0jpaKdhwOBGUHSyYsmFAICop92C73Vidtn7HRB1PwLoT/pz/MDHat0
	48Rn4Tl/+vlUT0rOu3tANy+F9hwnp3QxPz4ikgoVdzoOSf3fV4eMOfHZ+3d3Na+/yfRDo/R4X41
	Z915u/dLufx+grsCMAUms8cRCo8HPe1jhjj
X-Received: by 2002:a05:7300:541:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2ed0a1122femr640598eec.26.1777338562670;
        Mon, 27 Apr 2026 18:09:22 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e678:f42a:a63c:516c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fb64d7sm1071380eec.9.2026.04.27.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:09:21 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: rmi4 - refactor register descriptor parsing
Date: Mon, 27 Apr 2026 18:09:15 -0700
Message-ID: <20260428010917.1320927-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out parsing a register descriptor item from
rmi_read_register_desc() and ensure there are no out-of-bounds accesses.

Use get_unaligned_le16() and get_unaligned_le32() for reading multi-byte
values.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 119 ++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44db..9871e9b816dc 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -22,6 +22,7 @@
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
 #include <linux/export.h>
+#include <linux/unaligned.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -558,30 +559,74 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 	return retval < 0 ? retval : 0;
 }
 
+static int rmi_parse_register_desc_item(struct rmi_register_desc_item *item,
+					const u8 *buf, size_t size)
+{
+	int offset = 0;
+	int map_offset = 0;
+	int b;
+
+	if (offset >= size)
+		return -EIO;
+
+	item->reg_size = buf[offset++];
+	if (item->reg_size == 0) {
+		if (size - offset < 2)
+			return -EIO;
+		item->reg_size = get_unaligned_le16(&buf[offset]);
+		offset += 2;
+	}
+
+	if (item->reg_size == 0) {
+		if (size - offset < 4)
+			return -EIO;
+		item->reg_size = get_unaligned_le32(&buf[offset]);
+		offset += 4;
+	}
+
+	do {
+		if (offset >= size)
+			return -EIO;
+
+		for (b = 0; b < 7; b++) {
+			if (buf[offset] & BIT(b)) {
+				if (map_offset >= RMI_REG_DESC_SUBPACKET_BITS)
+					return -EIO;
+				bitmap_set(item->subpacket_map, map_offset, 1);
+			}
+			++map_offset;
+		}
+	} while (buf[offset++] & 0x80);
+
+	item->num_subpackets = bitmap_weight(item->subpacket_map,
+					     RMI_REG_DESC_SUBPACKET_BITS);
+
+	return offset;
+}
+
 int rmi_read_register_desc(struct rmi_device *d, u16 addr,
-				struct rmi_register_descriptor *rdesc)
+			   struct rmi_register_descriptor *rdesc)
 {
 	int ret;
 	u8 size_presence_reg;
 	u8 buf[35];
-	int presense_offset = 1;
-	u8 *struct_buf;
+	int presence_offset;
 	int reg;
 	int offset = 0;
-	int map_offset = 0;
+	int map_offset;
 	int i;
 	int b;
 
 	/*
 	 * The first register of the register descriptor is the size of
-	 * the register descriptor's presense register.
+	 * the register descriptor's presence register.
 	 */
 	ret = rmi_read(d, addr, &size_presence_reg);
 	if (ret)
 		return ret;
 	++addr;
 
-	if (size_presence_reg < 0 || size_presence_reg > 35)
+	if (size_presence_reg < 1 || size_presence_reg > 35)
 		return -EIO;
 
 	memset(buf, 0, sizeof(buf));
@@ -597,16 +642,23 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	++addr;
 
 	if (buf[0] == 0) {
-		presense_offset = 3;
-		rdesc->struct_size = buf[1] | (buf[2] << 8);
+		if (size_presence_reg < 3)
+			return -EIO;
+		presence_offset = 3;
+		rdesc->struct_size = get_unaligned_le16(&buf[1]);
 	} else {
+		presence_offset = 1;
 		rdesc->struct_size = buf[0];
 	}
 
-	for (i = presense_offset; i < size_presence_reg; i++) {
+	map_offset = 0;
+	for (i = presence_offset; i < size_presence_reg; i++) {
 		for (b = 0; b < 8; b++) {
-			if (buf[i] & (0x1 << b))
+			if (buf[i] & BIT(b)) {
+				if (map_offset >= RMI_REG_DESC_PRESENSE_BITS)
+					return -EIO;
 				bitmap_set(rdesc->presense_map, map_offset, 1);
+			}
 			++map_offset;
 		}
 	}
@@ -626,7 +678,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 * I'm not using devm_kzalloc here since it will not be retained
 	 * after exiting this function
 	 */
-	struct_buf = kzalloc(rdesc->struct_size, GFP_KERNEL);
+	u8 *struct_buf __free(kfree) = kzalloc(rdesc->struct_size, GFP_KERNEL);
 	if (!struct_buf)
 		return -ENOMEM;
 
@@ -638,56 +690,31 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 */
 	ret = rmi_read_block(d, addr, struct_buf, rdesc->struct_size);
 	if (ret)
-		goto free_struct_buff;
+		return ret;
 
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
-		int reg_size = struct_buf[offset];
+		int item_size;
 
-		++offset;
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8);
-			offset += 2;
-		}
-
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8) |
-					(struct_buf[offset + 2] << 16) |
-					(struct_buf[offset + 3] << 24);
-			offset += 4;
-		}
+		item_size = rmi_parse_register_desc_item(item,
+							 &struct_buf[offset],
+							 rdesc->struct_size - offset);
+		if (item_size < 0)
+			return item_size;
 
 		item->reg = reg;
-		item->reg_size = reg_size;
-
-		map_offset = 0;
-
-		do {
-			for (b = 0; b < 7; b++) {
-				if (struct_buf[offset] & (0x1 << b))
-					bitmap_set(item->subpacket_map,
-						map_offset, 1);
-				++map_offset;
-			}
-		} while (struct_buf[offset++] & 0x80);
-
-		item->num_subpackets = bitmap_weight(item->subpacket_map,
-						RMI_REG_DESC_SUBPACKET_BITS);
+		offset += item_size;
 
 		rmi_dbg(RMI_DEBUG_CORE, &d->dev,
 			"%s: reg: %d reg size: %ld subpackets: %d\n", __func__,
 			item->reg, item->reg_size, item->num_subpackets);
 
 		reg = find_next_bit(rdesc->presense_map,
-				RMI_REG_DESC_PRESENSE_BITS, reg + 1);
+				    RMI_REG_DESC_PRESENSE_BITS, reg + 1);
 	}
 
-free_struct_buff:
-	kfree(struct_buf);
-	return ret;
+	return 0;
 }
 
 const struct rmi_register_desc_item *rmi_get_register_desc_item(
-- 
2.54.0.545.g6539524ca2-goog

