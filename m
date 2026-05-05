Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2213C7E18
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957215; cv=none; b=YOIaDDCgof0k/8YsTV/jh2QE4JVS5LGoHQ64oazT6J6vKrf+wAnxd/3K+xaYFssIqBnBNISIu3+Zrj+8qSjWxhwKpjzeAxhT1NAJWTMh4J94uXvIkG7SS/LwCuPb52N2OZ/EGR4JXReuczR2csCM4MJeGlbpr12GqetjZIFj3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957215; c=relaxed/simple;
	bh=h3GE8rguA0rlF0zY7kVFVST8pSh7b8+zVIYW6bmhAJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUnO0suuX8aZmliyYzyCyispZNdqFTocnBt4snQp4IawpWsODyEntici0g7JfBTgI8WU7IF/wkefmIkqteiOtVkyvfL7hg5A75ZzPYzqFuhExolqsRZPS0dzItKz774ikqyhjgnIQwTKnqJksy6tOdOTX5Yfy1EO3m7i1atpmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJGmghx+; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJGmghx+"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8ccc7755so6837353c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957212; x=1778562012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usAxuDPizzUElkgkg4/Jk8Nua06I7c2r+/1S2ICiVKk=;
        b=TJGmghx+D9mv/JdEMyM64xYH8ASrl9OyctX+vqF1osLGrfMG0rV5TSlhfiaaBdhwQh
         TjtjI1X79B6N59843dGCvjH7Bp/Y5Umvp9GPkMHgZxCDn+LEwNtghtRCyFXwhmkbUXQU
         Jvy0ylaagW5T6q/RQhQRmbHy48KZL6c9tLP2myyAhik8FKWr67ov2+KCeeu9DsQtCSfq
         pNyzliM1uFYw7+0y2TKTrsVPCu2xSqvS8IxZgbO4ouH7yOfd5U9r6FLsy60xtNxNvDIi
         02Ur3MGd6AGxEPo0qaORCcMiWkcV7mujAiM0QtQ/Kdga0rx1FhVdAzXz75I7hWoRlu6j
         2+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957212; x=1778562012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usAxuDPizzUElkgkg4/Jk8Nua06I7c2r+/1S2ICiVKk=;
        b=GLnxmGCE7pFeJu+zRlJ3x9ccK8/ilbdA9uFp5Tkwl1jGZKRYnyD5r3kXiJqz+wgd52
         7SByzNYcp4p4HZS77ZsFVkO+oSZDLYASXYAAzyUmv09deDnJOAWVsCACljsqSnEkcZJg
         wGh/770htrFwiRIkZx0MdRuUjdT3Hk1A9CkFCi1HxShXkZ1qz+BALltpl4sCODsd5nXe
         8eDluUvhmCYNlO5kKsMpozVp1IRfKdOEVuIBYpNIIhxnxBDCy4gloFRgAySND5/j2Mqb
         S/MRbB9iN54I6dptoR3zSUFa9bNm7VZj3RenognM51vhxwqDugu/c4L3ymCdTEJ26VW4
         wrrQ==
X-Gm-Message-State: AOJu0Yz5p42UvNfKlFR5pgW5xsx69xDTu6S1OBbyBTxx6f2X8B3UiH6D
	ykmTssAoGnIEHWyoi38FNSCRmopXq9EHjLAaHuoEJw/cwS0aPVsEaO/lDPFC2g==
X-Gm-Gg: AeBDietjK1kNDAjpELrtRiMJtoEPGy9w31FrKPjyS/DIUFTtjdWIoYssvMJeoE2wAPo
	PEL0onzogQTwYgzU9WXgrJL0elGunut6zK1A6ufnbwvrtn5u0AFpBaJ6ZcrE7DOYjad4+3WflHi
	qzaSxV7TS2NTZxYnts0LL7DlJ5fjXy2byedzZNcB/vOWRvzpgTGpfKTWFoMPH2+atYIC05QfSD2
	EQXPG7+ndnLqIzE5PRDSFNC/13TTgP77/SToR2kjfXDeLR6vLta+qtXdeCjqWTkkAqu3lCxohMi
	voSYtcnK6ixlXyZRe/MBz0wF6X4DKDyIFE+AdVLl1KvAbPnBzbb6HUbh3bLspmrmxQYYtrB+M6I
	FTE1qnUP/RqX4d2CSGpGIIwQcvZi/D6dVPqmrQJIggpLNL7TVmqb3ncyUAuFI2eQjvgxpFuQBUI
	R0DZDCYjBbJMzelSc021xA1xpscPHAUYG9a4E85HMcdSadLpnF+/yGEYbxtkKxfHRCvtcIwiQYP
	DYbogedek+PS84RzILdrpM5OA==
X-Received: by 2002:a05:7022:512:b0:12d:de3e:86b6 with SMTP id a92af1059eb24-12dfd843301mr5022082c88.38.1777957212272;
        Mon, 04 May 2026 22:00:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/20] Input: rmi4 - use local presence map in rmi_read_register_desc()
Date: Mon,  4 May 2026 21:59:39 -0700
Message-ID: <20260505045952.1570713-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The presence map is only used during the parsing of the register
descriptor, so we can make it a local variable instead of storing it
in struct rmi_register_descriptor.

Also fix the spelling of the constant and the variable name (presence
instead of presense).

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 22 ++++++++++++----------
 drivers/input/rmi4/rmi_driver.h |  4 ++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 84cf7df705f9..6755dd66d62f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -610,15 +610,16 @@ static int rmi_parse_register_desc_item(struct rmi_register_desc_item *item,
 int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 			   struct rmi_register_descriptor *rdesc)
 {
-	int ret;
+	DECLARE_BITMAP(presence_map, RMI_REG_DESC_PRESENCE_BITS);
+	u8 buf[RMI_REG_DESC_PRESENCE_REGS_MAX];
 	u8 size_presence_reg;
-	u8 buf[35];
 	unsigned int presence_offset;
 	unsigned int map_offset;
 	unsigned int offset;
 	unsigned int reg;
 	int i;
 	int b;
+	int ret;
 
 	/*
 	 * The first register of the register descriptor is the size of
@@ -629,7 +630,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		return ret;
 	++addr;
 
-	if (size_presence_reg < 1 || size_presence_reg > 35)
+	if (size_presence_reg < 1 || size_presence_reg > RMI_REG_DESC_PRESENCE_REGS_MAX)
 		return -EIO;
 
 	memset(buf, 0, sizeof(buf));
@@ -654,20 +655,21 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		rdesc->struct_size = buf[0];
 	}
 
+	memset(presence_map, 0, sizeof(presence_map));
 	map_offset = 0;
 	for (i = presence_offset; i < size_presence_reg; i++) {
 		for (b = 0; b < 8; b++) {
 			if (buf[i] & BIT(b)) {
-				if (map_offset >= RMI_REG_DESC_PRESENSE_BITS)
+				if (map_offset >= RMI_REG_DESC_PRESENCE_BITS)
 					return -EIO;
-				bitmap_set(rdesc->presense_map, map_offset, 1);
+				bitmap_set(presence_map, map_offset, 1);
 			}
 			++map_offset;
 		}
 	}
 
-	rdesc->num_registers = bitmap_weight(rdesc->presense_map,
-						RMI_REG_DESC_PRESENSE_BITS);
+	rdesc->num_registers = bitmap_weight(presence_map,
+						RMI_REG_DESC_PRESENCE_BITS);
 
 	rdesc->registers = devm_kcalloc(&d->dev,
 					rdesc->num_registers,
@@ -695,7 +697,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	if (ret)
 		return ret;
 
-	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
+	reg = find_first_bit(presence_map, RMI_REG_DESC_PRESENCE_BITS);
 	offset = 0;
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
@@ -714,8 +716,8 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 			"%s: reg: %d reg size: %ld subpackets: %d\n", __func__,
 			item->reg, item->reg_size, item->num_subpackets);
 
-		reg = find_next_bit(rdesc->presense_map,
-				    RMI_REG_DESC_PRESENSE_BITS, reg + 1);
+		reg = find_next_bit(presence_map,
+				    RMI_REG_DESC_PRESENCE_BITS, reg + 1);
 	}
 
 	return 0;
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 6952059bf4f5..b93905a6a43a 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -46,7 +46,8 @@ struct pdt_entry {
 	u8 function_number;
 };
 
-#define RMI_REG_DESC_PRESENSE_BITS	(32 * BITS_PER_BYTE)
+#define RMI_REG_DESC_PRESENCE_BITS	(32 * BITS_PER_BYTE)
+#define RMI_REG_DESC_PRESENCE_REGS_MAX	(3 + RMI_REG_DESC_PRESENCE_BITS / 8)
 #define RMI_REG_DESC_SUBPACKET_BITS	(37 * BITS_PER_BYTE)
 
 /* describes a single packet register */
@@ -64,7 +65,6 @@ struct rmi_register_desc_item {
  */
 struct rmi_register_descriptor {
 	unsigned long struct_size;
-	unsigned long presense_map[BITS_TO_LONGS(RMI_REG_DESC_PRESENSE_BITS)];
 	u16 num_registers;
 	struct rmi_register_desc_item *registers;
 };
-- 
2.54.0.545.g6539524ca2-goog

