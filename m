Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945936;
	b=AzRwWaHPQgNHnSzZWut3h6lVXjfD1AdDoal5xc5izd7bMuwq8/xxKgSe7ZTI6a99JOms
	 yJH1ic3DeO6nv2UN/KXFq7dqReruRlfxr6FXWfpw5znyNVhvyYHLhsNqcIzsb7qOm+uIV
	 BpjRioU0q3Hx3NHosvv1zMOpOZF9Ew9s94mow+BAt+qrRWLubym5eZSeC3pkhyyDdT82L
	 1MhajrN+HOUpjcBefI698PnnwLglgU4gbbb9ABerd9WCvz3Qd7gbTZff7Dk0MoTRi5sTX
	 Es55Nh1QdMat9PcHhsIIeunf9LaG7EjW5/uMgdo4Mp3HDT2dPmNQTUyaLLGpeNAewBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
	b=nRcpZ06fjrfk9Ty7MzQuGgqnu/5ZVseraKZOjM9xbImcRjVc715JK4drKzQm7vp2y7f6
	 i6T8r1iUVXMMotUU9/wL/Z2sEwQTT1xYUiWFj0J/bkzqBDdMzHma4sRDX6W3zu8JVszmg
	 vPCkJ8em7bP1LDxnskVz9dHJfAArZqMcwCW/U0gtmCcm+QPNHBZbl5KmdfHu7/fb42A5l
	 Jc9f6VUehr5l6etbj5dZjNQAX+dtSf6Ys31QZdf1h+GDJ+9HnnYTLCUTGY7z6x7NIf3+u
	 sEQEd3Ye6PPNSLZO+/Zf/jRD6sVgZOcbjz3DW0e6fbJDr6vmv9hG3SaPLFItdWYzrCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g82d6f8q;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14F606B472
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C14F606B472
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g82d6f8q
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so1505375e9.1
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945935; x=1795550735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
        b=g82d6f8qYdcw1P3PeliLS1T5H9U0IcgDSvbHbmDNXHG0YNHiKA0wzAaPTw9Yh9l0xf
         7Uxfu4V7F5KzrLi/15wIWpNl08nASI9JBMPfRbI6o0edRbvvmS8HvC5AZ/hd05NwBVXH
         oKzj7FSQcG4BTI8GcUvUiqBSRNipAC2I0536YmAMRfZn41nIb6zEP6IHABUl8GqAUma1
         Oo6RA2mFZ025y2RZdQnNSpK6v8ZZVlwGjLDHCFuvCRcRpDT2A8L/6gh+E0/PtHoSSHww
         ND/W24jbWzgH48f0xZsH0RZ2MuiAhjFykGzY0s328KEEiKbIf3AlRRU8vYLDvLGKIzLa
         ELDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945935; x=1795550735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
        b=ZRqt75XdEG3oZLybPefYh2Q+TTydin6bb4t+bCJEhFWS7ZkXKIQOz45mNwif6qa07g
         xsHQt0Z4kv69queMfQfs+/JbFHIZtwPaAylgUpPUXfHRksJYedxhnjghhzIRw4E8cgZj
         QbROKCesoJSl4alcVET7uN/cMIsxeTUJGFneM24ZflqFtKS2/yJMkDEuvh1bAy9Z/XCH
         anW/Bb5j731F5BdyfdmfYORKd0CkNATayLECNcbjjihyeEPcWxTa2Tbxz1dS05rRE1pl
         5PKuWLQCE0ofpU6bHsLM4taf5d4+puM3sL3ZVzTk2VXF0gwD4ecctdffuVXyEkHBinQq
         qo2A==
X-Forwarded-Encrypted: i=1; AL+hErHA2NFaXLSdDYkd9yYcclI5YC4Tp88kzXkT0kFyJxntbUXG5B3yA5a/vUgf5S2LEEPIvK2ufuO+lZqbJg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9Qp3UiVLGPPqUaVG098HbDROsqRWqzuXtyPCVsCx/csNKCjDP
	Uly/OWZPopsG/TsYCJ2qWt05fk2klgLjXJf0YpEcmQHmpTostwFO7aTz
X-Gm-Gg: AZFdTZee36GR/k6x2gB5DGq1diBCYtC9fGjo/mcbmGFNXqezYT1mhJs5j8AkAaw9Jod
	soK/UMGUXuvMS9zWZjmD4KzuqN07bhEn9hsBDOq0Hb/yulMCfmUz2BQnJEGNZEBnEDevjnKuVTd
	o/pmL1Gq8XitjGg2JIXIEEbVvF16UMHAM9TlY0VxLTYJYl5+nG92SREk2yfy+dB0N2yAr3wtpYg
	5znfRNUYdeF7Jg+dH1iFlnNGaNIC+EaiOGgXKtNVi3MDMxLCKZ3i/MEU3OF8NwhvP2TEgCr+Lrn
	M4K629ch3hV//ezjhKYXQmyoRTBNieYOuvLBoh/SPzcvj9TfaJRaVfpLrKQ821ln1oQuiSBK/oc
	uVsd+M2uM9eZtSMGU8hPRdEBpS3y8d6eH2z2kxGna1OlSSVtcPh2o5F4ZmlwH5GWpSILnXLPD5E
	X0zNONBfUsdAYk9D4uNu2KjgDlpFSmNZU960W/ZuBfeRqD8O0moQ7zTOSP4WxilhlRWa8Jpon6O
	AcCMiH/ZbwlgjECXdhlFHaxHykvCnjRY5euT8Y3TsJK/iUKAtiIeuQSUj+KfwfEawwd00lXsQzx
	4EZFOc/9TSfRv6WSDf83YTjQU0PhMYRw6wM=
X-Received: by 2002:a05:6000:24c9:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-4a633a652e2mr1441900f8f.1.1794945934473;
        Tue, 17 Nov 2026 12:05:34 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:34 -0800 (PST)
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
Subject: [PATCH v4 14/16] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Tue, 17 Nov 2026 22:04:20 +0200
Message-ID: <20261117200423.19561-15-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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
index d5250bf5da61..e89f8a2fc06e 100644
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

