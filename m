Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB083EB800
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334630; cv=none; b=KzJ5WpOQSXb0fPVrHV/90mxpQncn06WBaEuFrpWhlKAOYwrA2I+GNB2/FAemhJCVwZceV/5XrNSeAb/xUPlpxieo0FqVkKQ4VnSDgOWmcyhNKcn/E5BUwaf2jN67IHRF8DQOsdjDQYmhz8OPEY8W0uTys2b2bvf5xhXY5nq066U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334630; c=relaxed/simple;
	bh=ujc5RmR13pOdQaqezJhZ/7IcIxTg4usJF9uIGCuu/OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVogHCINoUq+/2f3BmInbQ7fdnt/lops5/VOi8YY4WCHmYf003VB6D4PywINYRZc74COJnmndAxm12SFRZu2l3n+PPq+hctSiw2JkjXxteSxmj7xlS7JbnQKg9avd3S4NjVYA/I1xigc6Cp7AErxRflUkXXUaxeRR3v8vzL4Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4wrkf8/; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4wrkf8/"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso893185e0c.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334618; x=1774939418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wc3JY3RaoRqNFTG0M5AcX3LAUTNd7UfUccIs7JuU8E=;
        b=P4wrkf8/GMPc/sIiJAR43w3csjLzLpssQdVM3uod5glvmhlGv+BVsXmPZ1bmEEO+Nf
         x8Xv70+6Qgji9PQfTrbJC0fEgsaQw+ZuMP6ph/wjw/gGxbuPchhvpJ58c+6M9zSFOkcV
         JoO4Ll1D0QHVaKp5kmsWqDck/TFD2yyqTT1sZzUFDkw024VC0AgvNwP3Jqarje5oJv5I
         GDNR1BgishAz1m+e1XNYrTQWA3lVF8cmWILEHnuN0d7g6WWUzK78GpAZe/j/eAkND0mI
         tnn1YQUmZ9kruIejTECmhl7hojSUkbtooZuoTraJDBclajOrmufmZLupBuk8CMitfCd1
         GVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334618; x=1774939418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wc3JY3RaoRqNFTG0M5AcX3LAUTNd7UfUccIs7JuU8E=;
        b=W4DeG/xhSvlSg8MRS4330UMu9R8qGUlNhk1lneCf09GgyUE7q2s9GVbQQBMpgv9UaK
         uiPhi6b/YD//p5DcyKl1frD95WeDviPJxc+W83UNZ0P9jLf0K42BR9KoK1YMRMQjvpzm
         e+Osh6InurkHX8H6Mt0x/IdAul5jGwOs3nM9VcW8eeU6XV3UhjXK7GfOpIue1gfE9lnT
         tp+xjYRM5e2DJy1l0i55rA5NtpEco0qVSuSVHNfrYhHkpoAJe6EYSIPA/Aov9xAqvcmn
         o5ck7l1dRkllRi2wnpNGiKlZxXcBPlOcvjq0zUqK8azIwDsHZTHIV2aD/Baw1y2LTQib
         D5lA==
X-Gm-Message-State: AOJu0YxLCXzrvgDGHkbr2N6EeZl7rFz2mnds/6JhHtdKrdCq707Yrkfl
	uTB/44RRs5z8WhI+DjkW/eg1ZNY104fc/5pn/elrajbIfijNZ+ZJ2fpfxbc7/m3QvJp6oA==
X-Gm-Gg: ATEYQzx2jgXZrEo3jWMYW0dGjgW2znXkhiZNZB9TefyX24aZtshfWnn8e/m/LaaaMb8
	GuUhoWQsSdZpwsO6IAoh5k3uskWogcYQHtkDheuhC0BEaxfLYxFpBL5LMWN+P7DlyfdkwOxOrlK
	xbDt+axHmj/3MJOj+4cdW7gybYYDFd7Ue2bEfiX3HRxe4dNbK586yEFUREBcULZyi/miI6BhiFb
	w32Y3KQHH9A5W71Zo1gXQD4afXVUzOVIj3cVKBRv9qGRPaP0/oBj8JOKEl4hjq6ooDsu8HEdyQR
	96Z/amZIth6eJ45P7LR852GNFsSZ/HJMAHXFc6fz4q0OlX4on1ShOFsrxOaqxqb2COHYQ88ylic
	AEN2eqMWxls2hZC+qv/JSUf2lQ0xteqRVa+CJi3pYDVIpFheLh8zG8EVsx3JvJbfuohvXLaiCs3
	B7X8GhOeOCSvl17A8p2bgRrjvwFJw=
X-Received: by 2002:a05:6122:e251:b0:56b:982f:1267 with SMTP id 71dfb90a1353d-56cde43cc1cmr7995444e0c.13.1774334617713;
        Mon, 23 Mar 2026 23:43:37 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76e0:1048::11:161])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddb6d041sm14625744e0c.1.2026.03.23.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:43:37 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: cp2112: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 00:43:32 -0600
Message-ID: <20260324064332.346342-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cp2112_raw_event() casts the raw data buffer to a
cp2112_xfer_status_report struct and accesses data at offsets up to
data[3+61] without validating the size parameter. Since
__hid_input_report() invokes the driver's raw_event callback before
hid_report_raw_event() performs its own report-size validation, a
device sending a truncated HID report can cause out-of-bounds heap
reads in the kernel.

Specifically, in the CP2112_DATA_READ_RESPONSE case, data[2] is used
as a length (capped at 61 bytes) for a memcpy from data[3] into
dev->read_data. This data is subsequently accessible from userspace
through the I2C read interface. A malicious USB device could
therefore leak up to 61 bytes of kernel heap memory.

CP2112 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-cp2112.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 803b883ae..b86631163 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1387,6 +1387,10 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct cp2112_device *dev = hid_get_drvdata(hdev);
 	struct cp2112_xfer_status_report *xfer = (void *)data;
 
+	/* CP2112 always sends 64-byte reports */
+	if (size < 64)
+		return 0;
+
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
-- 
2.43.0

