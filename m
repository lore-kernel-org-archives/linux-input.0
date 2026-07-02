Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A3B4404
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031567; cv=none; b=sRHOXYrqVWuzpYxxgQDCpM39d8fW730ngxwkX5vDI9sOOk7sO0EG4jbd3Uvs1u1Q6jaacqJcJbMTShpzD+41MGdDPbLfSBwl4NDkn5DBBOmt/TOYXOD7RMzKFCTLOwYJE1FUvZ3nkfAapiJd1NV5SQ4KGX1zu1giWfvcv0ZB2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031567; c=relaxed/simple;
	bh=QBVPiLZntn2OgtRozbNIN0eLE84VM0ciMJhKWr14BtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tW8oSOYWr1vD2yp/6yu4Apihoq5EVP5SIpOaQ1hxVj9ASelWbBANj0iAN71Rh/2Bl83q6+IO1cRUokV624TDWgJOYNHFeonfxwECkBZgEAPaCC/5vj9dIgwTyZ0zw5oNpjCjgBZGCIG0R1YvT7LfzVes00thBF+EZQxrAxC6xfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1wfPxW-00081n-Fr; Fri, 03 Jul 2026 00:32:38 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 03 Jul 2026 00:32:22 +0200
Subject: [PATCH v7 1/4] firmware_loader: expand firmware error codes with
 up-to-date error
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-v6-10-topic-touchscreen-axiom-v7-1-0d2a550a7ee8@pengutronix.de>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
To: andrew.thomas@touchnetix.com, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
 Danilo Krummrich <dakr@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Add FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the firmware_loader
framework that the update is not required. This can be the case if the
user provided firmware matches the current running firmware.

Sync lib/test_firmware.c accordingly.

Reviewed-by: Russ Weight <russ.weight@linux.dev>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/base/firmware_loader/sysfs_upload.c | 1 +
 include/linux/firmware.h                    | 2 ++
 lib/test_firmware.c                         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index efc33294212fd82bb1a8c426d7430ef96c6620b2..82c4b1fedf4cdd0b41fd9acb0cfc1688d726a6fd 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] = {
 	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
 	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
 	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
+	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
 };
 
 static const char *fw_upload_progress(struct device *dev,
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 0fa3b027f02f16ffc4a28d4209c3af9319dd8bea..86a2f010e0c1e833d8456cadf21743b9f86dbde5 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -29,6 +29,7 @@ struct firmware {
  * @FW_UPLOAD_ERR_RW_ERROR: read or write to HW failed, see kernel log
  * @FW_UPLOAD_ERR_WEAROUT: FLASH device is approaching wear-out, wait & retry
  * @FW_UPLOAD_ERR_FW_INVALID: invalid firmware file
+ * @FW_UPLOAD_ERR_DUPLICATE: firmware is already up to date (duplicate)
  * @FW_UPLOAD_ERR_MAX: Maximum error code marker
  */
 enum fw_upload_err {
@@ -41,6 +42,7 @@ enum fw_upload_err {
 	FW_UPLOAD_ERR_RW_ERROR,
 	FW_UPLOAD_ERR_WEAROUT,
 	FW_UPLOAD_ERR_FW_INVALID,
+	FW_UPLOAD_ERR_DUPLICATE,
 	FW_UPLOAD_ERR_MAX
 };
 
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7459bba65444d1d153667ab3fc447c375418e938..a822d9641eb4c4db01d9966f76f080ede31027f3 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1134,6 +1134,7 @@ static const char * const fw_upload_err_str[] = {
 	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
 	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
 	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
+	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
 };
 
 static void upload_err_inject_error(struct test_firmware_upload *tst,

-- 
2.47.3

