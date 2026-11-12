Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466203;
	b=H93HQV/dRYNgSNk5Kvhk1kXHpWBUhVzxxSs+hizcvMQlDJUfuKzHN0qJ/V+maYiDGlEs
	 Z59rOQYmXtYp5dyiA8Ek2ETB7otyJxXvrX7tnQ0wl58JM0Z61fQf3b49aKt9E0PPZeIz+
	 XTO2wBX3qQt6iO65Fdx+7bSroCEDfpm1xX9HbWIqus6jXTv+wa/D5UWEQmnrKt2289h/w
	 cG/FfhqWc3F/YPz7jrG/OKkbjcnFFPFfCxXGfl8OXUVvOtRLhsP/aje9aUsy+bhaCRE8h
	 DP2HHdU8Gc9j20BhsrE5Xy9a/oV7wemH3wz7EE7mds8EIBFsTI/fPdNu2TkLOyV2JsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h1v3GwTQW47LQ5TJOhvyv2Mw5v+tziCrMDZBrKab9Q0=;
	b=2rx3fls5mtbyDB5bjoApr6AcW8P4YEfVVi+FHpox69mzvQeeaSpd1RyQyxVZPuAvKOz6
	 PRQlGxaXHHd3y1ndCRAED1cKOlrNHMKYMjA7mQONxDh0t9r6/ungg1ijeVsJ8cuan9Gzc
	 99n//nOQf/F6RaqGCmtTfTqzfxkFEValManGvYdXxwnV3SHZo38Dz9i5TA8OI7rx1ak2z
	 IgZHtwSVvzjH7kVb4Vsx87lpliOWAoccD+jZDZ30KXH/BUngpqJjcj5DIg/DCbjyjCUIB
	 4HF3TIXc227gU+PY0p6qu/Q5Kop772iCgX2nXEE/6NC7a5QvjhEUKr/ec7W8hHxRzuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4DC2Jg1;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE3606A8A5
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CE3606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4DC2Jg1
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f8cdd30beso7306004eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466203; x=1795071003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1v3GwTQW47LQ5TJOhvyv2Mw5v+tziCrMDZBrKab9Q0=;
        b=e4DC2Jg1DGduI4t0xDJwc64Byyii//Fx6ciVlfdglJcqMUA841Oj3nOl8HyZASERwt
         DNTMeTpKk4g5v82wQZt3M0dIqMs9ty+rKOK7nyIcIz8hFLyNOSx69MjkeXBemrllxKp1
         A7hqhgRP/mpIvT4XjdeUSIaC1rwzdCbPfYndsWGPfLJiw83XBK7EFoc1g9+kKPL4+u1f
         +E9dVlWhQOqQMHnpc+71MUmQo7zMI5tX25K/yx07SB5NfVShc6A+a8GjshuM66RooyKH
         sVo6sxPhebfNQ/Q1HeWO1i9JUHAF3jP2oAe7eJpJvxlKAISt+yk8Xw3bY5cd3ipgZpdT
         LUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466203; x=1795071003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1v3GwTQW47LQ5TJOhvyv2Mw5v+tziCrMDZBrKab9Q0=;
        b=ptrxMXYWoqd578O2Zy8GQB9pjLYYnCddb0ap14I4M8RUNU3kd9HE5OIaqzMKWVqIq3
         24HwQoUmVme0iJHG4dzKN6b0r42rEfLzjCoGMgmcmcpr6G/3fw/Irbymceajg3hmTDxJ
         1IgGbEzBysA4ZzsvPf1yFEU4CC90BLY+Uz35Dcr76Ke7FH4XTvx1QeAHKK126Rbwi5vR
         IkBZ0QPbu6NZj2tI6ZiiHJ5uByiNzFmuERz12YmaQMPANnszj6ILfbRPX/jxZIVaNUv1
         0+C0Ej1V1ABxgiIeYWTEVN9B5ZMDlsOmMolz7+p3YdQDNJL425H+8lYKqROtKB9Y1xRl
         XgBw==
X-Forwarded-Encrypted: i=1; AL+hErGeh8d7LOdtUzKfCDNyTXJ9wlxa0XY/RfpWRWOq8hxODilsK+p6MKdvqWPK6ou+YLauu8gvRqHXlIapJA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8e107puDLmH+xNkhuOslx8SPZHG1BAIoLmksHwYoX9VmrXBPsE
	lmIj3NwQKeaT/9O7Rsma0RC5niPfjysU7vgQN3IshkXj9SmqXHEIwPBV
X-Gm-Gg: AYBFou2/WFBYvXbnxFrt6gcVEGgDNxwsii7RmYvNp6M9ZNtmdr5/gTPuE/hj/NDbJ8G
	cxPOCq3+NI+7qk4u25rjDvR4pKAW0ncrz7XEuuihYQJNDfZY3e094/cCAqpcAVwpxk/Ai2ExgWL
	od/w0gQjk2fgzkbNrLJB4XeZepHn8rU6jVBg0K0P+OTNMWSTlJcTWD7zX2JgpQikStI/VnJ2ZRO
	kTikG4O/lYHLhQDmrlhr4iq7PlTLK6U5THusz5fR+kOKGjPViaEd0wbxlkEsn8b10pyNcI/7n7Q
	x2l/T2D/UvoRbsMOxwl0eh35mDAFlBsJEkJUbgERppcWuDMzWnnjg0y5gjBILaO2KUQRKYdz+4Y
	CdQiKhdImmRZWcjE4sqj/O03hiHxBlr63VQR8MoYsZxv2cQvz3ypw793/Dm0k25ELsRcez7mbyY
	dnXATHmVFsPVPheKdy/KOIrj/kzwGpjoCQMVTqBuQ+IOg4m6b7+PWIy5tcGpeFunXQlicOKOG5B
	RpxtmN4QXYGAXEV93W8wIhx0NHe+1E+lAaLe4eiTvw4CBt3SUo4xEkRsuBxZY2g7DCUOkdzWa4I
	1/Y8w4rNnUM4c3/CYOI9cvuLeGpFrarlMGjh+b3zPMv8XP8cmYfZyOe2YSgaeEoaV/SGwczB+s/
	+/o5Dxgw1gDuctmbW
X-Received: by 2002:a05:693c:8852:b0:371:ede8:3e9b with SMTP id 5a478bee46e88-3768721116amr4902164eec.36.1794466202380;
        Wed, 11 Nov 2026 22:50:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:01 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Input: ads7846 - drop platform data support and cleanups
Date: Wed, 11 Nov 2026 22:49:52 -0800
Message-ID: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

Now that all in-tree boards using ads7846 have been converted to Device
Tree or software nodes, this series drops legacy platform data support
and its header file, simplifies sample filtering by calling
ads7846_debounce_filter() directly instead of through function pointers,
removes redundant memory barriers, deletes dead code, and cleans up
minor coding style issues.

Thanks.

Dmitry Torokhov (5):
  Input: ads7846 - drop platform data support
  Input: ads7846 - simplify sample filtering
  Input: ads7846 - remove unneeded memory barriers
  Input: ads7846 - remove unused code
  Input: ads7846 - fix minor coding style issues

 arch/arm/mach-pxa/spitz.c           |   1 -
 drivers/input/touchscreen/ads7846.c | 434 +++++++++++-----------------
 include/linux/spi/ads7846.h         |  45 ---
 3 files changed, 171 insertions(+), 309 deletions(-)
 delete mode 100644 include/linux/spi/ads7846.h

-- 
2.56.0.567.gdb80ae8cd5-goog

