Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488272;
	b=0YrB6+Fs46BL1W0UkVpNFc2hk6MIC36OfESEI3Rcb77IWX4s12dROkueb3pd2sejEymc
	 W/GNkCTgzY1cY6t7YGHoQ8gqVFzrxTOSGw3N+t7O1+JwjqODdLO6sflsChh6x3/VzcTED
	 rDtu8DyZpJ2wSgVTMQYNFlQJd2z+0xWwZMw/EnAI40Q6CVzy/+0S1asLh+Og8v3bCMsBA
	 WubqTJ6PnZxFtQHl5rq9HTd3Blt1hl9XnQsAhVMRexELcH93f3TmDuDrTpb7yyybUNWmG
	 SR6tWRoBQO6Pxy508GrJcRzqcJr9mupc4OIaPF5hkDugsIXCJsJgrADMUCAAOjgcf6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PlHEmQzeT8LkXqBVeD1sDfjB0dlnEHxvW6gX+ZviY5Y=;
	b=vT6EBOOGKeYu/L3kyEcSR31gYNo2rkP9skbu7qjUIf0I2Wwp17ZbpvN7xGyZfPNEH4O1
	 YQUN3VkGu/Vs5fYAq4xg3j9Ll/fNlgJDvn4Qom5fdlFY+RWYHQojOsW2guS5csvFREfQA
	 jYiRn1aPMVplK1wiDvw43liteQFWRVqbbSq3kwnHf3e7sEgNMHBIxeIyAxA99+9sqozBw
	 urIRf/AGiw+Q0YBuTNXs6bKfUKZkXohbwy2/N9mE5SugaoleIrLk1kYkFPjR3phruXjSi
	 OC/2V2WaiL/jgVfGh15GuJP0Sgfg4ENEhQpOZJA9Y3stIusm1zYGqwiRkpkAZeQyc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fC4b5LLd;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53E60A2614
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E53E60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fC4b5LLd
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so22455405e9.2
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488271; x=1793093071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlHEmQzeT8LkXqBVeD1sDfjB0dlnEHxvW6gX+ZviY5Y=;
        b=fC4b5LLddXhkSUYXXpkZzuy4di6Zcq+3fG56uuKa2Z9DZON0aqcUowoHK1DddrPODg
         nAhKfJabrnFwVFJAvJQqKEVrGEY5G/x4cMlPTmqYX3Ra/XmRRtRm35IwOKgjEth8WjWj
         Qw7oxZ8SsnsIXcOYRAwPinx6KR0W3gYym/BRqgTihMrmRIpf+8Z/CRDfYWFocczIYt9D
         qOnm/V/rmE7zlMhIr1lUl/9n/qaVKwCpUE4q6NvIy0Gla3A/DIb5u3DtGbkr/6bLt9iR
         3MDmIgY5gjwiLvZ88/N+Ecdo2J8YueYmIU5TtKSPANQ5/SsEkpABYcOy1Ykp9idjHnWd
         1TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488271; x=1793093071;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlHEmQzeT8LkXqBVeD1sDfjB0dlnEHxvW6gX+ZviY5Y=;
        b=d7fWPccLx1bzBIEPwIWUEL59pYX5HQLgGqiC0tYLLolH+vqNOXMlHs0IaGGLpql3AK
         mrDv9D2NzbWY3T9Lxte6Snkp9JUEWP6C437fXuk5WSSZ++vGsQGgR+yS+cf+uJ1v2Dyv
         51797FEAXTnK5W6BW3zVqxCXbN/n9n0QZj8ls2eNK6/mXN4IQjdQDW+S8epnLNRrT04h
         6iYlhRjyDGFN/Eyk09BW4JpSy6XhEYD9PpYzHSsP8p2hQjruvH4n7ASEWd5ZsS0nskts
         QeLzbgwxwnK7y1Q9F+s2Pr6dveT6Z07ttgfq+IzIfH4uYn4K+lcz0xhdH8SR6gpWufXz
         OewA==
X-Forwarded-Encrypted: i=1; AKwUvBwwDfa/SGZei2DZcB7JZQgLqyL9zrpsvPyH4btVeeLo+F28eGcdWajopJn98uNUnw7gacb1F8FxmNxPnQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1JNhU5foSv73xN1YPy/mE7GsTUsfQMQIR/XCnA0XgSK01BhtV
	XJ+9xYQ+H2c4NkzywHjHZu0yZ0ABX99Gz0TXRrIQoFo3XIiazPhKIreG
X-Gm-Gg: AYBFou2iKNaS4thjst/jkx9iOfy6bIW7+Z4sG7+aH4tUOdBNzeDWeZhwgOUsVlzks1O
	YRFHVtxm4zSHZktmSr1HmEjeQYPwLcpjbbfZDuBueYszAE+hmWZJSSDkiSkkzet19h9grk/QD3A
	8g8HWXSa96YF1ITzhnvcFWJcDru62QyNUA8nt6VkujZ9tsgQ2p2uMJKg4PJKlZsbNz/tBM+0qYR
	Myqs/wFkJ/ZsWQ+Ujkc9NRen65EjnEwW5ATIzB5INexZdSsbm7Eia+xMZ7AVOHONjve+D1grMdZ
	5FawOFuG/1xbVRMa9QlIJXohcOsMITVHF6X7aNIyFpq1nFR9y1oxmFqU4nPP2w5jPlAZJ3BUAnl
	vrPEtnspQ19S8EhMAwQ+hcj2bIuWhu7IdztuXNHxEj9kEv2AbKySXG0anIsjuq0WzNftdyFAHdZ
	O+3CO40H8HBdQ7egncojTHOkRlacnyMWFgLpe4lyJImxYHDrjN0542k9zyj3CM3joR0ZO3Ct1qi
	3b+wtmZsaXcMRBy3o5kNvTxvroCYJnFrtUatgpF4vhANvkB/gD6HPkh
X-Received: by 2002:a05:600c:8883:b0:4a1:80d8:aed0 with SMTP id 5b1f17b1804b1-4a1d75fe793mr167529335e9.15.1792488270525;
        Tue, 20 Oct 2026 02:24:30 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:f99e:1a52:655b:681])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f6631abfsm40765015e9.1.2026.10.20.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:24:30 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 5/7] HID: asus: Do not send feature reports larger than declared
Date: Tue, 20 Oct 2026 11:24:15 +0200
Message-ID: <20261020092423.36380-6-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The keyboard backlight and Fn-lock commands are sent as 64 byte
feature reports, the size of report 0x5a on the ROG keyboards. The
Zenbook Duo keyboards declare feature report 0x5a with 15 data bytes,
16 with the report ID, and do not answer writes larger than that: the
control transfer times out over USB and fails with -EIO over
Bluetooth, so the backlight cannot be set, while the 16 byte handshake
goes through.

Cap feature report writes at the length the device declares for the
report, when it declares it. hid_report_len() counts the report ID, so
the handshake and the other commands up to that size are sent as they
are.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 739637f1964a..65ce31a5489a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -631,6 +631,19 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
+	struct hid_report *report;
+
+	/*
+	 * Do not send more than the declared size of the report, report ID
+	 * included. Sizes differ between devices: most ROG keyboards declare
+	 * 64 bytes and the XG Mobile 300, while the Zenbook Duo keyboards, like
+	 * the touchpads, declare 16 for report 0x5a, the size of the handshake,
+	 * and do not answer the 64 byte writes sized for the ROG keyboards.
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

