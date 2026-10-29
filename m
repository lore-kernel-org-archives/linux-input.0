Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283043;
	b=ibxHMJvpy8pT58L/REb98SfGRxAYNUsYx85+CJi+cbTY6d0plrcfYNk7rrIAPD1fwJWm
	 1TboEPZ8Klp25PRrwcZ3NqKglq1kIyOV96C5tSIYegwYQzal31AXesR7LTcCKqTDgc6Bi
	 xPnl9vzaKszhn5aa71oMqjQ1I+JYd2kITOrBT1B/eCjhJOjqOcDBBaBI8XoWx+850+QiC
	 2oT4pRZw2eyEFhigfpsebwEfj86xr31Hw5toTOEhVLrFsFVpjTneyGf+pYkvx1NhGZlNJ
	 dHbMi/D0zQ8IZnYzBtG5xmpxf9iJDqHDPUeUVNzbCFh7MNJsljSrpX/4pDc2JSDkGuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vk2sd/A1AobcphO8+KnNKKLDJrQBIKgn8PW5ptXB6YA=;
	b=NqzBe/DO5Pi/KSPi0u+DX3K2WhKtuU4IhH0S77nDoYLqLYAUu9XD2nCEgqfewvWrXHpS
	 pUOKFdoQg8ltBv3TwHDvFNJiNfLSZ/aETJ3AoIRg0KZ0Nme01mrAUN1CT+grHOpS2U6me
	 TEAOhoioHLFTHMrIw3b6HWNOjOWYOWmQmmPDkGRhSGoVCWAUrFuZKhh8KEU6tRmtOoVF7
	 0eF+mU33ZnnpCN4gV3jSR2+LMg7MLvQTRbdGTNcssH/OAW0oaXohysy28ERMXICNJ/g4+
	 NfC3IYgc5UY9TDPbAkPvRNSmSfRQbex3+iADpEA4B2Y1E6m60FlD/0tgWlS+qtvXk+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVmDSdDR;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF575606A326
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 14:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF575606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVmDSdDR
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1651512f8f.3
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283041; x=1793887841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vk2sd/A1AobcphO8+KnNKKLDJrQBIKgn8PW5ptXB6YA=;
        b=PVmDSdDRXDTJMhF/yDyQs7a8ZNmHsFaWItmCnxiD8TtlH/UeqznCwWb+sIiNvlc+bq
         auwQhDlyM12d5facgs/mOfwdB80tyI1JFh+QxwKT0HQV9Gyd0ihTEAf7yd/bVnxxGaeI
         6Pmunp25tyWItK9zbeMMAJ1uaEDJTMvJVer4txZ18oKVlGosSNJPiCy2t5g3tbeu6u4v
         vW1EcGiPahyEECKQ5FL594OjitwWsNTX+WjweX/NTs3hXodqwBuy0CYT+IXMtvckd7Kk
         9nMvE2L+zqfAYHIP0lSPm7WzfcR/iz2vESjoEr1gxdwziFoGga6US1ds5n49aTP3kHR7
         VNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283041; x=1793887841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vk2sd/A1AobcphO8+KnNKKLDJrQBIKgn8PW5ptXB6YA=;
        b=aRvi74CRa0RmHHUUscSFWdJWqU4qOm1+MMB5TD9DRHZcW2v1p2EC4iw3ajru2u3Fnu
         1T7jI0UdrHzeHm1KMOaVCaFLxotkgOIEwBbMfQlm9b8CzKRrqy5WFVSusVHGrgWzDg6j
         KFi+0gs0NX1j+Wx5t4Rn4Hk0LFxZL32j5j2TYpDu9WgfaJH3Q8K5GHBN9N0BYbGniGez
         nbuHRsy6krahgvFIBm7M4x309jmaFntAWXxXoGL4HNyUqTFgOXgTGDMebobbZCv17RvP
         xrmRReUW9svRJhG06uyQxqt20DNcgHvPq1igdBCSs89/q9RLyixrVfomSCw3pLhSKZPd
         uC0w==
X-Forwarded-Encrypted: i=1; AKwUvBwU9RsYRBiGtopRzDKjBek2HYsEKoGTFOsFVzlygtdSLJvW3MmWyAWvexdVuTKf5yETi2V22LPqmgV9Tg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLmurkXcp8MWKRe5rZxAZn2F9kxuOO5imNkqd7+mpRHgTZnTAlA
	lLAxRWgqgml72UKmi0qT+RMSGY4aVuwn+KutT3270Nw35NUoNofdgko=
X-Gm-Gg: AYBFou2IxrAL1GUY79v/14RA+UtfNiJT3yLGkEcCLjjfDKZgUJSsgPeJp2cnn5HgLoC
	kECpp9LGkc7hvgpDuDFt1oap8ncYXghfF9P8sMTTxZnIuOfC7Xt988o4YP/c5vpfM7elmsU57nJ
	4OLiUxQdWxgDGhtFTbT96uNLjoOkyxsBIZzvsIH3sMXYtkVWa4eL4k4qoGrp4PJaCglN3KofOeV
	CB6deqslOJWEQMFPHX2r3raOgMehtIKAyOkBfp+JB74gFnYRTYpGFchoi5JfYfA2FAk2c1YqKgL
	+qKqemUL3veiGLep/TmB8JbSYK5I2WmliCgKsROkeFCLofFmE4kJPjuz/ck9UK5zcv74MA6qsUa
	HjFKGusnTDbsi25TFqjXLQfYGl1Iq8voj4n1wL5kxuJnfxGrCxncaejsHFbMdo25nffx8XcMrTw
	O4z1L7XcCUjtymL0IvsHhB9xWIsAqtlpvJuyIKJ3piVzrUnezslVr7QOaYJamfcUawJk5/6qhaC
	745wV9zrOTY9U4hFru6Zr5wWC9maslwqEazIWEChtSlbIff8C1t+RzuqmXpQt1lXoqZbs3Gti1r
	ftnen7nk6HF8c7yyyM4=
X-Received: by 2002:a05:6000:29d7:b0:48e:e2a:4093 with SMTP id ffacd0b85a97d-48e5d5c277cmr9225789f8f.19.1793283040946;
        Thu, 29 Oct 2026 07:10:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm35906848f8f.18.2026.10.29.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:10:39 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: validate ACPI buffer length before memcpy
Date: Thu, 29 Oct 2026 14:10:35 +0000
Message-ID: <20261029141037.2655603-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029141037.2655603-1-tristmd@gmail.com>
References: <20261029141037.2655603-1-tristmd@gmail.com>
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

thc_acpi_get_property() copies firmware-returned ACPI buffers into
caller-provided structures without verifying the buffer length.
Malformed or short ACPI tables could cause an out-of-bounds read from
the firmware buffer, and oversized responses could overflow the
destination struct.

Add a buf_size parameter and reject responses larger than the
destination buffer. Accept shorter responses to handle firmware that
returns buffers without struct tail padding (e.g. 1 byte for a 4-byte
SPI opcode field). Zero-initialize caller stack structures so fields
beyond the firmware response length are deterministic.

Fixes: 7cb06f08ef13 ("HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI ACPI interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 .../intel-quickspi/pci-quickspi.c             | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad676fde211b6..deca020a46497 100644
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

