Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4404DEC0A
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560113; cv=none; b=PDwuOoLTGM5D4AmIhcRPcH51lJ7oYNs9WgieNqapHbaGhRtCSSvTRSN+L5Tm4nX/yyO5eBU4tegO/P/Tph9CZEVRUbPA0EBY/BDnvRDLrQwpv6HhZ6qdeka5260nJv5lo64jPdo2epHMzL2aVx2RndcCoO4YJoqaLDraMQwcrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560113; c=relaxed/simple;
	bh=kYmjZGeN0w4y8NG43q98oiGS0mYHmpdaIhezqvgUstE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6HlUlgwvMc9Eyq1PW/0Tu3fNJN0/SdtHYRzhL6WUuLBibmu/apla8sQVY5Y9csk93tdzT5dE5wm4xTcfTAc4vbfmwI4qfsQIA8MILhsWSgyRxHqmz9SydrJ7Jpx4MJOtpRQclORNEz8Mx5cgsUKCn39L6lbp8TlTu+BSW3GDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpT8CQeC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpT8CQeC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a020e65269so32358015e9.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791560108; x=1792164908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwdmhQS8ZFgueY5Ojwggbm3jZbWLTZqDnE8+y1Tkabg=;
        b=LpT8CQeC3meBNpwn2esLeYo6kRylUABA1zO6BxWZmsTNqH0VRjp56MwxrHRcTkBtZQ
         y4ls+rpl+TYPov0RzIQ+wQwY5d3yzrm7LwPwkhizCaGpcD5uOlOx8UhDKnV1jLdFCczI
         qSiFR+JfTUTnJCpmWzOFtRhSUNhg4Jwtr6F9qGuMJsWtQFnmow0hL5D+XavxdpY+UEkI
         qTzswuro8lSHMvgOBxG8sFhV2eLYLx4t6YC1lfQHXmqfhhQ5b4Tgz/UIqh65ivLVartP
         3s8YtKweIrIjNIqfs9xizvVXiC736kumInWI/kjVpPx08xRncH9XTq5dhTzfgsHuwhBY
         YQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791560108; x=1792164908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FwdmhQS8ZFgueY5Ojwggbm3jZbWLTZqDnE8+y1Tkabg=;
        b=ciwCbcC1g0zI9QmXxLEM760KDluFhWPU1VVU1AT1g66THeAMy/b70Y8tFXruplk7HR
         8ITQwPR82BfmmpGj52ykSfhtOybEHPj0a4svF5d0oCNeN8NQjXMNa2BGHDRZWackTs/P
         2IOzSbc4Tx5YhNmmkCrjkH41Olhm9QblAuTIyXUU8Vo9IhrdqjAJlSPJEd0dRfUogrk6
         2QZHDI0mBcZs/5Zskc3yfF0egPqBI/DdlXLl5q0TLAzJ7qFB8y9q5IxM9e4G6px5saZX
         Dm/oM6RbiZjiTfNA270hhVr5isIGZ8O04M5zUqvImyhdbAfILnnag1cTW0UKLqYbyPxp
         IsAg==
X-Gm-Message-State: AFuF++n1b852bVvbvcC9u4K2JTrVC5K+2AeFx57qCYKTHKNCH/dn62Mg
	K+y4bzWqONQdbwDqllDD6BCcSfocGz2XMXvSSfI0wy+wRmT8R8UrgX+j
X-Gm-Gg: AYBFou1o6+M4byqmgzLnre3EYgYKT+HoydWuDpp27xKJS5iNxIJxjg8uMYyfakEtT1S
	BHOkqRrPuod35dxfxKiHEnC4a1jUnf2MZprQPw/aVwA3HnztACv2Ii0y86HoOErTG6932nqQWUF
	YQRz+FWAPrFlDQg5lyyAUnyIhiVxdFrwNOxTaZug9ZKVOeIf8ff6lkZU3pl/yQ6SMFqGxLC5CUm
	jpMmddjBMmxa0++8GA48eG94Px/yeC6DhBfApK07hNTdIzKuoz1No0GaKwx0jYRcLnp5mFASRep
	S8BTQpvZgTFHJtqL87kY511SMhAAraaG/+KL0MhNNWgFskZf7uFu1pQyDx0VoGlHAFyqRj1lBCw
	PzHaJfaH6xHagYCKr06JIrGESyGXrX4N7CswiE/dK8GmgRr0E811VLAUexi2pMw+kpD6ZL+rS4X
	dt/FnNktOW13S/WkD2lKpEWm+3C/jwtBJNRdtkiulaIq2X00z2qNhluOt5efQKgwqVhjacDYCNM
	l5aIO/HIg/rLVMWTvief6bJJtsm4lhRwZQLgkiTJNe4Wn/6HW2sZ0+rtA==
X-Received: by 2002:a05:600c:821a:b0:4a1:7ba9:da34 with SMTP id 5b1f17b1804b1-4a18e3ee7afmr45269765e9.0.1791560107596;
        Fri, 09 Oct 2026 08:35:07 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:8516:411c:ea75:bb84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e30a7sm4598278f8f.12.2026.10.09.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:35:06 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 5/7] HID: asus: Do not send feature reports larger than declared
Date: Fri,  9 Oct 2026 17:34:32 +0200
Message-ID: <20261009153459.124752-6-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009153459.124752-1-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keyboard backlight and Fn-lock commands are sent as 64 byte
feature reports, the size of report 0x5a on the ROG keyboards. The
Zenbook Duo keyboards declare report 0x5a as a 15 byte feature report
and do not answer writes larger than that: the control transfer times
out over USB and fails with -EIO over Bluetooth, so the backlight
cannot be set, while the 16 byte handshake goes through.

Cap feature report writes at the length the device declares for the
report, when it declares it.

Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/hid/hid-asus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d8a931290c9a..9e80a2bb54c3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -618,6 +618,17 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
+	struct hid_report *report;
+
+	/*
+	 * Do not send more than the declared size of the report: the
+	 * Zenbook Duo keyboards declare report 0x5a as 15 bytes long and
+	 * do not answer the 64 byte writes sized for the ROG keyboards.
+	 */
+	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[buf[0]];
+	if (report)
+		buf_size = min_t(size_t, buf_size, hid_report_len(report));
+
 	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
-- 
2.43.0

