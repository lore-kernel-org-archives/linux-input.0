Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964454;
	b=LXag9sq5xtiNeIbhqkFHf/oPafmG+XD/1HeEqcr5bKxEQHvP+XIQrmge4M59+ZS+lq/m
	 bW37x9OK3k3XMnw6RMMBk0dGUmjZtvRt1TVQKhHX2QUyap7LWmQbaeaQMQQMTEpqwbIO0
	 8UU0tqwk3xw7AN/vKfR9vdSFy7/AbeFDLc2RKbMFfoZGmxP5txsEYTYg3bZjd6AIJ1r1g
	 5JP2uZhPtXui1qG7Zc9yxQjM5k7QO2ZduYhMoVJYNoW3qAEfWN/Y4l6cf8MUjcX/9/r/1
	 DSXMwTWlAQBcF1XuIWmO+e4XLdfLoCE859FzvF+NpRDJEOD3j+Ltjtsh2RSF7JSKovw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bey6djtXaClvBf7svzpGUE2le4QW4YwIFNTrV6lB9vA=;
	b=LPJmvV4Ez9jAzOL4H7kUnoFJZ7eK2OEWoXJjihHBRAJTHo9rVMpeUlc6Wjb3PqM9b8wB
	 rxerkoXEdts8EuGR/i248n7xgFfbW4iWsDcfuxVOJSxB71QjS8GnjPpszhF4/rfmN44jH
	 ziAUsABwdfYAK2IdrGu6TzuIK97MDRqi5f1EOfGGePKWOwjcCksrTj2AsKRmjtnGLwcxm
	 Ji4pTWzrgTzNRJVg/ToO6nghh5ZU3VxhQpgOhKQi+cD05TXTT7ll1UnL9Lh6jS0yrKijg
	 PfPjB/YfccM/N6atLT7hnrHhWxAtABpoUmKbNMmKyZs6owXCtQ/JUs3BhvOac1IDSIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dw7TGTWV;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93B606A31B
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 21:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA93B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dw7TGTWV
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so16256335e9.2
        for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792964452; x=1793569252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bey6djtXaClvBf7svzpGUE2le4QW4YwIFNTrV6lB9vA=;
        b=Dw7TGTWV4KUsbBwGc9/qy/lMLb4YXbjqi58karSBfxeSYC9CsuzZi6VGAxYsBoaJZM
         QnUagw3gcmpipuDtVG1IKLY96PHwE3KrswG7+T7V3QkOuCy2l5FaXhgTevJLPKzB4GEf
         ZuSsosA2UCv1hvVxRbB+H0n1JBMQyC3/Iry3C9Y3Qdim7XAFzG2x/p079qTT6eCr+B3E
         KvTtOhG246fYvyxTFQVf4n95hcWDVo4O01gOhOhGXdx1c8HqYi7MgLj9a5zYhlNAx887
         sMENcIb5x6Jj1eJRtJoM7lw2Xut971lswNJczMYGjrJuWIUFFL/hci9jEP1ME2ASBeZL
         Btmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792964452; x=1793569252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bey6djtXaClvBf7svzpGUE2le4QW4YwIFNTrV6lB9vA=;
        b=Z8FuJJqgS9lov6QFDGgD8Dzks/UNspfGtzLW0R5ItVWaBkzXpF9XJnnJUYJiyAyjiJ
         fUNw5KHI5GzLxgbYr5D45/KSSXWeiPho0Dyl/jCCi4BRaxUV3H00RCz2sSnXqvt7IzC6
         GUmzjg2VlYW8ABvlz7I5Z6lG7r+8LjDRI0BufFeYLF/SHgN4EB0YFepQjpcq/3W1OJcC
         BtPKfOs5q15I0GHTCR7f7FOqNUyR6EuwLCVe93oOE5NfoBx+zwGAIFJuK0+uiXGQqwnK
         v9GapWkS0HVBYKEIVz7U+rzmdW7aWLpXHhe7RXd++eYEsb/q2ILsHkM71pa1OwlwASuO
         WFKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZGIFGgKKBmCDraRZvu4TQm6bWIEztAjNbB/3AzjkNhk5uVaWxPDWb599IJpWWAIJS2/MISz0ezYaUOQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKd96K2qxT1b8SUHsZPTffx+/0tS/BntLz3RoaZfj0klVmw1UMS
	PHSXlc3s2F4dY3v7R6kV0V9vDcDiyVSjEgBViqfbkmSe+jS1wBfj1rw=
X-Gm-Gg: AYBFou34qdChFQl2uFOCB3u4dYazzdg6+7e89eplRrZbKSg7V36D7bpZX5FF6wj9tvg
	0++l+aoMo2BXAsAjzj9FwE7vQNu7G40R9YOLifAGxf+cMugZtK2ht7dMRQ+DBAe0wDy2UYqQqpL
	XN/8CRdlBDJEpRlt0MbIv2xzB3wKZ6SdGKtJJPqDBCx5fZSRw1g3fXWXqdbqhSFH22d1V/+M5KD
	Q41e97hD09QuO+0lfxho1+vRbMKZAIvRjGqahsEy0qihSwWQnPUMCNkP2czhzDIzDvwtYRNsaHr
	UdWPPNRBDzbGXmVIzSgVy3Fgz5AuueveilRbP7GweFylrIC8N6mcELrWfIQDtEdcE9uLPzJMjMM
	x4jv/6gQMYQerzweHmvfov8J1qSQqwp4HzYJ7HEhi8W64xBEmSiTPgi+8tCi4yNblR4l8fatRRI
	rwCYk3Cto6nHGYuHIIoWQSEIEW6NOT4XYkROhl6bShTE3NWwdOaqpmyEPnRTjbLv8KDtDW7KbgC
	EHpuGMu1OLh8DsFDDJpdCZwgLTJIvq+7sw3kQ==
X-Received: by 2002:a05:600c:8b78:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4a5dc5d2382mr30369105e9.14.1792964451903;
        Sun, 25 Oct 2026 14:40:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbb725sm145762685e9.0.2026.10.25.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:40:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Cc: even.xu@intel.com,
	xinpeng.sun@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3] HID: intel-thc-hid: validate ACPI buffer length before memcpy
Date: Sun, 25 Oct 2026 21:40:50 +0000
Message-ID: <20261025214050.839232-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024205850.4051206-1-tristmd@gmail.com>
References: <20261024205850.4051206-1-tristmd@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QuickI2C and QuickSPI ACPI helper functions copy firmware-returned
buffers into caller-provided structures without verifying the buffer
length. Malformed or short ACPI tables could cause an out-of-bounds
read from the firmware buffer, and oversized responses could overflow
the destination struct.

Additionally, quicki2c_acpi_get_dsd_property() does not validate the
returned ACPI object type before accessing buffer fields, and does not
free the allocated ACPI buffer on the success path, leaking memory on
every call.

Add a buf_size parameter to the ACPI helper functions and reject
responses larger than the destination buffer. Accept shorter responses
to handle firmware that returns buffers without struct tail padding
(e.g. ISUB tables returning 177 or 145 bytes for a 184-byte struct).
Zero-initialize caller stack structures so fields beyond the firmware
response length are deterministic. Add the missing type check and
kfree to the DSD helper.

Fixes: 5282e45ccbfa ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C ACPI interfaces")
Fixes: 7cb06f08ef13 ("HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI ACPI interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Add missing @buf_size kernel-doc for all three ACPI helper functions
  (quicki2c_acpi_get_dsm_property, quicki2c_acpi_get_dsd_property,
  thc_acpi_get_property) to fix W=1 and scripts/kernel-doc warnings

Changes in v2:
- Use overflow-only check (>) instead of exact-match (!=) so firmware
  returning shorter buffers (e.g. 177 or 145 bytes for 184-byte ISUB
  struct, or 1 byte for 4-byte SPI opcode) is accepted
- Zero-initialize caller stack structures for deterministic behavior
  with short firmware responses
- Add missing type validation and kfree in DSD helper
- Add braces per coding style
 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++++++++-----
 .../intel-quickspi/pci-quickspi.c             | 37 +++++++++-------
 2 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 7a913f717efaad..b2246c6eaa98de 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -56,13 +56,15 @@ static const struct acpi_gpio_mapping quicki2c_gpios[] = {
  * @func: ACPI method's function number
  * @type: ACPI parameter's data type
  * @prop_buf: Point to return buffer
+ * @buf_size: Size of @prop_buf in bytes (0 to skip length check)
  *
  * This is a helper function for device to query its ACPI DSM parameters.
  *
  * Return: 0 if success or ENODEV on failure.
  */
 static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t *guid,
-					  u64 rev, u64 func, acpi_object_type type, void *prop_buf)
+					  u64 rev, u64 func, acpi_object_type type,
+					  void *prop_buf, size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
@@ -75,10 +77,15 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t
 		return -ENODEV;
 	}
 
-	if (type == ACPI_TYPE_INTEGER)
+	if (type == ACPI_TYPE_INTEGER) {
 		*(u32 *)prop_buf = (u32)obj->integer.value;
-	else if (type == ACPI_TYPE_BUFFER)
+	} else if (type == ACPI_TYPE_BUFFER) {
+		if (buf_size > 0 && obj->buffer.length > buf_size) {
+			ACPI_FREE(obj);
+			return -ENOSPC;
+		}
 		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
+	}
 
 	ACPI_FREE(obj);
 
@@ -91,13 +98,15 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t
  * @dsd_method_name: ACPI method's property name
  * @type: ACPI parameter's data type
  * @prop_buf: Point to return buffer
+ * @buf_size: Size of @prop_buf in bytes (0 to skip length check)
  *
  * This is a helper function for device to query its ACPI DSD parameters.
  *
  * Return: 0 if success or ENODEV on failed.
  */
 static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string dsd_method_name,
-					  acpi_object_type type, void *prop_buf)
+					  acpi_object_type type, void *prop_buf,
+					  size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -113,7 +122,16 @@ static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string
 
 	ret_obj = buffer.pointer;
 
+	if (ret_obj->type != type) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+	if (buf_size > 0 && ret_obj->buffer.length > buf_size) {
+		kfree(buffer.pointer);
+		return -ENOSPC;
+	}
 	memcpy(prop_buf, ret_obj->buffer.pointer, ret_obj->buffer.length);
+	kfree(buffer.pointer);
 
 	return 0;
 }
@@ -129,8 +147,8 @@ static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string
 static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(qcdev->dev);
-	struct quicki2c_subip_acpi_parameter i2c_param;
-	struct quicki2c_subip_acpi_config i2c_config;
+	struct quicki2c_subip_acpi_parameter i2c_param = {};
+	struct quicki2c_subip_acpi_config i2c_config = {};
 	u32 hid_desc_addr;
 	int ret = -EINVAL;
 
@@ -145,7 +163,7 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_HID_DESC_ADDR,
 					     ACPI_TYPE_INTEGER,
-					     &hid_desc_addr);
+					     &hid_desc_addr, 0);
 	if (ret)
 		return ret;
 
@@ -155,7 +173,7 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_ACTIVE_LTR_VAL,
 					     ACPI_TYPE_INTEGER,
-					     &qcdev->active_ltr_val);
+					     &qcdev->active_ltr_val, 0);
 	if (ret)
 		return ret;
 
@@ -163,12 +181,13 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_LP_LTR_VAL,
 					     ACPI_TYPE_INTEGER,
-					     &qcdev->low_power_ltr_val);
+					     &qcdev->low_power_ltr_val, 0);
 	if (ret)
 		return ret;
 
 	ret = quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_ICRS,
-					     ACPI_TYPE_BUFFER, &i2c_param);
+					     ACPI_TYPE_BUFFER, &i2c_param,
+					     sizeof(i2c_param));
 	if (ret)
 		return ret;
 
@@ -180,7 +199,8 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 	qcdev->i2c_config.target_addr = i2c_param.device_address;
 
 	ret = quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_ISUB,
-					     ACPI_TYPE_BUFFER, &i2c_config);
+					     ACPI_TYPE_BUFFER, &i2c_config,
+					     sizeof(i2c_config));
 	if (ret)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 53023e30cf8d47..9b369d289fa81f 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -75,13 +75,15 @@ static const struct acpi_gpio_mapping quickspi_gpios[] = {
  * @func: ACPI method's function number
  * @type: ACPI parameter's data type
  * @prop_buf: point to return buffer
+ * @buf_size: size of @prop_buf in bytes (0 to skip length check)
  *
  * This is a helper function for device to query its ACPI parameters.
  *
  * Return: 0 if successful or ENODEV on failed.
  */
 static int thc_acpi_get_property(struct acpi_device *adev, const guid_t *guid,
-				 u64 rev, u64 func, acpi_object_type type, void *prop_buf)
+				 u64 rev, u64 func, acpi_object_type type,
+				 void *prop_buf, size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
@@ -94,10 +96,15 @@ static int thc_acpi_get_property(struct acpi_device *adev, const guid_t *guid,
 		return -ENODEV;
 	}
 
-	if (type == ACPI_TYPE_INTEGER)
+	if (type == ACPI_TYPE_INTEGER) {
 		*(u32 *)prop_buf = (u32)obj->integer.value;
-	else if (type == ACPI_TYPE_BUFFER)
+	} else if (type == ACPI_TYPE_BUFFER) {
+		if (buf_size > 0 && obj->buffer.length > buf_size) {
+			ACPI_FREE(obj);
+			return -ENOSPC;
+		}
 		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
+	}
 
 	ACPI_FREE(obj);
 
@@ -129,7 +136,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_HDR_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->input_report_hdr_addr);
+				    &qsdev->input_report_hdr_addr, 0);
 	if (ret)
 		return ret;
 
@@ -137,7 +144,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_BDY_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->input_report_bdy_addr);
+				    &qsdev->input_report_bdy_addr, 0);
 	if (ret)
 		return ret;
 
@@ -145,7 +152,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_OUTPUT_REP_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->output_report_addr);
+				    &qsdev->output_report_addr, 0);
 	if (ret)
 		return ret;
 
@@ -153,7 +160,8 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_READ_OPCODE,
 				    ACPI_TYPE_BUFFER,
-				    &qsdev->spi_read_opcode);
+				    &qsdev->spi_read_opcode,
+				    sizeof(qsdev->spi_read_opcode));
 	if (ret)
 		return ret;
 
@@ -161,7 +169,8 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_WRITE_OPCODE,
 				    ACPI_TYPE_BUFFER,
-				    &qsdev->spi_write_opcode);
+				    &qsdev->spi_write_opcode,
+				    sizeof(qsdev->spi_write_opcode));
 	if (ret)
 		return ret;
 
@@ -169,7 +178,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_IO_MODE,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->spi_read_io_mode);
+				    &qsdev->spi_read_io_mode, 0);
 	if (ret)
 		return ret;
 
@@ -184,7 +193,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_CONNECTION_SPEED,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->spi_freq_val);
+				    &qsdev->spi_freq_val, 0);
 	if (ret)
 		return ret;
 
@@ -192,7 +201,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_LIMIT_PACKET_SIZE,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->limit_packet_size);
+				    &qsdev->limit_packet_size, 0);
 	if (ret)
 		return ret;
 
@@ -205,7 +214,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_PERFORMANCE_LIMIT,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->performance_limit);
+				    &qsdev->performance_limit, 0);
 	if (ret)
 		return ret;
 
@@ -215,7 +224,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_ACTIVE_LTR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->active_ltr_val);
+				    &qsdev->active_ltr_val, 0);
 	if (ret)
 		return ret;
 
@@ -223,7 +232,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_LP_LTR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->low_power_ltr_val);
+				    &qsdev->low_power_ltr_val, 0);
 	if (ret)
 		return ret;
 
-- 
2.47.3

