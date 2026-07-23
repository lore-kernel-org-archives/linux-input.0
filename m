Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC1383C85
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832065; cv=none; b=EWJ/8egGhcMuUmX4uO9pKbvKC02L6RIITq/igyFI4cykZE0zvKXdCErhhNOLmdhfFoiIqVpZ240YY3BO8rWgIHnruhBBM3wMhsor0Bc1ZvdiQC7VY3mfWXTaknJu8nqj3ounVYpiwwhL8tOQr6gjUKKkxajDk3e364nw20ZEvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832065; c=relaxed/simple;
	bh=UHH+EmqBu6HmSaNm/CUrvH95f3eI00qVQ3K8p9QgoOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kp3LrajnkR29VkgLucOfmfcMlm7d+IE0JwzRA6Vf0L1UF77KqGNA+zuuejMMSblv1MQsZ9p8BAZHZNcJd6JSt4AGHp4xQKbQutruOltLg8C6uXFRk9cW1P0dQgIx4nR+An5/QZtyh9PoSgwY1wqr7iqJuFZf1uktK6wh07olqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKc+j5KF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKc+j5KF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca88130e09aso753830a12.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832063; x=1785436863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNGo5p5iIgIdJkSj3S0Hy9gFCwit5dqb5k6KZ0sAFvg=;
        b=HKc+j5KFyN3pgnaVcp1NYwhosytfbkLRqXbK0M9Jig3KKM3dokGhr5WQDrjRHsukRC
         mUV3JPWzzumcRAilGHn1YoVju3TB6fw85vtFC4LzcSIO0pqQOSeFUlqCc/dgerJ3R0sD
         zilaDpfe8woemVS6F++VtgMm9COKNSuxB1cmJpAcAfhCFnGAzgdelZPj0oBoY1mGilx9
         0mCkcfF9KOiphVNHFrgY/V1jCwdl6kDMMr1rcRtHItAoQJ++a3N3XEyaC9CPHANwlECn
         aLLoENs2V6XuagcwbKwZfXcfuMzZPrphgwyoMeAUY1ZYnj7OEyjAdhP13PRLVbdh+IZP
         jlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832063; x=1785436863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNGo5p5iIgIdJkSj3S0Hy9gFCwit5dqb5k6KZ0sAFvg=;
        b=fhxdA5ytTWP77qy3FJwh0H0AAlwt75lj0Ivue9j9zfCQZ/ttGuhZ/Ghnnlxs7NPLs4
         zV/8Ml4klxRJibeZmHUELDBxxEbGXyN5h9GRb2kJw8mJetJj6P0qqE+1wvKA1LCmwCPZ
         2bxrVHbS1V/F5pD9geFKMHaqowk0wKntPlBMYxaHem6vJ5WdFAJKdaOSsf9TGkmgLROm
         RShQvLeIlWoWl1oKc49CE50muIThZx9e/4TCUGN4uNbGj5clJOIhIqlQVkPGOSp5F/R/
         jZshS4VlPbDmltsON0EtNpwlWeLAZQLo92kGLtm/exuSV4Z3QKI/BWCmM+w4sTYme969
         TlfQ==
X-Gm-Message-State: AOJu0YyrCA86Lv/+3XI/9XqlrUzx4db8azOI8Voq8j3Hewo8hU9FDbKo
	yL9oxvzw3LvYaK+y9Gd7uDoUGCrOJTwFvwIdzJEwHRnXlPwDdiTRUtWIzkrdep2g
X-Gm-Gg: AR+sD11WBRJg/FZycftqTNMA0RMxpXov87JImRFQRerZgKNbez4NYZTBe+XI4eTxjMf
	YKOLdMdBzU/A2+S7lcss5FiKYD2LtFDJLc/gvqY+zSoJc6qj1zbT2N1SskIBt7RD0+31TYKUrS8
	xyMzAjWYeHLRaa6ZfX9/jMIRGHnNWL5AT36TI9QpbQbjzG94bzfToSD001L/nENrzUlWQ03ciw4
	DgbEZuwF+G1SVTW4Tx8/rt3NwNW89iwMvedOg/L3ng0La4KNPy8qGNsk39Bl38vkxs42D5947kM
	3z30NR6bxcH5+leo6sIIr/dXT5FDaf+8ohm5FlnYzeAIyti/Caw+Hx3318rpXzqdpdF1jw5Vv1B
	UiAqHaAe1iLurdeOAJwF04oBZOqS1flsofiESTkBJ/8JPzOHMk9wNL/SzTiHhknhdF8yTQ/MPA3
	EK/sH56C4Sou3hRqoyb1fFxIHIvQ==
X-Received: by 2002:a05:6a21:9f10:b0:3c3:875d:7053 with SMTP id adf61e73a8af0-3c44afb5895mr4922283637.8.1784832063138;
        Thu, 23 Jul 2026 11:41:03 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.240.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6162csm21737419eec.7.2026.07.23.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:41:02 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH v6] Input: gunze: replace deprecated APIs and fix warning style
Date: Fri, 24 Jul 2026 00:10:52 +0530
Message-ID: <20260723184052.5144-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718190040.10613-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace printk(KERN_WARNING) with dev_warn_ratelimited(), and
simple_strtoul() with sscanf() to parse the coordinate data.
NUL-terminate the receive buffer in gunze_interrupt() so it can
safely be treated as a string.

Enlarge gunze->data by one byte to avoid the NUL terminator
overflowing into the adjacent phys field. Also report BTN_TOUCH
release on a corrupted 'R' packet so touch state can't get stuck
down.

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>
---
Changes in v6:
  - Enlarge gunze->data[] by one byte (GUNZE_MAX_LENGTH + 1) to fix
    an off-by-one overflow: NUL-terminating a full-length packet at
    gunze->data[gunze->idx] wrote one byte past the array into the
    adjacent phys field. (reported by Sashiko AI review)
  - Restore BTN_TOUCH release reporting when sscanf() fails to parse
    coordinates on a release ('R') packet, so touch state cannot get
    stuck down.

Changes in v5:
  - Switch from kstrtoul() to sscanf() as suggested by Dmitry Torokhov.
    sscanf() naturally handles comma-separated coordinate data without
    needing a local buffer copy or manual NUL termination tricks.
  - NUL-terminate receive buffer in gunze_interrupt() before processing.
  - Use dev_warn_ratelimited() to prevent log spam on noisy serial lines.

Changes in v4:
  - Remove early return on kstrtoul() failure to prevent touch state
    getting permanently stuck if a release packet contains noisy data.
    Initialize x and y to 0 as safe fallback values instead.
    (reported by Sashiko AI review)

Changes in v3:
  - Fix comment style: add space after /* and use NUL instead of NULL
  - Add missing Changes section that was absent in v2

Changes in v2:
  - Copy packet data to a local NUL-terminated buffer before calling
    kstrtoul(), so the comma separator does not cause parsing to fail
    on every valid touch event. (reported by Sashiko AI review)
---
 drivers/input/touchscreen/gunze.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 2baeb4f3b941..e2b1e1d970c6 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -34,22 +34,31 @@ struct gunze {
 	struct input_dev *dev;
 	struct serio *serio;
 	int idx;
-	unsigned char data[GUNZE_MAX_LENGTH];
+	unsigned char data[GUNZE_MAX_LENGTH + 1];
 	char phys[32];
 };
 
 static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
+	unsigned int x, y;
 
-	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
-		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
+	if (gunze->data[0] != 'T' && gunze->data[0] != 'R') {
+		dev_warn_ratelimited(&gunze->serio->dev, "bad packet: >%s<\n", gunze->data);
 		return;
 	}
 
-	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
-	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NULL, 10));
+	if (sscanf(gunze->data + 1, "%4u,%4u", &x, &y) != 2) {
+		dev_warn_ratelimited(&gunze->serio->dev, "bad packet: >%s<\n", gunze->data);
+		if (gunze->data[0] == 'R') {
+			input_report_key(dev, BTN_TOUCH, 0);
+			input_sync(dev);
+		}
+		return;
+	}
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, 1024 - y);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
@@ -60,6 +69,7 @@ static irqreturn_t gunze_interrupt(struct serio *serio,
 	struct gunze *gunze = serio_get_drvdata(serio);
 
 	if (data == '\r') {
+		gunze->data[gunze->idx] = '\0';
 		gunze_process_packet(gunze);
 		gunze->idx = 0;
 	} else {
-- 
2.53.0

