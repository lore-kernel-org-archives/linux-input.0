Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3783CE099
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586558; cv=none; b=sAId/XHJ2oszwm8adgTsOWaAQG7wuLdPz55kCDEkrBCYuY38X9iNr/879Wzos260RfkGnmSN/+1TwQFQJuzUBKlJQxABa2940rwz9csSJCYfSsWRzrJTz00PXby9p2+YAjxR749sHI0ixHkLt7gT/jSTvwu28H5qct9WY8Kuh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586558; c=relaxed/simple;
	bh=JutLwr4+Vn98m35lljKV0Zyxcuyw1Sw6yifdGZWiIbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzYBklEi74QViAc29gCU30Imjh2uA3gZYc+mrHcGlbJ+YRm7k1iXS3BkWs7FSWIBNxlF9KLDpkzm/4WBd3cJHaCQhDrO9Ej4oxYL8SFlgwuJZnToOaQqb4qJhBhDOPL6wn0LfL147He3RuHpShZTbCGO3GzaFnNiQD6tFHyMhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlRq4ZgE; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlRq4ZgE"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13988680a69so397104c88.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586556; x=1782191356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zv2aUNeCgi+uVAKLbLPI5SIc49XjDk1XQz2pXnhGtpc=;
        b=nlRq4ZgEwDRKNvaTBsEq55NsIQ8Cx2+oOyKx6ajk6vb/8nhfoFT3dGRxrP6YHKJ+ai
         g0oHHrDMCCc56DB7QMd6BGs6nbfQOWdXi8ppxME5grZq598IUTT1USSwEvWRm1WtoktE
         kPwCM3frIJ2BWlpZDh0vTyXhSkQpOZ+ObWQCjcaKbhrozOtdYsIQ1mMH3matnQXUBuMK
         LCOtQ9TTnDVHPdbP5KLJIqEm0BN5ZKMnwTjZMsja+/PFlkoQcwh5oUk1EsEqbM0nDl8V
         LtQ9Bee1CFU7ddNRltSuhjKl/TYAZEGvkeBWOdYicwDvkVcmgWk4nq8FT9+098apQ9tb
         +FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586556; x=1782191356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv2aUNeCgi+uVAKLbLPI5SIc49XjDk1XQz2pXnhGtpc=;
        b=lntuZF0pUSkgi0JZkUcZqeMlB0T6544gVsFJxHrUKbNJ+/sKVuZPJTPLAmKyMvxjFL
         rejz3TICo/E108kSDpb7MxOWyYWeAS/zk+gQNmJH7hf6ZCxp6Y2JTZr6lrwbb70HNViU
         mNja8/BzJO5RD9QElL+l/xW0T/Q6KMCusXJfhPa8ls6TRhjasuZsiXK2ZcSCK48Cb1tm
         wZGOZ4uJjXYVd88bixflcq3WaY0FQ80Jl5nLBTh1PEtnWD2fM3kCvu0IEEeinf4Wg3pQ
         YiAY59FfBrqLlf7M85MRopdX2UDp/WCev2NW+KIzuSG7WtKmZqO5ZnEyUQ+7bw1E/hiV
         yybg==
X-Gm-Message-State: AOJu0YxfT/dJiCrqItdbUAg0j7Wc3PHQTnnMreIqaQA4hIYO+hhd5Ezx
	m4cI17EZPGzNGTxtqnqLvLefmK3YapDPr0HBoI6idQOFZ/e7Ufuf5Krbx/fl/A==
X-Gm-Gg: Acq92OFl/n+GC0oTVSKKhhif0puemrvLng/Pd8wrgYAC9fcUhmW0bwS1WitHnetjW9l
	jqlZKLz4jmHRH54hw9v+9fpjXBd+Mf36JAGT1vLR/oRYij5SYN8vHclkQ8sJUkBSuruu2OjM/l7
	ByVqK0X5BoZqnp1QKl8h/tu7TNxqqkqrePj9UpUIHpso6zP4UfAUrGTEmR0FPmEVPwnEZRpzCvj
	Vx/RXtbH1Dhzh3GNs6VC57ophQhz/1rgX0dE+PRlY0Gxu/NEq9iLdbMekEcKK0iXAEP7yx4wOXx
	fdtZu/dQ73/j6emIGJPaZnCRboDRdmcl7Pjliw4dbbhxP7/Y/gT7eid3oBlavy49SEUApUF+9zO
	BYbA9OTHgFY2A1wVTnkDP2rf/4425jtqq9j7m8PeNOrgdE9xOEm/mswbCBDL3r3CcASlj019FS3
	/PUX1XFfgL+abti+j+Jylwnrhzsx1AgyoTU4XjFkTERfG2yJVAgfT1yLipns9FQ+nNzMmDF54VY
	6Ygr2PDEHzqt04=
X-Received: by 2002:a05:7300:220b:b0:304:8364:e95f with SMTP id 5a478bee46e88-309402621b9mr8390550eec.27.1781586556381;
        Mon, 15 Jun 2026 22:09:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm17266615eec.25.2026.06.15.22.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:09:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH 1/6] Input: mms114 - fix touch indexing for MMS134S and MMS136
Date: Mon, 15 Jun 2026 22:09:06 -0700
Message-ID: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMS134S and MMS136 touch controllers have an event size of 6 bytes
rather than 8 bytes. When __mms114_read_reg() reads the touch data
packet from the device into the touch buffer, the events are packed
tightly at 6-byte intervals. However, the driver iterates through the
events using standard C array indexing (touch[index]), where each
element is sizeof(struct mms114_touch) (8 bytes) apart. As a result, any
touch events beyond the first one are read from incorrect offsets and
parsed improperly.

Fix this by explicitly calculating the byte offset for each touch event
based on the device's specific event size.

Fixes: ab108678195f ("Input: mms114 - support MMS134S")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 4d748a13408d..53ad35d61d47 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -217,7 +217,9 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	struct mms114_data *data = dev_id;
 	struct i2c_client *client = data->client;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
+	struct mms114_touch *t;
 	int packet_size;
+	int event_size;
 	int touch_size;
 	int index;
 	int error;
@@ -234,9 +236,11 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
-		touch_size = packet_size / MMS136_EVENT_SIZE;
+		event_size = MMS136_EVENT_SIZE;
 	else
-		touch_size = packet_size / MMS114_EVENT_SIZE;
+		event_size = MMS114_EVENT_SIZE;
+
+	touch_size = packet_size / event_size;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
 			(u8 *)touch);
@@ -244,18 +248,20 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 		goto out;
 
 	for (index = 0; index < touch_size; index++) {
-		switch (touch[index].type) {
+		t = (struct mms114_touch *)((u8 *)touch + index * event_size);
+
+		switch (t->type) {
 		case MMS114_TYPE_TOUCHSCREEN:
-			mms114_process_mt(data, touch + index);
+			mms114_process_mt(data, t);
 			break;
 
 		case MMS114_TYPE_TOUCHKEY:
-			mms114_process_touchkey(data, touch + index);
+			mms114_process_touchkey(data, t);
 			break;
 
 		default:
 			dev_err(&client->dev, "Wrong touch type (%d)\n",
-				touch[index].type);
+				t->type);
 			break;
 		}
 	}
-- 
2.54.0.1136.gdb2ca164c4-goog

