Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACB288D0
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664105; cv=none; b=gBqh9QKW+4bbCTgrY5oUS9Kye1ju/39OQqY7YSdY/Bi8XSc5O6yasbRhHzBRiRd8PMaLRFsb3IsB7ioCrKuecox6Ouh6zIX0qbnXm6SgctooMR7au7QzzhmUEPNQDH2W1tB7nOOnsVo8M55o9UYhZdOs+Zyqx0TJuoHUai/EMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664105; c=relaxed/simple;
	bh=shtM5XCTx4SGM85hK2Tv+8aoAAmj6dlcxkHRo0n8yxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTZmvord1U38sLnyibE/8yW1lPD1xhhzVxDrk5ErSa2xz0yMBTZ2GBcjiSL4WUOCTP9bc+T7dafbyV5AsRAnYXG5aQfsNiUiCDR4bhCn83HhtujgxJwaHyW57Eu9Q4Tj/XIZD21O+Cisj452frvTl8d0lVGKLBYdahUjyYUrKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o93rYg4c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o93rYg4c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a5d32e8cso8868465e9.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664102; x=1783268902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1o26rsuYGHIm4JTny2vvEweN2Wwm6Ey6adKNcY+/Ctk=;
        b=o93rYg4cVtjQttUp19UKd9Lcx5rUX1RC5EcI6WV2HIaCpa2NMPSq2+Qczh2cuoqMvD
         TlF+c2eWpzJ2K6Nl3C0X6ge1MvUYlZk/trMlOLpbxd8vkc75X/xynXY5Js+A/xcmjBNz
         QJY5LgSS+H8TtUMuZI4vH3ReP2L9KQ2MmawwSHHMPM+psbXEVPI8MhxYnbE2lFJcniVd
         SwAvaGJ3cocWQiBokGV4WzrsbG2HcXyES8XuosVQS39Yqr80N2VGsywQIyk8ecGrbLZb
         qOf9dgMhz8BoGni5D3KDj2uMNgO5AXF2Yfmb5wR6U/NvcaxLy3SGFbGpCwpXjYr/D2V5
         Td4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664102; x=1783268902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o26rsuYGHIm4JTny2vvEweN2Wwm6Ey6adKNcY+/Ctk=;
        b=OOtVigJtyp475QBiFaEqWAzfd0wCfjaE77Hre2gy6VKbGzpE9KLeFFyxFcXdFt+keL
         GdbI8296wsc2CQtXLiRhJtImuvwRBxdzBXkeGpOiDb+J56Gzkpm+vO3XtZFApEFQ5ShP
         iJKIU5FyJhU/h4CZ+c1MdtpcfZPtublJ19ZvtnJlz2+HHJUkVP04J0NP9sCuVMJUGKwn
         MrcsHEhZY2CZJwQ0l+0ai81M8AC7B7ZMxmGc/wFk+iDTeWyW31+vmSnrA4sKzKJuXp/D
         l7xxa78RL5OGQoo4NNAuFtHyrQuTmc7/0uOK81/y1q+N7ncVNZbhh066VqmAUdar6JxA
         K0yw==
X-Gm-Message-State: AOJu0Yw8F4KgvNv53M4y3Q8rF4zuxK4prKjU64f8Y4f+1Tg8AnonqASq
	/RdxtDt2Xu2QmMMyNuzzb/aA7ygYSTtNt2n6ojBjUJPd+AjeszxbXTXS
X-Gm-Gg: AfdE7cmGIZ+wY21AHjoGRXWVkaweDhHHzt8k1ku4A+qwOHyB7n/2wYP01BsmkerEAhx
	NyxaMYAZSnlWgf1A6DTN0ei2hkc/8R6L5t51o2FWTYiiQR/+4FXNS5lo46jGXpycIN1ax/5X3qy
	M27OuckCropl05QSYWlsEibAXVOZ7jCJotthLSN81U3vlg4hNH2VjE9qenz8t5zkPdqtdY42G59
	+d6hL1Ae2fwWIPyZ3zQnT57rbo8dAf9NSBkcamZmMNJFsj/FIj2P4tNOGFweYNUMnY/fS/sTcfV
	ZC7FkWnqY9uDaW8+Ze4x7fq2YG8pAeg62ftxpScLIFy96oYnlzioGBnKM4lKgnRwJpdEzaKYA6Z
	vXIUYgWc3UhxCHZMH02EmLFdYW82fS0cjOKjB1foY8ctsrzFRWGC2d4x/0/NED9uhK5qsEKdVXq
	4hYr1Aofsk6WSPNBxgFZBx8GMNDQ==
X-Received: by 2002:a05:600c:a49:b0:492:5bb6:6d4b with SMTP id 5b1f17b1804b1-4926689abd5mr204625455e9.34.1782664102439;
        Sun, 28 Jun 2026 09:28:22 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c278ab2sm140353845e9.1.2026.06.28.09.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:28:22 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: pxrc: reject short input reports
Date: Sun, 28 Jun 2026 18:28:06 +0200
Message-ID: <20260628162806.10675-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxrc_raw_event() unconditionally reads and writes data[7], although a
malformed USB device can submit a shorter input report. The raw-event
callback runs before the HID core expands short reports to the size from
the report descriptor, so this accesses beyond the received buffer.

Ignore reports that do not contain all eight controller axes.

Fixes: acc3e34613da ("HID: Add driver for PhoenixRC Flight Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 71fe0c06ddcd..e3755d8b85c2 100644
--- a/drivers/hid/hid-pxrc.c
+++ b/drivers/hid/hid-pxrc.c
@@ -55,6 +55,9 @@ static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct pxrc_priv *priv = hid_get_drvdata(hdev);
 
+	if (size < 8)
+		return 0;
+
 	if (priv->alternate)
 		priv->slider = data[7];
 	else
-- 
2.54.0

