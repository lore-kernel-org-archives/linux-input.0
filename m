Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795251449;
	b=yLEhyN2xwsXSwCGN6gqkJ/qNin7kudElvGXb++NS/9FJmBxwKeVMBkhgdMVNwaOaQs7r
	 PtpSi8FlQuk751urtP8vmevpKTpn7KQq8NU9TCCGrCuLNQkuzuZEqQ0Ah7RgxwixHR6TE
	 hcTjFvv7Ki8dhNoLpe/P3KvkzndENICQJj6QWK68U2KCKGwgl74JwmwVaBN+qrVVXBHzk
	 uWX5XRhYQzV6PVW6qs1PM/jIvX6B1/gcMbhGZ2zM+WzbaF3hkXkOWsMSa216tJ4L/S07B
	 AodLlBJb5KTqD9s3ZTbIxZ+pLBoxQgkDQOt+wLr7SaTlZfIthPaNrfJsRVi+nYcS3+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795251449;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=cdthxAkaHO+yeVbZfruiT0cSICDqg/vv+2t7JBROBgQ=;
	b=YCGcbaSgk6K987Q3HV3I2+n/SfmnfQHH52LXGjXaZvX/uuKDQqN7NOos8e++xqe91PJU
	 SMtBvyx6EaWOQ336LY09F41fI5aQ2aW9njY2kFQjkbwF1R+wy+wLXBdqVhemw8iCbFkqy
	 TxHNCFC+6nl2ZguWg9ZvhaT/VBcsWDUnwLUEx+ZywCk9+FtJBmVBnWnwdaDpxyGySvqkV
	 LE7FMIfXU747nO9PsESR/n7DTKq1ff0xAdz3KUvrcYl1j6v/Z/wcm/HkWk1C30QyOeP76
	 BpUnptZhhtL4l9fRBBpE/MLOmglrbWJXRSzU7ek1v/UtIQKZD4ktFWzgUlTltNhVaJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=snpK6Y4c;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2708606A320;
	Sat, 21 Nov 2026 08:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2708606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=snpK6Y4c
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jWmLF1KwYzMls1;
	Sat, 21 Nov 2026 09:57:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795251445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cdthxAkaHO+yeVbZfruiT0cSICDqg/vv+2t7JBROBgQ=;
	b=snpK6Y4ce4KSzi2XWNx06liSe2i73b/+WvcAUrjLJrNHXz3LrNwNdIHVLxT86pqIo701xe
	jOcafIkxQ0/3lmPM/6WeGIUTvILbAovTH/5Eyadt8uqRLM2Sy1qKYD7xcRuwPmdzoK5Wa4
	X9gghqyz7fVD7172pdBLJxcwxI5ZzQZ/yDF3XD5QpWhclS6n9pQfe6ilLjwpL4YpBoGaic
	TifHfqRU876dQThS01eDPI1VT4W6E4NLWQ/1wCdj4KnLrX2SOFao8ZnwSHc2XkvKgMwpu9
	HNRFLWcTQ9fLgt2b09w+5ayu90PsxQqqJXFHbUR9qXjMSfRFTG9niqs6GcYQKA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hid: fix brackets in comments
Date: Sat, 21 Nov 2026 09:56:28 +0100
Message-ID: <20261121085628.1430330-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
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
X-MBO-RS-ID: 7bed8ca2e82a95b5cc5
X-MBO-RS-META: 17hux4qqacjzbmquj8sjd8fb81d6pznj

Remove multiple ')' without opening '(' and add missing '(' in comments.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 .../hid_descriptor/amd_sfh_hid_report_desc.h         | 12 ++++++------
 drivers/hid/wacom_wac.c                              |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index 67ec2d6a417d..6c331c2c63b8 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -81,7 +81,7 @@ static const u8 accel3_report_descriptor[] = {
 0x95, 1,	  /* HID report count(1) */
 0x55, 0,	  /* HID unit exponent(0) */
 0xB1, 0x02,	  /* HID feature (Data_Arr_Abs) */
-0x0A, 0x52, 0x14, /* Sensor data motion accel and mod change sensitivity ABS) */
+0x0A, 0x52, 0x14, /* Sensor data motion accel and mod change sensitivity ABS */
 
 0x15, 0,		/* HID logical Min_8(0) */
 0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
@@ -248,7 +248,7 @@ static const u8 gyro3_report_descriptor[] = {
 0x95, 1,		/* HID report count(1) */
 0x55, 0,		/* HID unit exponent(0) */
 0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
-0x0A, 0x56, 0x14,	/* Angular velocity and mod change sensitivity ABS)*/
+0x0A, 0x56, 0x14,	/* Angular velocity and mod change sensitivity ABS*/
 
 0x15, 0,		/* HID logical Min_8(0) */
 0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
@@ -408,7 +408,7 @@ static const u8 comp3_report_descriptor[] = {
 0x95, 1,		/* HID report count(1) */
 0x55, 0,		/* HID unit exponent(0) */
 0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
-0x0A, 0x71, 0x14,	/* Orientation  and mod change sensitivity ABS)*/
+0x0A, 0x71, 0x14,	/* Orientation  and mod change sensitivity ABS*/
 0x15, 0,		/* HID logical Min_8(0) */
 0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
 0x75, 16,		/* HID report size(16) */
@@ -429,14 +429,14 @@ static const u8 comp3_report_descriptor[] = {
 0x95, 1,		/* HID report count(1) */
 0x55, 0x0F,		/* HID unit exponent(0x0F) */
 0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
-0x0A, 0x84, 0x14,	/* Maganetic flux and change sensitivity ABS) */
+0x0A, 0x84, 0x14,	/* Maganetic flux and change sensitivity ABS */
 0x15, 0,		/* HID logical Min_8(0) */
 0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
 0x75, 16,		/* HID report size(16) */
 0x95, 1,		/* HID report count(1) */
 0x55, 0x0E,		/* HID unit exponent(0x0E) */
 0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
-0x0A, 0x84, 0x24,	/* Maganetic flux and mod change sensitivity Max) */
+0x0A, 0x84, 0x24,	/* Maganetic flux and mod change sensitivity Max */
 0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
 0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
 0x75, 16,		/* HID report size(16) */
@@ -581,7 +581,7 @@ static const u8 als_report_descriptor[] = {
 0x95, 1,		/* HID report count(1) */
 0x55, 0,		/* HID unit exponent(0) */
 0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
-0x0A, 0xD1, 0xE4,	/* Light illuminance and sensitivity REL PCT) */
+0x0A, 0xD1, 0xE4,	/* Light illuminance and sensitivity REL PCT */
 0x15, 0,		/* HID logical Min_8(0) */
 0x26, 0x10, 0x27,	/* HID logical Max_16(0x10,0x27) */
 0x75, 16,		/* HID report size(16) */
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..b7aa6b60fb02 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -546,7 +546,7 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 		 * physically implemented as a touchstrip. Each button
 		 * is approximately 3 bits wide with a 2 bit spacing.
 		 * The raw touchstrip bits are stored at:
-		 *    ((data[3] & 0x1f) << 8) | data[4])
+		 *    (((data[3] & 0x1f) << 8) | data[4])
 		 */
 		nkeys = 3;
 		keys = ((data[3] & 0x1C) ? 1<<2 : 0) |
-- 
2.54.0

