Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875535;
	b=p1NDBtfAp2MFDiLLxp5Jz2N+SwhSTBkKpR76gYOA7K10EVP1ztkCURpsSTjxug2ZFus6
	 t5oP6BLysHlCMhWSUDdmU19RE3WJuz07pzecRnqNqpeP/Pm8Hl1tKP0AiogvRBLTzrdEu
	 OBvvu0EPV6wOhOV+LvzWYLE5XmD3O+Gx2yFF53WhW2gxng78POjX9qBJTxSw7olX1UvXU
	 Eln0S9NMW9tbXTeVTbE4KPOTqSNp7fRi7bUaRHxs28aHDOXFjgmijMA3JDGDnaJlkjvAa
	 4v684+xjGv5El0GFAt/SZKkeX8XBb1OiuV/vqgoucDJTBkE8iMTWk0l8AAncnZ1Odnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0gEEqY5moJFLyXTDq3FJpo70RB3nQcSkzxwqlez+5HY=;
	b=2x1H1XmyZfuitkLcBFD63UIBiwdUFfCxDkED9uateXTE4C8hvq6q6aiBoCRQt7DmQKXO
	 0WpyzHzXnRTpOptrckl+Bi2g8LaJXVzqCLK3zSyiI19rpWGqZUiOcQ/A8g4VvKMo1Vo8X
	 v3MlhCmObLF8Q2UXfYFWqP4tObSjNsuQ120ht5MZ2t20fV2RrsSjyZfHJMa3KjpujlWGT
	 iI37HMclmPKFrVLhcpHVyndpBIO+T9fe1WDa01NaTyEtbQa+WRWauy61579ejSGXyBM+Y
	 TEa8AEUYXiRYya7XJBcyFSFxZ42tUsSJKBHuU4L738z9KqDIeg1lVBFSHoroms2fdAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A671s1j3;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B1606A31B
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 20:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01B1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A671s1j3
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so11404485e9.1
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875533; x=1793480333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0gEEqY5moJFLyXTDq3FJpo70RB3nQcSkzxwqlez+5HY=;
        b=A671s1j3cd4WMgNieeS0Ogl2fqknNfjsy6cJ0DvylYWrlrlqcn5Pd50guNSxZu2WkQ
         nL6y34agPKiPL2lSIL6xvSHnULVH6vr14x94avLDxw4swX7RsuN6TRPePe8QhFlib5UJ
         IKnj2WhlgniNNvkQSjb8HVrB6VYHBHV0Z7caDf5s4gu9D+yYexXJCl+ktntSujVUl4WX
         Afm4hyVRDM1I88OR+WBJeTk668L2x3rJpmB7B96lqYPaoqlIxiuAFTI4TIji3ixh1RTS
         7MqmUOjoknwxJefHgHYXKmjDrz4YiE6wZ+mfMV2CIrchvkfWz9DmIcrIB7GX1zqY/Lr8
         qhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875533; x=1793480333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gEEqY5moJFLyXTDq3FJpo70RB3nQcSkzxwqlez+5HY=;
        b=GVpYXZtRFwqgGRh+MlhBi63VGPn7SzXgj6/S2u2OB6VBDAF52XFljl7ixSNG1jhz35
         GhpLOKtzV8R/0MS+6t8WYK8y+PvQzFfTteQDvT7kSGaIQA/jOWNxIjvCtpIOkHHSQ/Ir
         ZdqeqTsT1yoO1mIBlDn5omXUTJa0BMNuIj0ZIoyzDPerSrKRv4JUkg/RRqWgpywpIdXa
         M1c7aUHtP7s2935/RtunWGPSBdzRPmXXBrHmCnYM7uOdBaueRbus4H69OdCe796T3GAr
         dQ+UJxbO6utz2MQrl3LbQov/9Sv9kH56AsSv39AfGMDnjPMLyMOjhiOd3mx2X5Kxebzl
         8Sng==
X-Forwarded-Encrypted: i=1; AKwUvBwgbKZD2lO4GHSbGrUgW/tOD8huwaLVbNU9LLq6eJimrGI8mkdqtH4dK4PcuedIKpNt94vOcMsnyN4eig==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLTxXoqgB5hQ8NGZodeLYlSt8F2ZEfokaKSdn4TwBxpgky08YH
	5e6Ps3tOsw3IH8NVQHzcjVDPkQt0CxXKP9km9FLhCdaenVr485TauJY=
X-Gm-Gg: AYBFou33We+gqSv+A5wTgQQ29CtCU9CR5VX5QPS20GdQZqiW6fzEdoqF+TgxK0NfA4e
	Fw2hTFxKRQbaTnny+bb+HrbUJulhFger1nWVuWLm934XhXKf1p+O/YJiVI49qVQr+hlCbJ82Ag3
	GN7pHglPOaZ09Dvm7YgZMN6DOfQG3Ha+l48t7ikJleoRMdaZ06BIpy5t8AeKhHzqwPv32EyxpA4
	dLIMfCcdTpmyYl/7WYgyYDqe8PlkYAFA9+gM7+/rrRoeX5xlg89CfNL3Juk+1wbQQkpDp0hutNd
	kq6qGdO0S1sgW0vhGY4uA5dzRAc8Qhx3NJ5XJkWvPShkWm6MwiObNt8JdgNZFkuthMGxPfteidL
	LIGXWuxXqpx9HdVzsFZPjzkOKG/821MkFEH2xikl0wOf5NbtJVix+4wcp6dWDp7GZouiXdD3Yjk
	+MxCJKDBdDpuwlqyUwIxy5dpzXPO6pjVYglLpEUZwy9xcHjWau3gPkMLWaI8PdVjVdvGlI62OIm
	+nybu2ny7XHCWSP8ImWY5Af
X-Received: by 2002:a05:600c:3b82:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4a35ae71a3emr46309225e9.6.1792875533189;
        Sat, 24 Oct 2026 13:58:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a4cb7bece3sm25238465e9.10.2026.10.24.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:58:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Xinpeng Sun <xinpeng.sun@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] HID: intel-thc-hid: validate ACPI buffer length before use
Date: Sat, 24 Oct 2026 20:58:50 +0000
Message-ID: <20261024205850.4051206-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The QuickI2C and QuickSPI ACPI helpers copy firmware-returned buffers
into fixed-layout caller structs without checking the buffer length
against the destination size:

1. Buffer copies use the firmware-reported length without checking
   it against the destination buffer size, allowing stack overflows
   from oversized responses.
2. Undersized buffer responses leave caller struct fields
   uninitialized, as fixed-layout structs like i2c_param and
   i2c_config are consumed field-by-field after the call.
3. The QuickI2C DSD helper does not validate the returned ACPI
   object type before accessing buffer-specific fields.

Add a buf_size parameter to all three helpers and enforce exact
buffer size matching for BUFFER type properties. Add type validation
in the DSD helper (the DSM helpers already receive type-checked
results from acpi_evaluate_dsm_typed()).

Fixes: 5282e45ccbfa ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C ACPI interfaces")
Fixes: 7cb06f08ef13 ("HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI ACPI interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 .../intel-quicki2c/pci-quicki2c.c             | 40 ++++++++++++++----
 .../intel-quickspi/pci-quickspi.c             | 41 ++++++++++++-------
 2 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 2537288b50261..a3d71f296b462 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -62,7 +62,8 @@ static const struct acpi_gpio_mapping quicki2c_gpios[] = {
  * Return: 0 if success or ENODEV on failure.
  */
 static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t *guid,
-					  u64 rev, u64 func, acpi_object_type type, void *prop_buf)
+					  u64 rev, u64 func, acpi_object_type type,
+					  void *prop_buf, size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
@@ -75,10 +76,17 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t
 		return -ENODEV;
 	}
 
-	if (type == ACPI_TYPE_INTEGER)
+	if (type == ACPI_TYPE_INTEGER) {
 		*(u32 *)prop_buf = (u32)obj->integer.value;
-	else if (type == ACPI_TYPE_BUFFER)
+	} else if (type == ACPI_TYPE_BUFFER) {
+		if (buf_size > 0 && obj->buffer.length != buf_size) {
+			int err = obj->buffer.length > buf_size ? -ENOSPC : -EINVAL;
+
+			ACPI_FREE(obj);
+			return err;
+		}
 		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
+	}
 
 	ACPI_FREE(obj);
 
@@ -97,7 +105,8 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t
  * Return: 0 if success or ENODEV on failed.
  */
 static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string dsd_method_name,
-					  acpi_object_type type, void *prop_buf)
+					  acpi_object_type type, void *prop_buf,
+					  size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -113,7 +122,18 @@ static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string
 
 	ret_obj = buffer.pointer;
 
+	if (ret_obj->type != type) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+	if (buf_size > 0 && ret_obj->buffer.length != buf_size) {
+		int err = ret_obj->buffer.length > buf_size ? -ENOSPC : -EINVAL;
+
+		kfree(buffer.pointer);
+		return err;
+	}
 	memcpy(prop_buf, ret_obj->buffer.pointer, ret_obj->buffer.length);
+	kfree(buffer.pointer);
 
 	return 0;
 }
@@ -145,7 +165,7 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_HID_DESC_ADDR,
 					     ACPI_TYPE_INTEGER,
-					     &hid_desc_addr);
+					     &hid_desc_addr, 0);
 	if (ret)
 		return ret;
 
@@ -155,7 +175,7 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_ACTIVE_LTR_VAL,
 					     ACPI_TYPE_INTEGER,
-					     &qcdev->active_ltr_val);
+					     &qcdev->active_ltr_val, 0);
 	if (ret)
 		return ret;
 
@@ -163,12 +183,13 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
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
 
@@ -180,7 +201,8 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 	qcdev->i2c_config.target_addr = i2c_param.device_address;
 
 	ret = quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_ISUB,
-					     ACPI_TYPE_BUFFER, &i2c_config);
+					     ACPI_TYPE_BUFFER, &i2c_config,
+					     sizeof(i2c_config));
 	if (ret)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad676fde211b6..ec15ded2e91ea 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -81,7 +81,8 @@ static const struct acpi_gpio_mapping quickspi_gpios[] = {
  * Return: 0 if successful or ENODEV on failed.
  */
 static int thc_acpi_get_property(struct acpi_device *adev, const guid_t *guid,
-				 u64 rev, u64 func, acpi_object_type type, void *prop_buf)
+				 u64 rev, u64 func, acpi_object_type type,
+				 void *prop_buf, size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
@@ -94,10 +95,20 @@ static int thc_acpi_get_property(struct acpi_device *adev, const guid_t *guid,
 		return -ENODEV;
 	}
 
-	if (type == ACPI_TYPE_INTEGER)
+	if (type == ACPI_TYPE_INTEGER) {
 		*(u32 *)prop_buf = (u32)obj->integer.value;
-	else if (type == ACPI_TYPE_BUFFER)
+	} else if (type == ACPI_TYPE_BUFFER) {
+		if (buf_size > 0 && obj->buffer.length != buf_size) {
+			int err = obj->buffer.length > buf_size ? -ENOSPC : -EINVAL;
+
+			acpi_handle_err(handle,
+					"_DSM buffer size mismatch: %llu vs %zu\n",
+					(unsigned long long)obj->buffer.length, buf_size);
+			ACPI_FREE(obj);
+			return err;
+		}
 		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
+	}
 
 	ACPI_FREE(obj);
 
@@ -129,7 +140,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_HDR_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->input_report_hdr_addr);
+				    &qsdev->input_report_hdr_addr, 0);
 	if (ret)
 		return ret;
 
@@ -137,7 +148,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_BDY_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->input_report_bdy_addr);
+				    &qsdev->input_report_bdy_addr, 0);
 	if (ret)
 		return ret;
 
@@ -145,7 +156,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_OUTPUT_REP_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->output_report_addr);
+				    &qsdev->output_report_addr, 0);
 	if (ret)
 		return ret;
 
@@ -153,7 +164,8 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_READ_OPCODE,
 				    ACPI_TYPE_BUFFER,
-				    &qsdev->spi_read_opcode);
+				    &qsdev->spi_read_opcode,
+				    sizeof(qsdev->spi_read_opcode));
 	if (ret)
 		return ret;
 
@@ -161,7 +173,8 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_WRITE_OPCODE,
 				    ACPI_TYPE_BUFFER,
-				    &qsdev->spi_write_opcode);
+				    &qsdev->spi_write_opcode,
+				    sizeof(qsdev->spi_write_opcode));
 	if (ret)
 		return ret;
 
@@ -169,7 +182,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_IO_MODE,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->spi_read_io_mode);
+				    &qsdev->spi_read_io_mode, 0);
 	if (ret)
 		return ret;
 
@@ -184,7 +197,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_CONNECTION_SPEED,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->spi_freq_val);
+				    &qsdev->spi_freq_val, 0);
 	if (ret)
 		return ret;
 
@@ -192,7 +205,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_LIMIT_PACKET_SIZE,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->limit_packet_size);
+				    &qsdev->limit_packet_size, 0);
 	if (ret)
 		return ret;
 
@@ -205,7 +218,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_PERFORMANCE_LIMIT,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->performance_limit);
+				    &qsdev->performance_limit, 0);
 	if (ret)
 		return ret;
 
@@ -215,7 +228,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_ACTIVE_LTR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->active_ltr_val);
+				    &qsdev->active_ltr_val, 0);
 	if (ret)
 		return ret;
 
@@ -223,7 +236,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_LP_LTR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->low_power_ltr_val);
+				    &qsdev->low_power_ltr_val, 0);
 	if (ret)
 		return ret;
 
-- 
2.47.3

