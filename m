Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D01C5F1B;
	Sun,  9 Aug 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786285798; cv=none; b=dgcnxuQ+IO5mJWYXJ+BiznYfdLBr7112XzEzm4CNWqep8FpAXUy0t1BoUPP71VEGNLPgmBVkK0iRZcjgjTSgEtq9JV+G54Q+cZqxTYqzABn8lOiZ69EyI9HdgmXZldD8bZV9MUinx/bLS7b7W4c0EBjzv9YaHEaw7TaP4LxCkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786285798; c=relaxed/simple;
	bh=0hjbQuhFleRJRePB95dAXKzDpQpxhHBMyQMXfgsto+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpfESjqR7bkibYsFaYcVAyr27BWgtQeBPm4sRXlzVfhZ67ZCGrPecqkLtWc7JHRQ11+pD2Uu41MMIMokF7FmF1WlEJbjOFGiGpFl8dYHl9dAloldEbhmnJlomdrsO1jYCbSGJVACEmcDjFHZvUXFjbG/s6mdESp9HF2MuoJUlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FfvSdxof; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FfvSdxof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=b5
	+UKyU9byORiq0L7YFbUkIKfWK86UnFkt3okxn1HfQ=; b=FfvSdxofEs2K1ZaMSO
	NkwfDV0zPVJN7GxyQSodQ2DTS/6JNZvwDICQf7jIbHUphjtHIoOmxDqcGeoxJUsy
	ogmdLdKDbTCRfQlJ63BaSzSq+C5aV+cf24+JqjD2htH2+gvgp0BYyR9+7x6MAJog
	1wMaDBylg1HNsTkUyBxYoly3Y=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHLpPUjnhqIfn6Og--.53573S2;
	Sun, 09 Aug 2026 22:29:41 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH] Input: elan_i2c - Use device-id/acpi.h for ACPI IDs
Date: Sun,  9 Aug 2026 22:29:28 +0800
Message-ID: <20260809142928.4031270-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHLpPUjnhqIfn6Og--.53573S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1rJr1kGFWrCr4kGr1kGrg_yoWDJrc_Zw
	1fu3ykWr4rJry0qws5WF1fJryaq3WSkFW8u3ZYyr1kAa4kJ390kayDJasFv34UW3Z2kr1r
	W3WFga4rCw1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjMmh3UUUUU==
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3BWRimp4jtV+PwAA3a

From: Longlong Xia <xialonglong@kylinos.cn>

elan-i2c-ids.h only needs struct acpi_device_id from the ACPI
device ID definitions. The MODULE_DEVICE_TABLE() user already includes
<linux/module.h>.

Include <linux/device-id/acpi.h> instead of the broader
<linux/mod_devicetable.h> header.

Assisted-by: Codex:GPT-5
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 include/linux/input/elan-i2c-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
index 51cca17ee94c..874bf0ab500c 100644
--- a/include/linux/input/elan-i2c-ids.h
+++ b/include/linux/input/elan-i2c-ids.h
@@ -18,7 +18,7 @@
 #ifndef __ELAN_I2C_IDS_H
 #define __ELAN_I2C_IDS_H
 
-#include <linux/mod_devicetable.h>
+#include <linux/device-id/acpi.h>
 
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
-- 
2.43.0

