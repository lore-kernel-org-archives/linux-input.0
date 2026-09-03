Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E033B95EC
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463869; cv=none; b=XPo62d9oq9ME4T+RM5Ct7U1eOMF8fmz+Y01TmR3WS421clL4WepSjkQNzWD9lgUDlxAVeAYCIv2zGj50UvHQrn1tXCo4m4FFOH5EZOIKUrpOHT95Q8fDZpQcELQEZ8cXDBiG/et1eA2jcXjT4CxRVJ5VL/fArS+iCHn80ivgswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463869; c=relaxed/simple;
	bh=sPieW/XMxA1aPDsb/aIFP2+oe40K3qdsLeR6duFXD1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZpCazX6xsqtXhWCSHE6qyP1diwNfHo51eTHVTz4muSCDSuSET8A4ant2J4AXp3BvjGvJaZFXgstILcZCY4sEt7yamfshm2J06LprrDir0NR2cSXkmuuAvHgVU1U91mVN7jwH9Ktct1/N9pjSfaoTxHUfWAERMpjca9vHUszmTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlZI+peR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlZI+peR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d7195706f1so2484755ad.0
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463858; x=1789068658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4u3M0sxZUqmdiAJH52liPLQN2L5yD3cqPXsc6cd89U=;
        b=PlZI+peRfuXk4I5/ySdd0Jw+g7JFFfPEhKcFzDr5LY4fGc/p/nq2yGnc+8Cq9labhE
         iipovlvVinCv2XNCiaP7kmIrPi0+rMXCHQQPXIGdgGifn35yRiAubj5VXqeIgyzri0uJ
         ou/ODXGrTumxV5R94seXyH+VVZ0TqFEfZRd4RZjJjG5folfr/nhDNZxLgfzdwgPx/nt5
         5feV3V2O4QvcqUrtn12SmpRIhq+TywLfoHumCU+YMi9EKT5MnG6RUp/bKuvjXMDDsDnc
         9XO9NjCUcXRDsFgA27emnCzJJBAWXikIIhwnWF+3EshxTGUGyNgNOeVwA1jfsiwNqr96
         /Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463858; x=1789068658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4u3M0sxZUqmdiAJH52liPLQN2L5yD3cqPXsc6cd89U=;
        b=lAfdcgCipgRCjv1xDSvS8mu1fOsBjpURLClML56vroULmKIdwLR/KWGbXWdvJpAgqZ
         QW+KRBjb85Lbx6aMudNSzCwgpOviqYIjzPRcOafOakwXBIXhZOW6lAM+37swbD54H51B
         ojx5pjQ4bJmNaBW5Kx72WqjCCns4/X24vbGNJbpVi8VcdNizE7zIWW3MWnxQMVmK5bix
         WB9GCwzwbDyrN2cXbxz7OXl7OnBR931XnJwXmXOoE9gJJc7Y/xGiGVqwcKpZc8z0k+jg
         PZWSDmFC/N64fNgN/a4xJtq6bHVXJ85asFFTHhIMrFFXikrXrZeRedk2P3fybi0KBb0t
         rbug==
X-Gm-Message-State: AFuF++n0IU+M6KHPoI6ejT3UQQblGWPyxKTE+7nFYkXPVBjs1A+TW48C
	MwAk2CoKR3xQE1w9l2C+ozI0PZHfWbdQP4bd7BVa+Puv86h0NpHuoRDd
X-Gm-Gg: AYBFou3Z8VR3ZqrPk+EUPScPBfwbDh8rAnnpCyxEDSfiHk7jI/jr+iBqnDFmAPxPNlu
	ZCY7NAMtsjjUrWqEXlhO0EmWytt6sFl82nQm4NwQ1idU/JSnN7KCZPj4s/KnAhPCYLmYZBE1thm
	OBJsQ0q07DoqHLG94QzAD3EGQNeaEaXjfp4a80ysSIqtbiJ7Xob0q5cbeibO4p5Mk0pcYtL82zL
	5R0LpYRW8goa6UXzbYgYeJvumCBeYTfXW5LasL/2hqxr9ev0yL/0bmMjxmZoON1FeVRMQwmI53T
	UfPgx/sBvaNSpV4kYuL+UNj5evomUbDpjz20Wl47W111tsmRFUgWN7HxCqP5hZTzeK2c3zQEHhD
	WN4Jom7XPLaj1iXulGhoqhwj01rFirNgBEsH2p29KvHSqGnkXKPtngsStREfUh7LC56owgGH5u3
	e5tOiaZrNcFz/MLeRM+In3E81FWCkiMmZAfrCCJyzs5HsTIDPepw7KnbHTznm4Vnf4oJxp5XS6F
	9yoYi82ta3+LClMrALi79D3+rtD2GqUbto=
X-Received: by 2002:a17:903:3803:b0:2db:117e:cf50 with SMTP id d9443c01a7336-2db125a5895mr20300335ad.4.1788463857912;
        Thu, 03 Sep 2026 12:30:57 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.226.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae53ddsm396985ad.78.2026.09.03.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:30:57 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH 1/2] Input: tca8418_keypad -  Add devm cleanup to disable interrupts on unload
Date: Fri,  4 Sep 2026 03:29:41 +0800
Message-Id: <20260903192942.21906-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tca8418_configure() enables TCA8418 interrupts by writing the CFG
register.  If input_register_device() fails afterwards, probe returns
an error and devres releases the IRQ handler, but the hardware is
left with interrupts still enabled.

Fix it by registering a devm action that clears the CFG register
 when the device is released, disabling
all interrupts on both probe failure and driver unbind.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 36d4a7c38bb1..9f0aace6bd21 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -270,6 +270,20 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
 	return error;
 }
 
+static void tca8418_disable_hw(void *data)
+{
+	struct tca8418_keypad *keypad_data = data;
+	int error;
+
+	error = tca84818_write_byte(keypad_data, REG_CFG, 0);
+	if (error)
+		dev_warn(&keypad_data->client->dev, "unable to disable interrupts: %d\n", error);
+
+	error = tca8418_write_byte(keypad_data, REG_INT_STAT, 0xff);
+	if (error)
+		dev_warn(&keypad_data->client->dev, "unable to clear interrupt status: %d\n", error);
+}
+
 static int tca8418_keypad_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -356,6 +370,10 @@ static int tca8418_keypad_probe(struct i2c_client *client)
 	if (error < 0)
 		return error;
 
+	error = devm_add_action_or_reset(dev, tca8418_diable_hw, keypad_data);
+	if (error)
+		return error;
+
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
-- 
2.34.1

