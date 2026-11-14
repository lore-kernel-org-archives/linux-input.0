Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697737;
	b=v9L3T+E3Zacmp+paX84NFRHWUUQVL9m8MEcCUUkkXlYilkbT9NeQ6do2Gt++Fc74ykgz
	 PC2hxoVkXjLm7wMAClgm4yXi/7i3X+y/CGPtYWARVaDpdDOyUN8ivKMgx1HhkVGY1+Ggx
	 mpn8DNAZAEBFvCL09b6oU6N0nHPl3ncA/3JWTpyHPtjkgPjVWrt2baGbFhnVXleKZpycQ
	 /2f2mhc38BdHL1/lS5DLlHhHfxgKIXdiQutIYUQ9pFjGhQHm1/AFKty0qX+KI62JbLliP
	 xr2u2SkAeOihRUD5nGBzjvL8qbuEYJvOIrs2WRlwHm5xQy6MRDManuiBJK9pjh33MSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
	b=4crC0/tHM5XXN9xfNpEBXc07H+hRWD9TAQR5E6vcp/kPUoFMat+vVEfHnxIThchzPvay
	 pcQ7/H9z3p4CbbyQtec0AnttjJKxcz2MZHTJzF3ks5wxXA0zYRG812HzlPoj4Xr2a+pNU
	 c1Dteig5JQGxz3fhLPurHYo8dxS7HyhwmMDwLgl8FJ20psbrGudw9bSVD7OVNg96p3fNC
	 K145DSb9sFp0vrr5dH0bgRyv48Qc99dfDgMl3rD+S+b4KqsxunNZmGf1af+eHHRTns65d
	 z0HRK1Aaxn9B0rJKUBGXb8GZN7S01N9aVhPD9LpY+DhosQ256hTWF/+Orgsr3mi4oZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxtJ4nYc;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B160A6F79
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE7B160A6F79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxtJ4nYc
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490f38e9688so1471946f8f.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697735; x=1795302535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
        b=mxtJ4nYcD3JlhG7YDutpAQpj7FaeOIgaBQzUDovzeWv4MAbcvmdvn2lQ+aKk7Po3G5
         /BxoS2VZ5fgpggK0Y7jhBNdDAe7Mp3WIhZJBn3jEM7F0CF32A3TZECkAbaqkNN0YQxCa
         y7iEpKP8aZfa4yI6ARG2t+cxi9s1NH9exiq//CyjY7wOzyRf858LQ+O053LkjfNDTJUD
         MRPpI1t/ncVOfmBFHi9jrOnogVHDbEktNrmpigNSQ6vTxNdleitT73gxskCzjzPwcKe5
         8D4EpfcJhzlJ9HdtVyXqWq0cggrGPV+0bR2Vmz0SCDBQKYOJSNMufDQi+HE2JvrZbSK+
         AFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697735; x=1795302535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uxveAn0EG2iJi9Y17MjWE+pFeZafxnDF9/Vb19n9Ewk=;
        b=TScVV7mNYf7wH9gyexolLFt9AzXno0cLjTPN4zGxS+tCEJMeKjuWyixLHMnBYhrkTm
         xq0R0rBl649yJ8nTiVTu0giuqf2v7t4OgV/EZ1D561ThZBeJk42fjrPP180hSlAeyWuo
         vyIvKL5RivvbSxPRcCmPWWTZB1pHVW0iW1hZS+tgCBi6+iTQpG5O2Q0ptlzhK7tJFt/a
         U/YCzWyf0HOR2MCHINpbGfRl0a+rp2p8atf3iTOKbBGCQgApn8Zf1O6KTIhiC/1NAEH4
         7aK/X6aHJiBUe0lzJ+XLpgwV1X/JNivMaRpmuRmO0SMw4+HtK4pNJAqCZJEb2Prwt/R5
         az1w==
X-Forwarded-Encrypted: i=1; AL+hErGLRSqx/erQL17UHuPRPKhUdiwNDrlD2KBHwOJeiHf2fcSRZ3bSNejeoNrkX51dT5/dhr4LF965OGim1Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vtfGVbZ4i43x/0WNJgJhpcTdKmKC1HfpnKB8DcRkVOVaAUOXM
	iGqVy7T6vFZWFTteVfsdUza7fHzFVHgiqnnvRlpbQNqk3Y/mTnyTFtyK
X-Gm-Gg: AYBFou2kBjPGo9lacIk6tvhDeMjNm/Bh16ZvHpU9g8gXhO7v4f4uEUScGKKHFEEUUni
	GiLdgl2n9QFAz4Nt+t13hv6MzkfDibj49EzYxAlD7Si2MUe0ThSVijjf22Dl2uEX6FV9lOIhi+M
	3sZ/tU9QAosNF3e+8HRF5WjVTPbK2yhCtyr2ZWvC7+erLKjkhlwT31BtTml8dnDuxhCaUGySwhc
	5xXOSnKMVHa/rfsBtoSPfJMN5exho9lBwShxIJMROd7yHP1KcnmAqkeOuk/iC57VbBdBCyl+OjV
	bF4UgV5vwE2SeSYtBmU5+vXla1KA6zq72bxurX9CNdAofRuAdz4xP76QD8t1549GpiG6QtRxyI8
	EGbiTVntKq8vf9hVYrYLcIbbdyGflG3JPtsjT4uZGJFJ8rnW+AWUC8CiKw0q+7Z6Tolp/1aquc/
	qbiBlWKE3mQxG3EWi/cdvUOq6EejK9ATUGZ9/59+WqFxuYgMUu3LToTTd7g1wZNSMzMOCAHUo5p
	k9I486o9coaqWJgKO35IH1Pd9lWJ/jAalTrNwBIG4nASc6gBwalyqEbihDmT6XO/vua3ELBA6UT
	zP3X/v94nmnfJvaeIKMmYeBgcTL+qQrUKtf9A7vgwPhA2lKGvQ==
X-Received: by 2002:a5d:6f0e:0:b0:48e:7475:fe7b with SMTP id ffacd0b85a97d-49b01734a32mr21424865f8f.6.1794697735316;
        Sat, 14 Nov 2026 15:08:55 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:54 -0800 (PST)
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
Subject: [PATCH v3 14/16] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Sun, 15 Nov 2026 01:07:58 +0200
Message-ID: <20261114230800.1344401-15-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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
index 391128e4bb35..80b300893658 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -615,7 +615,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

