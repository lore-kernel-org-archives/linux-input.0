Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B843B4BF
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359512; cv=none; b=IEOfo3sDb5kqwDf0Hp1a1QKaVqvLefYxHkW5K2UWqnpfyaA4mo/wr70p37Witd8wQ2skG+I2/06W+2ZxhI93xzCbcp8J6XJVNQ/GvCKOjIQ4wB54nQoW1JfcQxqWMeDHrujmHSj7pWKFeMKRwTsdgMW7gg96O52TPhx8mw10H6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359512; c=relaxed/simple;
	bh=5wsrlnsyVUyKvnXf+lRWfv6B2944VYbzkpRhaaCTiDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpkJmEe7Cj2k8W9KKm2QNQhVPa4G/9u4DZ6QXHvGe43YgI4M8lIWhhREOK1XSZznDdtw3d/VcFs3Npqub0vjYKnPCa1pcacsjxN68aFLAnxfEjihaqWKfXS9JdRD8VBffkZs+eTXON5VHzXzQykpISDNR96tp9qLNVvL+PwX+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/V23NVw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/V23NVw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b060ec084so898958f8f.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359508; x=1792964308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yTHsJf/ydt+NtEYqMFxolxbcYpfS72oO0ir1gLhxLlA=;
        b=o/V23NVwzo/RnVs4/NT9HEfDPfxE0eMP8eGoolWa7JWlzfjj0LFI386D/gSP1bExTs
         9BL4R+udM9if9eaEyJRFCmu3TObu5xeFm1RuMtL4bfHNUo25fakyMjj8COlNpnWTFjQU
         gwdTzHCZa2b/QRbnM8fZEEJqMIxIjEkn/5QtlJE2iGAjYGAC9u6SPikBc41f6sNQrxr+
         XfWJ1RHFalJRHVQT+/0nRO2oongGNzgwnqg5GoPcs9ys729XqGSzrUgZmwqNE/EOZ+lM
         nrUexKWz46uWu5/6q4Vln2A9cscFhlQieRKV5UbmxkRaJoOI+nPjWSp2daD0LRi3cfoP
         jUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359508; x=1792964308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yTHsJf/ydt+NtEYqMFxolxbcYpfS72oO0ir1gLhxLlA=;
        b=ofnMtYxkLth/6bfjbhdwe5fkXOry80q5JuxZhFeQbGfEIdCaWi5N10W5VoGWkV/sNj
         0y6xgt5Urj1tWUil1IqlEoaHbEG1WWM0W54ETbm9HtvLbNjWuM24D4Hy1r0BbPNWvaOQ
         5YnuFSVy+gSAjlQPBMybQRlpvTQl487d1y8Apc6DYosKuvRZiVh/tetLltF8PNSNOEyg
         Gtqr2uC1ZzDaQw1MYwOEzwsSpo1JtlZZQlIIekPr1uHIH+eJj0MC/OZuDg+lptmyeXsE
         RlUxhFB0+8owHlIGsGD5dnx4Ft8SOqavH/KeVlC+JcO28NtHJTddvxQoAz8t2CsIP4Le
         s6aw==
X-Gm-Message-State: AFq9FYIMpElamJTlHxTAvxYMkZnulwMTZlJufO0fz2R4pB+dEdG6hQnQ
	qM925Wipqhnv+czN+jFs7grdqhCWvdX3H2oKhhLhHDWQpclZrM5GDB4=
X-Gm-Gg: AYBFou3rEkQRKsPq5jv9GO6zJwOVwHyh6pTS8GF/Tn5DN2+zjbnFA9ASGwLbOi5fqW/
	tMMJSxxevaJjI1cb4r0zTsvSAxvWSIT61Wvt6A0tpn75Dyg9xf/eT0vO9sp9U3Y85kLdFGeG1Sk
	qPXlDJXMXZT1UArAjiWT37mvsS0t0UA45joLdeA1EC5E2zcLMfupO+EbLs8QwTrAWgPTyjXjwXP
	nXx0daaUoONe4Jv4XBxG/L2LFfJShib1/70xb/SDrxzDIKuiOPDf5brmveaT5lpXDiL6pAfbVvs
	kifSIi9+Ii6fCQ2j9flIt58G4lY0ubJIQv8gublh9SElHmJhfmMGo2RNnn1C22+mPeaVSU3i3pW
	fS5SeOspd0HX7Cq5ksPAUPaZSFKyEMvXDxs2cGsly5SFphz7qdIKejew1ur4fD48Ay95SAf0sy1
	76hZE7JS9TfPhabHKtZr0lZGnc86V5qk1WQc2We+0=
X-Received: by 2002:a05:6000:605:b0:48e:10a7:438 with SMTP id ffacd0b85a97d-48e10a705abmr5408157f8f.36.1792359508375;
        Sun, 18 Oct 2026 14:38:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:26 -0700 (PDT)
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
Subject: [PATCH 8/8] HID: prodikeys: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:53 +0000
Message-ID: <20261018213754.1951187-9-tristmd@gmail.com>
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

pk_raw_event() accesses data[0] through data[3] without verifying
the report buffer is large enough. Since hid-core invokes raw_event
before validating the report length in hid_report_raw_event(), the
driver must check the buffer size itself.

Add a minimum size check at the start of pk_raw_event() so that
short reports are dropped before any field is accessed.

Fixes: 3a370ca1dcf8c ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-prodikeys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index fba01e4fcab1c..c1419e6703777 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -768,6 +768,9 @@ static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct pcmidi_snd *pm = hid_get_drvdata(hdev);
 	int ret = 0;
 
+	if (size < 4)
+		return 0;
+
 	if (1 == pm->ifnum) {
 		if (report->id == data[0])
 			switch (report->id) {
-- 
2.47.3

