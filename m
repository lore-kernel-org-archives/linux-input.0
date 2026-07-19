Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175B1C5F1B
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784482638; cv=none; b=URNtrTwIqTdwJfNIUh1geC+T1rTeQTs6uGtZEwrBjkCabm3nsKX3BJ4lt7afWCfYsf1ctABETRA6xhm86N6V9iodsC4RiuQlgN3OCOei8Zhgoh+mu5PhYKGlRlu/ve87PKZOkEJkL2kvCMJF5IApyGqqeEKuvL8ZzU/lks0u4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784482638; c=relaxed/simple;
	bh=9ddGG5qdL09Je5jDFZ2rwqpxs+LqcCukGnjUBxHAq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icGnCoLL4bScEWG+iV+2RNGyKG92C3zdxG4ATJF8cIi6JLkD3K7vC7ClNBa891fgyS8GIdfd5I0+VdjXa/O447I8eAXvqhBRZvYTjAilMNUwoGRAt7PHIxgRXx2CQWN+JcASSUO8GfBhesBBnGCYYD3UjOmJU3j7OhM4UpZ9ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+nZwpGE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+nZwpGE"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so3790040a91.3
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784482637; x=1785087437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LbfhifQ2UpHfOzJznP/gQRGa5Q8mUpYyd2eUg/4+8k=;
        b=W+nZwpGEih8jSBhnmx9wm8xHTZ0cC7DHqve/GIimKKQeBb7Kf2mDtgdpEyv2c257vC
         LAjM4cKwE0fjfhVlFTbS6hwaZjIgAYqkrlQ+axWbJ+kI3rgz20nfELyOfFX7aOFaN5B5
         YJBXqRj/6OGHAcE/xDdcS3L23pWhrvRNX0eQgg3ij7BO+hEqbzByCZYPbUbnQ58WqqmO
         lG+4Rxc7rY/W8/nAtYHcGjVztoEWoJb84cxV/6HWbNZneeWcpj3nTdeqQdK1tudP4Fk7
         hBC5OlMIE19yxpGULUJlajDxPM+aO8Mbu+GWpXw22Z046Xg9LiRNsOBRKkDkX8sSsRjW
         vDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784482637; x=1785087437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LbfhifQ2UpHfOzJznP/gQRGa5Q8mUpYyd2eUg/4+8k=;
        b=F9laYawNkxlce6JbN79sX0GTLMBzObCXv9IuUDWtKevkwShNdQAMbnASxKMaMH4n6V
         wBpkSdm+KzrkjVvfPr0xGs9yAhsyj5MQvLe1XBMMLSkGVMEhhq2w9kFDbpa0A5szyy4l
         7U32qf7bTXPVPAajX1SNk+fDA9TvbJAe+vnELIPk/pbf8PIdAnjHxPkWFy8RTaFB9ZVy
         v20n3gDh5riXhzd0hlCimtrgnCEUYLwh/9xzCPQj9AmwtEn9ObKiepDOCQbBFir26BHM
         dncsiWuqZz66xxsOBXQvGCTFXM01XEqdn/DZpyY28RlcMqLW4m9hQXUrQmLhOUCtO9Gm
         4lHA==
X-Gm-Message-State: AOJu0Yxx9v6JetrpNkBf/LStae3xPHGRgZa/pYxiQDlfgTU8iN3AuNM7
	+/8E0QeAWJhyG2hPa0ChupO0YDjRbcKr4JI0CrLh4B0pTB5yDrVhHt0SjifmORTN
X-Gm-Gg: AfdE7cn1nl8xN654Xgdq2f3alt1sQbKlal/82DFs1enz6si6Ptcv06XQLVXNkPzycB6
	LyXq5Ic5ghrTPzOgc82nhyb6AEvyLc8BtLgK+g95ZcAaTuGoo4M53WXzgKZAtzTbmnCp9l8Mx1e
	cCJqL5717cCqlsRy0dJHYt2+ooW/N6B/00tahIwuHL237JqKWNFQsOLlK7GmwOO6aCjwwc2wNef
	jeLBKcTvXuyUbEaE6Fz4GpZQK47NPwI/sglri8VxNXuv1dVyef98ozp3vtAUKZsZQ3vx8kWuwqU
	SkY8i+bzsd0cE6K7FIbwEF49czMOqYlTxASoLwb3oJ5yAIEI5L7o+ckvrtKcydalFCCy6w9DSGn
	IAUJLU4dw1NaMjBqzVaimR31ML5S81lDo9Y0e5RucSZ7tvlRP5mkD5Vui8wLuLE3XzX5SH6B2XP
	iCGEZcbeMXFTNhqZoIZbAXBnYkOA==
X-Received: by 2002:a17:90b:28d0:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-38e4b3e1334mr11111458a91.4.1784482636660;
        Sun, 19 Jul 2026 10:37:16 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.240.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29e13a8sm23466489c88.4.2026.07.19.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 10:37:16 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH v4] Input: gunze: replace deprecated APIs and fix warning style
Date: Sun, 19 Jul 2026 23:07:00 +0530
Message-ID: <20260719173700.4942-1-bivashraj750@gmail.com>
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

Replace two uses of simple_strtoul() with kstrtoul() as the former
is deprecated. kstrtoul() requires a NUL-terminated string, so copy
the packet data into a local buffer and NUL-terminate the X and Y
fields before parsing. Initialize x and y to 0 so that if parsing
fails the coordinates fall back to 0 rather than reporting garbage,
and BTN_TOUCH is always updated regardless of parse result.

Replace printk(KERN_WARNING) with dev_warn() using the serio device,
which is the correct logging style for driver code and removes the
redundant 'gunze.c:' filename prefix.

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>

Changes in v4:
  - Remove early return on kstrtoul() failure to prevent touch state
    getting permanently stuck if a release packet contains noisy data.
    Initialize x and y to 0 as safe fallback values instead.
  - Add dev_warn() on kstrtoul() parse failure so errors are logged
    but BTN_TOUCH is always updated regardless of parse result.
    (reported by Sashiko AI review)

Changes in v3:
  - Fix comment style: add space after /* and use NUL instead of NULL
  - Add missing Changes section that was absent in v2

Changes in v2:
  - Copy packet data to a local NUL-terminated buffer before calling
    kstrtoul(), so the comma separator does not cause parsing to fail
    on every valid touch event. (reported by Sashiko AI review)
---
 drivers/input/touchscreen/gunze.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 2baeb4f3b941..e787209dc965 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -41,15 +41,26 @@ struct gunze {
 static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
+	char buf[GUNZE_MAX_LENGTH + 1];
+	unsigned long x = 0, y = 0;
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
+		dev_warn(&gunze->serio->dev, "bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
 		return;
 	}
 
-	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
-	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NULL, 10));
+	memcpy(buf, gunze->data, GUNZE_MAX_LENGTH);
+	buf[5] = '\0';		/* NUL-terminate X portion: "1234\0" */
+	buf[GUNZE_MAX_LENGTH] = '\0';	/* NUL-terminate Y portion */
+
+	if (kstrtoul(buf + 1, 10, &x))
+		dev_warn(&gunze->serio->dev, "failed to parse X coordinate\n");
+	if (kstrtoul(buf + 6, 10, &y))
+		dev_warn(&gunze->serio->dev, "failed to parse Y coordinate\n");
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, 1024 - y);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
-- 
2.53.0

