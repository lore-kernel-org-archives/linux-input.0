Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399848;
	b=xmiy/UVGY0mkBRqgyNPtg8ltvJtt9AXWWoBPygw91hQaK3bP+eQsfHydXtVS9Ni1ahb+
	 g8nO9tD10JE5x7oNGh4PVy4hAi4sEuiIS6hqjcQNTG3JbCWcC8NcTY4d81JyjlY9a1CC5
	 HDRxJjm6SpcJSR5DfGrxtBMR/QEsMw0kE6XIoP7INDNDmHETU9dkVeALI8dfuK+fmMNXj
	 ePT1uRZAaPouFaAgD0sthlYLk1ltpVjbF9KgDQ3kQ+wuTrITHdSW9Mc+aU4JyhnWRFbms
	 dr9kVv6MiBvzX6iXJz8GcDA+2TMq/CQ0oorsMGLiql5y0mpzEG9cuVS4lLyhpbX6+SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
	b=RNfQSC1y7PqQFrpNnlo0p3uWm7FN3TpRWLmztOHEd5EMQJ/gMbjz6VVFcExHgYeF5x/Z
	 c885brVbrP4jbHhx4C8KtNtsvoE9qRajlVFuPaoYterRaRQ7YdIGH4LcuCqahqaWichnA
	 hKcbiDkisA667pYDF0Z5+xy72UFsrRE1WrbgT8W6ZhugWfA2ckvmQJOxj5YvibPipgTE9
	 A08mRIGnGyl4I/0FNn/OjTdxRj+Yw9HWIulTKUbwZ9sBiE280M30E4ciJxF71CCdBNOcH
	 zrSZ/p/tGWNlVh6FOLvCcA/UfDWDyGYcDxAcPpuFGZfg1L8GHTKHFNGvtPx4G42C/Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2I9t4hp;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913D60A3808
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6913D60A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2I9t4hp
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a214af2076so9382155e9.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399847; x=1794004647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
        b=M2I9t4hplWMbO8tPuee3YyWYgEo3wyjcr0/4BG4YKzu3NCWdVKYAMmKMUvw6UbDvx8
         BcX4QsuLLNI3QShg+6TAx6QfEBf68vsNfxrxlN8naod6hf6myRsr0HkCry0hYrdWCcus
         L64wCfLUnofWYSxXo2tF9h41gd2jGhtnHCcBjBz2pmOic55Yq+F+E3fJFGdlUWdZDvrt
         NdJEUlNXC79r72UKiAgOBXdnjy7b/kw1mYOjqhjZ7J7DbLKb3GW+cm14TLJfWP5er6Km
         7tPZrlHXLlrek2xUExAq6V6GQVUhH0faZ0GJK/JU8xJwzv0Fg0PINfnJnb6sHm94jy1q
         eZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399847; x=1794004647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=smxd6atDvW+XcNIEKcY809Fe9dqPoq4HuHxsaG6+qd0=;
        b=aSgjdhkApOfOUZQ8J1B2OVDJfdXoGlJfl6bp+Hr6OiRX++NHlNGWO+v0CrWuc0sFGd
         QuaV/0/N7p3rFQx74OYJvl2/CPk6mjME+LDFqF4vQIWFH5PBHxxEbDUfr86S9pyTRiKW
         IkyHy1T1uzZgNCV1Qytz0MnraxqAp4UwjUi36XKpPN71DXidVM/aSAnZ7VOeYOBxvcrb
         Vxbhx0KmrGcQXcWUxTKYBsZF8oyoR0MlIANZ3R3XRsqLvEmMiSXqEE8oCp5CPCcqOZrp
         HzWPypnOdJ3MbycXp8o+bT4jx2/jd1rg90Bm6qfBmf4uRayx+vRntH0NV9jZQn8WPdF1
         xuog==
X-Forwarded-Encrypted: i=1; AKwUvBzzQlO4yNEmQsLrWwNDktH0AdJ3Q5vV+0YdWbueSGWRYM34jFFGFrhvQY5PYW2Apux79VkTCwQVvq4dqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJyqzXPfeqGQj+aKiPASadmA1KKIMjg92ujNDV2pRzPGl9T4g0o
	B4fuOefrhAFw+4blraNx5DWTyY80UJ8hm77BHRDKGSO1VRm5/ivD5b2w
X-Gm-Gg: AYBFou1jM8ijwq78G0HBe69eMwH0lNE3XZrezQVDsA6m+70RVUPy64zyMfAEP9UYUfG
	z8M4DGcFUyDfWKf52z9P2rGPQq9XNhr++MvptFz1BPgYPzHtZsb96SMlOM8rhof2e4XpdyFHnRE
	WVsTy4pkc3dg8gWWgCjPHs6yVrbXrfa5FpR2xY5GvpHH2NpVFDTAMdtHw3jKCCyFTmfNxW0E49e
	2/BWnbYpuh1XXYR9hcZehem+TX/j/NyzyYe8URPnE8/IC+ATyBYtv3XtTCw0QjKREBFbuxI0rgq
	1+ODp+uVHijjykM9suJO3B8bLWx5VilnL5Hheg1osQuf/yTR07Tz3Qz0S10GZ09in7EEplRE8+7
	y3W8UOcJOQg4xqZ6dDkT3TRSJlt6hWI0CmEfsFJ+JeOxP5vuVTwoCVniKnbQqzrzLxJOOGCOjQI
	RVpoJd5MtW7Y/Bd/0OhqiQmYa0PXQ9AAnoL9myGXcsiAvYV5NvRAiZ9E2QBmPB86qyFj62JhbEc
	SHZj4E3RavUB150UFGKzmVYi8sslEhChY4aP5zUj37b+f3D9Z/V9P7or+UI7wjdnfc9D1sT83fP
	dXk1tk24uZc31E3bg9dEagi9PH9w4DtaLrwBQx09zBbeRAg9278=
X-Received: by 2002:a05:600c:8b0a:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4ac17191009mr83697245e9.11.1793399846753;
        Fri, 30 Oct 2026 15:37:26 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:26 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2 14/15] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Sat, 31 Oct 2026 00:36:36 +0200
Message-ID: <20261030223637.86907-15-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs store must return the number of bytes it consumed. kernfs
hands that value straight to write(2). i2c_reset_store() returns
whatever ft260_i2c_reset() returns, which is the length of the
feature report it sent, 2, not 0. The "return count" below it never
runs, so every write to i2c_reset returns 2 whatever its size.

A write of two bytes is right by coincidence, because the report is
two bytes long. A caller that leaves out the newline, as C and Python
code usually does, writes one byte and gets 2 back, which is more
than it asked for:

  echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
  printf 1  > i2c_reset   1 byte, dash reports an I/O error
  echo 1    > i2c_reset   2 bytes, correct by coincidence

Return 0 from ft260_i2c_reset() on success. The value is discarded by
its other callers, ft260_hid_output_report_check_status(),
ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
discard it as well.

Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f7d01d9e07f7..cd1117c170e1 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -551,7 +551,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

