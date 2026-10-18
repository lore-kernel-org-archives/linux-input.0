Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD324DEC38
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359502; cv=none; b=QJ7swSfPEEfMxTwiPu4YdONtwVNS+peHfqx+ZOe1SxJgzjh25DzitKZR1tkaSapmvA5cgMtPhxRGLmCJXPszUbg0VZ5MUVQmVHbyrFwqrljlDSogLHDUXzWauF+gck3rVNl/Av9IBVNV2tWyAt8rg6b+xDbOPOOhPvus0s0/MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359502; c=relaxed/simple;
	bh=TEReWKhHAWlGInl30NA0QerMBstlNh4jb6eCUhA0BqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvpGXOLxVr/71rBTkMOzJD5PiY0HqUEkThtpQ6g/buZKIf+0sSeu/BGnwLOteNXT9ZdkrUfNeyCzyJCTswxzOZv5EOd6sXcorxD2XspYg5wM3SvSibSL0HeFfm2/0TsADpZIBFUg386MPc+yesvrWRucpTGUVJ7YrAd0V5rvImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPodl2sv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPodl2sv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so1012267f8f.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359499; x=1792964299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=rPodl2svA+RFJUrA8ecxSA01BT5m0uOQu1uVrHUNOsHOFmV9LwzSdXAK0ufgwMClJe
         MNjf/zrm66e7HXlh2uVcYGoEoAKQyF0t+JeRMiS/xKLL3R5sz7hg6Blt/H1D5gukL9Md
         gwc/Qx+WrMhBsqlSm9cm31/d5gSD2Hdkpol5alR1QvHJFaZhMMYvLDmA7jOYoWrgBM+H
         aBHxsdEDhIWG0E8XkHWqmWOW7qh9LZrI1gjYW8CHNLihM3zvGD0X9TaVdTBTosKzZeec
         Zu0Glj8moFANMqvwPq/40ebO2xcqA4UTZZA090dWeMq/iqSpiISDMsTkfYvGmG+KYQC5
         FlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359499; x=1792964299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=YyDf/BRG2IiMN1KEitNtLxuC0i5jjZKq4y3oWDbKGZ6KikqJVxoestchrrxBcRKjJv
         zR5bhRr8C3vcJoiXeNis8ZThuhGXokceEANDZNd6L7hQPFp1ZElAtVJRa8ZEoDDDm8du
         5oCQSNvKn/073ZDw94O/Av/H9S2dbt2x4nQZb/yo2IGRokuZaigKCaXIgPvfxUnz6DQ6
         s22EYJYTsuP4VOTeMGksCPoXY1k2Hf+jtH4ORXsKUYzrjftpR8uJH9d6ZJUDpNOVxT7G
         MOd4Z47b84F8GoI0dhkoN/S3lhvGKXeujJr9zzpvfuGYeXA4ZwkXHek+xKiuCe/Lgbkw
         CXfw==
X-Gm-Message-State: AFq9FYIEJehoRx6oKeHjWvxQTbR8eTB4KnjV7vk5RfJKS6Cf6X2jIPZD
	68ti9OXCpJJEA3ioiRUpGQSV24ihb3jiFEZcjnhYHOqLCSMK3BtQ9r0=
X-Gm-Gg: AYBFou032HjD2f5fPn+hGOjv8G6eSJ7K0gzhwFR4SJKWgdyiVn6OrkWKhQ7OxtCI2aD
	waBeuNG2qQNq8E6NXFVWhlpi3L5FCx3g40k+nDIx2QfN6psphhb71YTGa2R8ZCVuclEQEDPjGb4
	pbq6CvNYNeU6rmlSaB/07CnqZb1+57PiPUa/ezzhU98UXTyJBiI/4lYmbZsjNUHfCJatlSOh/fi
	ao7O47Da+dvdbDXVKz+sMzGmyfFPhEcuhjdb0sPCvUL3VJmMPYtlSmANsin+eJwd0ewEE4GLFa/
	xuqavBvddpZ49mQ4PhPGOCtheuBc7Ff8//aF47GR7W6IB4GK2sFR/cfA2Ep0iJG5yRwHqGx4c6/
	BpmNzN3kcPsXMKkQz7pewMFFBFz0IqAjl6124DyJ9JImzNuWqQC9eF+nUEoYUjrpvn/7DpkNVBn
	iOI9TjbC4XC2LRQJ7fkEMLWdJt/+dW2XS4vuZyIBcI
X-Received: by 2002:a05:6000:4021:b0:48e:cd3:b3ec with SMTP id ffacd0b85a97d-48e0cd3b575mr9075304f8f.28.1792359498543;
        Sun, 18 Oct 2026 14:38:18 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:16 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/8] HID: zydacron: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:50 +0000
Message-ID: <20261018213754.1951187-6-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018213754.1951187-1-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

zc_raw_event() accesses data[1] without checking the report size.
A device sending a single-byte report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check before accessing data[1].

Fixes: d0742abaa1c3 ("HID: add omitted hid-zydacron.c file")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-zydacron.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1aae80f848f50..203457398780c 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -116,6 +116,9 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (report->id == data[0] && (hdev->claimed & HID_CLAIMED_INPUT)) {
 
+		if (size < 2)
+			return 0;
+
 		/* break keys */
 		for (index = 0; index < 4; index++) {
 			key = zc->last_key[index];
-- 
2.47.3

