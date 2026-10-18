Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6444E0B7A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361032; cv=none; b=IGPEL3rTOJ4eh9O4J4xRWMWuUe/OS4Lr54in/nepcpX7N/a9k1HqI7qKJ/L/hfxaI9F/dPdAEmMCN7vxp22aCMF4X/yyTVCDsLuj6gqI6uZ22MCaV6OPadsiL+Pg3ADDZKFdHFMHIOo267WWIPq92w85n8K4xMZR0CinnKEqVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361032; c=relaxed/simple;
	bh=C5OeVmVc9RUqWQx2xLWOpeX88Xt1ishh/7V1x3S2xhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ji/t2dr2mT1R+H2jt7qpIqO2XVkiVythMlqrKbb26c2EKBIxTTFNjcNXFYLRnxPm20wIDxMuCdTMc8R7iMr/bAn8b1qJbejUxJdj0/D55zEEbjY7qb/JS7zFMYGr7Ts1+PU60mzMGjqzKEwaDjG5dfvSGqiuoRg08NXkdezOLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jobjO/+G; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jobjO/+G"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso627185f8f.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361030; x=1792965830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=jobjO/+G0IsfkTz7BTmRQy3Mn76CrBUEAMTfRjBe2ar0213cAzo3p406ByaHDbVP+/
         x6IzTssWYk+2fRy1pSQVxK1j9896FNtvVvLGeisODhIPL3ILz2+VXWiAdvMguRGzCGeM
         Bd6F7+uLzO9KYrR/C6LmoLnhrLQHg5yZ8nlGXSGCGNJBU3d75jra430a4V4icrROL1Ns
         Bptr8JJimpjddVkO2jb+fsrHHABsS4YcFWDqcQ14cgQaCItTtbim1sxUH5cpwO/M2+yd
         ZWDZoyDtQdBGiD0SaKGg2MhOSNAONY+aFaIGt/waD/X1OORkKKbANCI+LnoJuDOXDAMh
         fnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361030; x=1792965830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=vpPWT6kT6sFDe2jmtCz0nl44B6e8JACB0F9SgOoNj5cPhM/qQ7ft3l8dsLwX3Ab2SX
         Nq7KfZQbSYEkc1zdU4A8wVDlyNO+TPmRxBOsy2BiCkPH8DSY2HCZGQCKMcy0GjWUIJUG
         4onjlRGCALiYKqLwFsxt6dod1cGH7yDHIOWDPi8emIrp2OQwMp+PZ1p4qiWarqnIw7Vl
         epXa01baCkLCRWH1wZmHIz3/OSB9/aUwofR0rqLmKsuJpGC5G7PNe74XPHpxyDczmRgt
         ZdFp44+sX5xdPre8xvdOeaDQCBVYqWIojRIm7g1Dr3+yvicrKMS1g/rRBMMMSP2zfZnG
         187A==
X-Gm-Message-State: AFq9FYKy3vj/+5c1c2vgWAljVFuEgkzjUheHpcpMRvRRwEy8YzVz3vyg
	vDeS5Glvxj2kAholt64wfLd02QxlJxMvUYj5aVQim4bp+93KeNe2aqw=
X-Gm-Gg: AYBFou3z8U//IJngO3BTNraIZU/UIaqQvNEfe8e76FtKyG4l0P2nBML4jHYA/CpLycG
	TTUV1zgSKPUFqkllWa4cd0ie7HvLilrG3ynZbJnuuZTGHQ2dABSS1xN29tb6/CaHpndQi1RQx4x
	0lAhEhpDeaaInhsHhq6LAhDZr9Lg3pFX9MuwK9lrcrOYB9MaODpXyHkw/BYO0BLRF8BHLcxqHUM
	3SG0raUsG2OAtnYsD0ltfF1oiCPx5CojBG5OFl425AOjNowW5UCcf/PLR310M+30cUMPZ2+3AzI
	OdRVowiTfKzr2J9NykjKg5r2q6PG7NKFZQ9EcdoULIe59mVho3V1YRNERoY3uQQzIi9OquP+3Y8
	vLbHgv+MoRy3cseSufw36ri2tAByJdgllxoj61SjxgRjeRJ9AxnAnoQ5B/S4F79VuZKXZ85NLiz
	cOevgBEl79tdTCWIT9vljykW1hwo78eArJRBBU+eU=
X-Received: by 2002:a05:600c:3b17:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a1d7612c55mr121664535e9.25.1792361029581;
        Sun, 18 Oct 2026 15:03:49 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/8] HID: cougar: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:40 +0000
Message-ID: <20261018220344.1987142-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018220344.1987142-1-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cougar_raw_event() accesses data[COUGAR_FIELD_CODE] (offset 1) and
data[COUGAR_FIELD_ACTION] (offset 2) without checking the report
size. A device sending a short report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check at the start of the function.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f1628..2dc135d0fd123 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -267,6 +267,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!cougar->special_intf || !shared)
 		return 0;
 
+	if (size < 3)
+		return 0;
+
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
-- 
2.47.3

