Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E73ED128
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074881; cv=none; b=E/BMs5Ot5vvq0VL8WdJ7fVHJNRUaLSZQxmcp7es8KYQX7UjCu3GECvrnp98yZnD6FwfiCicMbYnZtGFEl3Hwj71g4Z4bU3dqf6z/gqeeIo9s+wJqqeOVzHp80zofVupZxrA+Ld0zoUm7TzCj5CeOHPqHsIHoXU8BXobKZBbC5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074881; c=relaxed/simple;
	bh=MeLprhUAZMvvtaG2SQyYdpCUNDDVZn+Gy7G5TywqqHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAl74GySr4/p7XNWxSo//ut9jvJhhgZupEwfkDrotNfZVAaTZqSV6bOarPIuK8pPjNAkwK7PQ9HXDlvCnAPNpuIYnpv0Bfa/DVnDMkoKbuQ1GTtgF4QmdSgjlPjKDblwDgxe9fRveAe71diBmtma+id2Lu/iDzajqs/+DH6sCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT7/VOLd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT7/VOLd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e60f9af6e6so17691055ad.3
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074880; x=1792679680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DwKCN+cdZZKyFrwaQPyGpZEBhl46V22LLAfT1wOQ0EY=;
        b=RT7/VOLdqOmwHsYpvntbPzjo3dvLOKd5UFsrxmpF3KHg+1/EjLmXaeD+m7sDwKBcgm
         vObubCQzA1iVDSIjIFSei4MPS0fjs0c990YLy5r7Gb30TYDXHmh2dQt9sFoLSRC1l5RW
         pRwOtVi7D24b5hUwatqXLybb9TzVLUYV2FhKn2/5JQGPMPlrTErtYbZt5gbJ01AwevkH
         QoLIkxxYwophsP0fr1xNHHv3iR6WwB1FvfWAv8YS5TxLkt85fs3n2LVSDeM5CNNy/XFj
         2riJwx7Z2ZpD8lZggYCYTnZb0p8/7ytrMRUbXItEINVAfYJghOFFBmJA88kdOG2kBoEh
         vWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074880; x=1792679680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DwKCN+cdZZKyFrwaQPyGpZEBhl46V22LLAfT1wOQ0EY=;
        b=J/UKZaadUVYiZx/rOWdrKuUVG9ZQPop+TkC3Q35HaytHJde0ximcCFBO28Y0lwAB/d
         ihSLRCdjfmKHR7G+AzPFxiR02RMDmW33RPn+yedBjfAnzC3GuTb2MDwBrLnaeyorj3Lh
         kMCduq7QdtyICFarn15d91kJol+PzGoiQ8CqAEy321IhWA0r8yHkeAtgfjDZ/zu8LvI4
         L5xxQSSC/GGFJtwxEDQYEj7qBkv88n82snRGdAMx+jXBSrwc1Wcsdh/WbPM95usUmK0n
         Ph2sXNrehlkBNvTegnapULo0kLa65eIVSJNlTFHq3q2MxsbyEHW4X4NpXA6nD4mXd0x6
         3R8w==
X-Gm-Message-State: AFq9FYJDOaIWs14STfKmaHtRAsb0uoMdcIuwk073CGem4UiLQqIJ1BwM
	OqsYwSFYSiErn3HRVxElhDdMl+pcpvcMbB8Q3Za5NH84bmSRqaiNKyeD
X-Gm-Gg: AYBFou3EbG/CdFXIjiTJoysMOlkIdxxH2SrUFa/MMHaukc9CogUy49px53z4cLpvakR
	Pglu7mXGubFFOczssefCgmnHzdGORDuiMo5NObc/q+swZ0tFZ5dml7P044+ccz1a7S2O2Ri9S9Q
	RX7N8chvreB/Wr481xoyDvdnyPg1qCg2Qv9LezxrFUBmauKXasJ1OEb+KJq+EO2YMhXATYEiQyD
	A1jxXz1ENY8R3TXUPFcA5qmM5mhJKUvmt+jHPuC825NlShF8mv6Yfkzn21v60QAZLl3C8L+qhCE
	eateSexlMcEOn2bFsj5SFfYVRDkvqvE6Wa+ihsUzhkMC+3higgx9jpgaXGHVH5DRrc2YQb7DhDL
	5vrUqikbgjgC+Rz6G7zWyzUFZdd72tgqEEzjOsnv/LjgGoPEP5xSvT93Rqo8irTqaXXHX7toqBo
	vcxiCvmxZV6rcloQ4aijwnD12xmEzjY8D6Oqbq1MSOdgaaeR5cgMDOGL4vppH4DwcCwcFGluMn
X-Received: by 2002:a17:902:ec8d:b0:2e8:3cab:3af1 with SMTP id d9443c01a7336-2e842cfbc69mr174591995ad.23.1792074879630;
        Thu, 15 Oct 2026 07:34:39 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:16c8::245:c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm79933765ad.15.2026.10.15.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:34:38 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harald Brinkmann <hbrinkmann@braincalibration.de>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] HID: saitek: don't dereference a NULL hidinput in saitek_event()
Date: Thu, 15 Oct 2026 21:34:33 +0700
Message-ID: <20261015143433.129525-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_process_event() calls the driver's ->event() for every usage of a
report, including fields that hidinput did not map to any input device,
e.g. a constant input item. For those fields field->hidinput is NULL,
and saitek_event() loads field->hidinput->input unconditionally:

  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  RIP: 0010:saitek_event+0x51/0x2b0 drivers/hid/hid-saitek.c:154
   hid_process_event drivers/hid/hid-core.c:1572
   hid_report_raw_event drivers/hid/hid-core.c:2109
   hid_input_report drivers/hid/hid-core.c:2180
   hid_irq_in drivers/hid/usbhid/hid-core.c

A device that claims to be a Saitek MMO7 and uses such a descriptor
triggers it with a single input report.

Bail out early when the field has no input device, as the other HID
drivers implementing ->event() already do.

Fixes: 37c492c8f6a9 ("HID: quirk for Saitek RAT7 and MMO7 mices' mode button")
Reported-by: syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eba2b3201bd25a97cddf
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/hid/hid-saitek.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 6fe7c087c594..2a9e07a4fc77 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -151,7 +151,12 @@ static int saitek_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct saitek_sc *ssc = hid_get_drvdata(hdev);
-	struct input_dev *input = field->hidinput->input;
+	struct input_dev *input;
+
+	if (!field->hidinput)
+		return 0;
+
+	input = field->hidinput->input;
 
 	if (usage->type == EV_KEY && value &&
 			(((ssc->quirks & SAITEK_RELEASE_MODE_RAT7) &&
-- 
2.43.0

