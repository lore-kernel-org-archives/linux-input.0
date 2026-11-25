Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591334;
	b=bVI5OZZnoeHV08JqYrS292/ycQp9OHZeIZDvHfK8su/9fqYmxuH/qhw2fEEe6ix0PWmS
	 ID5bUUWRrnAXJfh+K77UC+dPWKw02e3gSp2OuVu/6tGOoRspF4mXQzh1CqC1NndXS4Apn
	 RxTqJ4wBWr0igr7QMCSKujyAapOY4lAindNnFCtF7nBmaXK+qaxFCROTrq4t+OhDTIMwn
	 DPresL/6BW4dpe/Sfu/GEOgsb5/cfOH3NFIfylF9DdgiMV/RKfgrQhUML/Cw5iRU/Y9OI
	 wnEO+0YriQCJlYMu6HS+dTEw+dcbhxVkBl2qe8xk624AAdlZuzVS1tMeIbDzXPscZng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=1mqak/oTHzzf33mZlhyESkRVPDIMxG41q7JJp3wZRXc=;
	b=Ndom4rnXaWJHk3OZwk6gJYsu04Yuv56mdYcThDcBPiP2U4cn2T4V3XM3WCcpe4thedWF
	 osyV6RDqrO3AVJe00kQ7XMZ3/DiB/iuy3nN+G+LO+QyE2c2Y0gVnjnF2lIZYEXiz6iLrl
	 WqzWxbVRmss6WcpvfTnsBqBRFysgeNCpnJfPXklwhfhL+9Yd2MXCxklTadqqt4RGpOjDj
	 1KXBpRM+X6AqB3p0ExnF64cRBtfclC7h3FB9w5hWNKNwWAxtn0fBni4t0gvh6ZSvDqSVs
	 Q7VJi4bnGWXIPQ0FAkLbzbSmUSdHinGBxj3PPhCXU9OLZncZHW2VO1j9J7fr8jg4N8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=APGRYVVI;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6E606A32A
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E6E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=APGRYVVI
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso49856085e9.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591331; x=1796196131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mqak/oTHzzf33mZlhyESkRVPDIMxG41q7JJp3wZRXc=;
        b=APGRYVVIm1Ke5XKCEvoemamE7OVMlp1jxFmv+I634jpq4E0mDh/I94JcmX2VnyHJ/7
         /Q+AquHUYDya3NbI57GAAvqSopUHf9zP8ACSRQyVeOb1wV+A+AbQRrwJa/XniOTRhFg6
         zxOFFnKsZkqMbaRk9R0KM0dwwzju+B1ikWgMCbY7kAoh/zk2Y/jEEf+wwohmh1pwoJ3Y
         yYWTxCg/SEAjOc7pyiLJMimkGBdHGaK8EJP9z80AJ1MZr96ujQlYQLrfZLkQckAeVQgB
         gszx40G6B0W8MnZ6otBlYsHIVWzuiOEJecDKRIVHqVZTyBhDtT8rr0JJEMBg7Xi6PPkT
         DAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591331; x=1796196131;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mqak/oTHzzf33mZlhyESkRVPDIMxG41q7JJp3wZRXc=;
        b=APQpr7qTfy0gJeNKsIz4Fg+gm2pUqnOrCYmMtarXWFTkHbdgjwZj4I6n8KzYd+yUsu
         Eb10FQLwIcTj5GieHqZhFCJKGQmkjHxwBjyN/QQ8ggR6wTMRxK8iLEdN2VkQr01ENTLT
         HACGDsgNSEDrf8U7+8WBcwcMFv9J5ngrbJPvdaxo21hhjJh4lHZhNWlViej8YbsNEo5s
         ghy0Ba2m00BEgUiL41pF+gDC7TV8ONFvxiYCxCHyOs9oXXc0Fk8nDI58muhUse5P+s78
         Qs/cdO53j+OyDsLz5iPHmmzc5zqHR0revKhe+I0CAzobBRHrOyPcslKbAtjlLWqdc3K6
         YQ4A==
X-Gm-Message-State: APuU4Z9ul8M8QCPW8AVWNEBUtsLL1anSeZOexdaWAyXBkWYhVXy1DTYI
	YQAS89rdcUVGvNcIEqxRcq+KGki+JRWEcfGbtJLW+qwh1ZBFZ/O5y/6o5DIbLjv+4yo=
X-Gm-Gg: AZFdTZcHOtZW1equtBNGV7fX/7QqMv53dFCr6cGHhYgiKLkyNKRPfGJdN0wAoSc3+mO
	ZbazXaKBd4OR0ajwy3tIR7hko2kTpYrumQirKdDQatwSBFJ+gc6pTouA9nFehJvBYmka3LX/jM4
	V+t/J6478UxWT5ic5qcLzHO9DJDe90MntafI9vDOeJAIIwTgJb/Pc0RqMVw+Axhfaouz6gp3cAc
	Q1idNl97GlBJtnJWYJ5MI6jHmkVqz64tecyjaEJOs06uhqmpkdXx3I53QEArLcQ4mHEl5iK/7Ph
	8itg4K8kIGKJipoAzafZDJx5z0r8bF+V2c7LkUNqV+W3RuxRMo0CeVXoUmDZdyyl6sQrjYS+H5c
	PjZvofBuA0OPuK9uzHB2hXbjn7jn0/BknYzX3K76/3YjCvegN4apj/Gqk+EP5u3A+58UmFRFPeV
	RSBad7ZXcp+ccCjo5mdJdXy4qb3yCyi2o3ZHxyO2BYmfJEHnDkiyZU15la5JruQ16yGlRxHn0Ea
	cucMtd7JoiEDVS9WHwyTnCpZhJFPBSwzn1zBQtN3/7O7fDXv/a0IxJMNVLUcoOaczPtzrETXHOZ
	xIohrpGyxxX1eYKlSvQ0XPYaIMHW8ugijn0qglS64ux+uAC5a5Q0MJE=
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr357770365e9.30.1795591331274;
        Tue, 24 Nov 2026 23:22:11 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884b8429sm780146835e9.14.2026.11.24.23.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:10 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	linux-kernel@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-hwmon@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 0/9] HID: Make driver_data in hid_device_id a union
Date: Wed, 25 Nov 2026 08:21:32 +0100
Message-ID: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WKAFjahqsz1WADW4GQZA2AqcKEs67qPodb0ziWRr2bc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBox8D3OsqGVp8d9eNjV0Xl3jDEO2G2/iqVEi5 ZFnCUOaW1iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMfAAKCRCPgPtYfRL+ ThbLCACxJyH7addcG5QUOzghaAV3UIuswR+tsPVOGz6kUyM+BDF2vXNYHYrOKjIk49Yjd3jnIPm +bVDgcXYYG1/XQnI6911gqpKD0ku/4iEz8G1bgMFiNJY2RaUfcBga4hA4z7SZtoo3tB95V+WB0z qp2+PeD+FsIx9C3VmOh3kTonHyFMJxarbh7N/v4RhbeeGVVuXa0XgMunhqB3BFmag5t1mFdZm/9 +3wO74TfeCeL+rRKj+x+LDAtrtHrc3FYXVo8I67CGAIaQlTXo9U74eG5f8//8dboyg/wx260KNF t2VCkGPI2ac/ZCBjcZu9wrDCYDLtceoPubxfoUWbYQv1yOsd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the 5th patch of this series replaces .driver_data of struct
hid_device_id by an anonymous union. Drivers that store pointers in
.driver_data can benefit from that by less casting and still more
implicit type safety as something like:

	struct sometype *driver_data = id->driver_data_ptr;

is catched by the compiler to lack a `const`.

The (IMHO tiny) downside is that with that union initialisations must be
done using designated (i.e. named) initializers. The first four patches
implement that for the few drivers that don't do that yet, which IMHO
could stand as improvements on its own. Patches #6 and later convert
drivers that store pointers in .driver_data to the new .driver_data_ptr.
All patches intend to have no effect on the build result, so this is
only about easier source code and tighter compiler checks.

My original motivation to work on this is that the result also works on
machines with CHERI support that have sizeof(unsigned long) <
sizeof(void *). It's still a long way to get these running mainline
Linux but the nice thing about this series is that it works towards such
a future and improves the code for non-CHERI architectures, too.

Some of the existing initializers use an unusual coding style. In the
first patch I converted that to a more common indentation while updating
to designated initializers, in the quirks patch I mostly kept the
existing style. If you have a strong opinion there or think the
opportunity should be taken to convert all such arrays, I can do that.
This conversion is also the main reason that this series doesn't have a
diffstat with nearly an equal number of insertions and deletions.

The dependencies are as follows:

 - patch #5 (HID: core: Make driver_data in hid_device_id a union)
   depends on patches #1 - #4
 - patches #6 and later (...: Benefit from pointer typed driver_data in
   hid_device_id) depend on patch #5.

I would expect that all but maybe the last patch go in via the HID tree.
I can resend patch #9 to hwmon when its dependencies landed in the
mainline.

I build tested this series on top of next-20261123 using allmodconfig on
arc, sh, alpha, arm64, x86_64, s390, riscv, mips, powerpc, loongarch,
sparc, m68k and parisc and there were no build regressions.

Best regards
Uwe

Uwe Kleine-König (9):
  HID: asus: Use designated initializer for hid_device_id
  HID: i2c-hid: Use designated initializer for hid_device_id
  HID: input: Use designated initializer for hid_device_id
  HID: quirks: Use designated initializer for hid_device_id
  HID: core: Make driver_data in hid_device_id a union
  HID: steelseries: Benefit from pointer typed driver_data in
    hid_device_id
  HID: tmff: Benefit from pointer typed driver_data in hid_device_id
  HID: wacom: Benefit from pointer typed driver_data in hid_device_id
  hwmon: (asus_rog_ryujin) Benefit from pointer typed driver_data in
    hid_device_id

 drivers/hid/hid-asus.c                   | 199 ++++++-----
 drivers/hid/hid-input.c                  | 114 ++++---
 drivers/hid/hid-quirks.c                 | 400 +++++++++++------------
 drivers/hid/hid-steelseries-arctis.c     |  39 ++-
 drivers/hid/hid-tmff.c                   |  22 +-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |   2 +-
 drivers/hid/wacom_sys.c                  |   8 +-
 drivers/hid/wacom_wac.c                  |  10 +-
 drivers/hwmon/asus_rog_ryujin.c          |  14 +-
 include/linux/device-id/hid.h            |   5 +-
 10 files changed, 438 insertions(+), 375 deletions(-)


base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.47.3

