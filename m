Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4154C1502
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359505; cv=none; b=Z9c/RI3AmfnILQ3uzgQWJIUL68DpMvlIVIvS+Pf0FQ0JMM5RqR8m99jPvHUJX3CAaMwhMjZmzv+s9xShsy4TE6VYmWyMq4SIe9lzABak0T/BOzeun7nu6SnY+X2cemOl0z6Wb1ZlP89bG9svFPaYrtwxxxrWhAyfaRBnZjDZDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359505; c=relaxed/simple;
	bh=aUzjK8ol795HHRbJphJgtTRR/M0uYgvtIthrbMPir8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APwzuzGGy37hSe6mDDdBK4LQBWBkSpALjfCBe6Phi7VBOwO06u1SJKrlaixw+2mFXciiiNWFsKG6enHt790Zr9xOZ4qzI5new8BhsomAWB2UyeYidEjkKf+5QhMvix4jsDODbvdwopa91NXUWIv8re7CwuzlQHZSYZFQGYsZy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJQ2Wn7m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJQ2Wn7m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so10578315e9.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359502; x=1792964302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=mJQ2Wn7m7bxUaBJu6GJ3NQiYjnIfxuxiiD0/SrTZVF8xffy5pvsEJmjNnMirj1jdLH
         qsMaiTtx4uGOlRtK22gtS4Rb8Q8L61m9aHfG856rf45PXmf14NDChgAlA26FZBTo5nLp
         Uo7l0pF3wHjE4MuwbfdDKhtEHbu9rh0KYmgbT7zyd8CgBjkwzOE65h0HF/A67lNYY3i2
         5z5Bc6OFDab3oGnEpgcZU4829bQxU8Iy9RMY/4KWR2cLgxrWO5gYpo7OCbW3gZUvQKzh
         6L8YUgqEVUKou60Vr7a5urf5er8lhUStOxZXoPgzT/tAFvSD/NduZqD9VZ3woolpuqM7
         5MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359502; x=1792964302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=1dj4cBsxKUBo+6ZDbjJjSCdnB29hj+yWd0BcWL01SKBx3/khUbvnES3EMre7CQ6Gqo
         CkiK24WmF69eU+np6q/spw8bL4eY0XOfCJ3PGG+m8yJ2rDhJ0VU1/5Ul1/sX9WTlaIEa
         RTfD+PrkedIWAK8veBC32pem632PFpVizTk4myzt1bWgKg6ae/evieOn/m/IBXWgAdxU
         Dwb9CrdUzpU4CeTmdRk9kzTsew6RZl6kyVkNqgJuwdhA+vGXOMwsBHuaiGynSK+9H+uV
         R0h5aFTabAIeoy5oeMvh+WM+dnOCwzhjnjZDRTnUV9iRz8slrHgQzvMBxtnDAvPQpGEj
         pNJA==
X-Gm-Message-State: AFq9FYL7vHAqGINKP6+BC86lu60qASQsqxAhI3oHJbx5nwDD6cnAgEGl
	FHvAZCRDWsfC+AsO4XAMMLHe0XOYrxOQO2245OmUqpYlRLAcU2kzRls=
X-Gm-Gg: AYBFou23cjELOuvn7KEMk9p+Gk/12CzEQUd7T+3CsX2IXkTB+gOWW4wdo4nL8uXujje
	3BDOJqsNQahoCCvHkzAZlVXjPY498p9eVs7JXVSOf3Jzoijyj/n/BaA4k3/AJKokvg19nq+iHeu
	mG/vt0KEqtEUlPw9KXHrBJ71XOS0+tiQZ5AuLpSDPDMuQGdKjslCoHacfIpg1kPleSIshCPLjgG
	QxsJdTa8duA4xgMjy1dlfxnrCttS0KCnTcRK1hxoHmYR1ICORTmFVysUR59AnP1Csn8G/ERcfpM
	R+f2z6MPXQT99nH85BYuaZI+cLR+2pfirs9L/bk9SUeA9cjW7+KBrwIhO0NK0tMlSiEmhNRdepP
	YSK+J+6MxtXnIdU0jd8zJcQB+PCiwCZ6TPdvS9DgXGP7ZR0GZQBxqlrYDgGH6/EVP1EkhTjXG0f
	WA3QjFgRv8fHyafrkU3q/eSc4ZHKiWMRA1uq5XO+o=
X-Received: by 2002:a05:600c:8b22:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a1d760d9fcmr129006215e9.31.1792359502191;
        Sun, 18 Oct 2026 14:38:22 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:20 -0700 (PDT)
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
Subject: [PATCH 6/8] HID: oxp: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 21:37:51 +0000
Message-ID: <20261018213754.1951187-7-tristmd@gmail.com>
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

oxp_hid_raw_event_gen_1() and oxp_hid_raw_event_gen_2() cast the
report data to struct oxp_gen_1_rgb_report (11 bytes) and struct
oxp_gen_2_rgb_report (16 bytes) respectively, and access fields at
various offsets without checking the buffer size. A device sending a
short report could cause out-of-bounds memory access because hid-core
invokes raw_event before it validates the report length in
hid_report_raw_event().

Add size checks before the struct casts.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-oxp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 1e691ebc1199e..af9f60d45bf29 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -318,6 +318,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_1_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_1_rgb_report))
+		return 0;
+
 	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
 		return 0;
 
@@ -391,6 +394,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_2_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_2_rgb_report))
+		return 0;
+
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
-- 
2.47.3

