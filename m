Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33A409635
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164146; cv=none; b=F8L/xLzDSIkPMzGLfG85wmjtrn2dCjk2pRlGaBqVLu8LoapfDDRjQDHFL6qcmSRK6xyPxXT9TluKWYZ6+lSPLgepO/sHdjiSAKTLGTTj4O5e7ql+L938SzdAz+khBg7rG0mIxRQaugHFy43Dqso9LCT7smVA5BUM3Zf0jAw2ED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164146; c=relaxed/simple;
	bh=vBJEGPjGVK66EFTnczfAmbWABUf02YfO7QiU/di1gvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQrnTmF6W2R/7zOwsQ7zdJqcfeGbGFPfm5rdIKF1xaT9piyuelVmUSedB/GV2RSvlMGX2kVYeQg+Jjx+k/NO4ObCM9DD3TKfbFgmp7DAE1+Pi4uoLLm+PFlFU7GWVNQe47OrPyZIYFHGLQqTqt9GtzL4tn4BcsT28lne/uaPqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=ERrBaQ0P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="ERrBaQ0P"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so21214725e9.3
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164141; x=1785768941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IU9r02eIFPpCH6KV6K71Wqw1Krz8J+Di7X9BhuWoI6E=;
        b=ERrBaQ0PxgXVfDHFqbGiS/uUB7+gtIuo9cWyJ8icZ/J1bzburbiiorycMGyE5q4FK8
         bcjegB1ARYbSaGNyUMvalFJBnT5ABM6BP+cZm6ZfpTiT2NWM2gIt7PYL1HZX+brmKxXE
         +KfEfRtNjAqiMpr4qSdVNvC/AGH0ZorSpBFlHTOFn1/RGppRczMJq/f1wE0JTmuLy29g
         dr+VFNNYxnLRDhdL8wytv11BfZcv40aMYUIDr25f1X55UTgcB6wv+c2YVlhFY7oFLjGH
         OA1T656i7f2NYeH2bsFgmVXDlo5YuRSNpiUSn1BSZDE5eggF9HkADc6vle8xh3DeTtT9
         oOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164141; x=1785768941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IU9r02eIFPpCH6KV6K71Wqw1Krz8J+Di7X9BhuWoI6E=;
        b=JKEPOHmmEjr1pGX5y7xNUrpbUZmEqMnN4bsncJ5rs+jwujhii50/YYOAye3yptQtFh
         DWA2PwTtqNsoNz2zh1XzFAdx6yD1T5qEZ6jQ4Xwht8PBlCXte0AyXdQhzLYTPUfgU9yJ
         v8miWbtZDuSo/iov8zxHf9zNKCn0Ps/sMnaixQc1//V1POpMAPck47uh3ev7lUgNdhvW
         XrfPawN77IlP7xwZiRLqkmTUcLx2Mgc8k+P3yWPzuGE3DzpQB+vHF2TvUExlyl2yrxV1
         fMoa5rHakgxN9fAOO0iyT6aiFMABr/HFl63R/T1tengCSwpeSelvnBympKdYvyC62d61
         tvsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1/EKOPN2wmrq+d4k4evLmQyqvpEiy7U3ey/aJ+SIltt6GyYtw97NDQEIl2lenLDW8fT98q8pEOjR8OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXcr7/QbX+HHi5bxGK804cvDf/v6LbT8iT908nuCUeTzbngls
	BEmuMoPPiNoOKhF+chcDJR/5YR3oZOXKSqcHRNY5wTrPf9nGaSO0ibl4ceP+KBqz2hfAclQNiIl
	w3u9blyU=
X-Gm-Gg: AR+sD12hirupTw1jUfLKPB4A9K/TCoe/SiSHqRpL4iRx/xxDl8s0r4r4wbxAzgP13pT
	cBkislrGKZqI/5kw3h1zS4CD/30U1679O5bq5NAwekZlWb2VRue3tFQFfqnEuDVPEpUZn2JGxyb
	ADRac1siWn9nvKWAAE1BlWZPKDxZogaK2tc81b/biNo2vU+oUfiVBt150axHhVNpNFEUb0lWWpd
	Oz/XL8GTPW7elYfY/uixHsJ2qbNxs+Nk+5hGx/YjaR/5U77Dp8YS5Qk0uVmQEdVLrkTSVNIB7ew
	VhlmPV9YPL+p0AX5xTN6Tr7vkjd/RqCmKrwGtiJTvHsg7QAItwluVi9Zng7jt8nrn1tgKdON1Pu
	6C8hLNMqnCWLGXAgzrPRmJVGp/SmFccgFcEmIX12yXcELCoUz5Psoc12r21+PDKxqWN/BFS7Ouo
	yoW8/GKnEjtt52mXULHsU=
X-Received: by 2002:a05:600c:a086:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-496b56e6e44mr118838975e9.8.1785164141449;
        Mon, 27 Jul 2026 07:55:41 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:41 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:32 +0100
Subject: [PATCH v3 7/8] HID: hid-core: sanitize user input in
 'new_id_store'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-7-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=1454;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=vBJEGPjGVK66EFTnczfAmbWABUf02YfO7QiU/di1gvk=;
 b=ZNHswj0bgMnCaFoxvh4qaAQP9P5hW6SdrUDXhHDcbg5ZQuqXqgXYYm0h5fUfdymWmPhdaFTOR
 Po033k4IpbnBMH0QfYMFclD/38nAaGqWg673i0jcZUflmO7iJtj0Lmb
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Only accept 'driver_data' values that match an existing 'id_table'
entry within the driver. This makes the field mandatory if the
'id_table' is defined in the HID module and disallows overriding
pre-defined values within the driver module with arbitrary entries
from the command line.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a2af..8679d4f0c60f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2654,6 +2654,8 @@ static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 		size_t count)
 {
 	struct hid_driver *hdrv = to_hid_driver(drv);
+	const struct hid_device_id *ids = hdrv->id_table;
+
 	struct hid_dynid *dynid;
 	__u32 bus, vendor, product;
 	unsigned long driver_data = 0;
@@ -2664,6 +2666,22 @@ static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 	if (ret < 3)
 		return -EINVAL;
 
+	/* Only accept driver_data values that match an
+	 * existing id_table entry
+	 */
+	if (ids) {
+		ret = -EINVAL;
+		while (ids->bus) {
+			if (driver_data == ids->driver_data) {
+				ret = 0;
+				break;
+			}
+			ids++;
+		}
+		if (ret)	/* No match */
+			return ret;
+	}
+
 	dynid = kzalloc_obj(*dynid);
 	if (!dynid)
 		return -ENOMEM;

-- 
2.43.0

