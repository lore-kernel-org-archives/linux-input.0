Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D85390998
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010493; cv=none; b=q8UtQSaOsQP7Tpho3V+zNjfHJSrv0RbNskdRr91lVy5Mke9I64BeBvObqBFyj0QQNUeVgJBinQXTpv3GESmNeQ/CrlSKnOMRD3q+dAoJL3lqE5bJbcVu2XoUA5PrNi7VB+YoDR3LpNsyLVwxUd4LUivhIwl6kB23rNVsKPqnkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010493; c=relaxed/simple;
	bh=jHHrb1gkKCrQofVQkjlJcoMNCA+FXIvxVOvLoWJQF5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2MDTdrQoKbyKawlhZT/+hnGzNOpg0DAdR03vGQQ9DS9Z75Ni9PhCNl2R9jjDAS0j/AQPBMoMJYfc4JpDvMqyvDKy+vSyApjwyJdPpsYKHI65z7wBMnJVFPxKU2verbjPLsVfxluJM2ocu25mT1DAvcwZca5qRgNfkhFlNbD1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAlfqRO+; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAlfqRO+"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4bdf4f0e8so645299a34.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010491; x=1789615291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrGYYRXsocnHt4R7I9PwAhwsbtA+DaKDKrj9nTvfp+g=;
        b=tAlfqRO+dj20/CslGq/8CS4REHc87cHhZWBpneqL8yMS2KHPSlExi9EXp5TlN1rrRS
         PX2OyQ1DtohPQQRFc67f0x0miEKxBTChmN2ULNPoLG+UR6mtijVXO/Va6ldkadtre3u7
         oMRlBYfJU943iYcE4k9P3m+E2EFUhvBm7Y23tLy36EPqHRY9bPlOizI+APFjlzqhqbYn
         s6KDyttuSzqf2WTx38JEeNET3x/CNTWy3FSl/5K+UyQ2+GQpJqGlOuNToXSzPLRYhX71
         jCp95ltzfAc1quD8WprcCOWNBZ06nDx/xd0PnTndPeemFPlMUngikvyLvvCtAGfl37lU
         tMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010491; x=1789615291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CrGYYRXsocnHt4R7I9PwAhwsbtA+DaKDKrj9nTvfp+g=;
        b=Zq5kF6aJUnrv/taUl88RJQYKf3mCXAVgyuFDYMGxgMaUwbQH8pyvcXRs491GXe3YH6
         4St1J+g9J4yHDpUi62sbiXRGj2ujcMMPh8Zw3Vcal4seE2ykMmBtWYyFcMMDKUNgsyoz
         9xRUij0rKOMOd5aCoEp/oj0ye8AOy2+0//RG3B8hLyO8wftju2tHi4rarMfym3uZx3t0
         V1umPHWcmtu1MBHdI0WfyoSf+Aq/PyPtwE6SwuLoR322bq0pD7JIwBYge+KAP4yl6Uwn
         LCCBJN84vBdEGb2rycSq48JzutFHOn4icvMTRk0p5IQjIiVpq4gXsNYrjDGOctQ+jYqa
         ufyg==
X-Gm-Message-State: AFuF++kPqt/IzXQa6prM4p9H1cSTDjwh63JOZ0KlH0JwRxgeR7UomSyq
	8QhspiTi1O9ZGJgzlQVhrMLFkuui1Mp02HIRHVtCTJOAG1aFmGeY+6kT
X-Gm-Gg: AYBFou0vmoZBUH0JhD7QGaM1vyDD0JyYHOl5WtNLeNMGHI5EfkbSFdKhXy8jheI2aqx
	PQgLuLE0GSasuCsJSsdEx60pGpf+ZHv+dgtvS13sUeS1tp6DVxxEYKNzmyNNXJ5aK9HSHjMco+P
	UEXLlRXkW8ORgkwgZzVCgfhGSVSnC0OSkCF7eT543EgJSsNuKklBKWsBTWdT3BsKxIljFsvxywL
	3lMYSmSXon3LP/cyp9Q+ZcM8LSjJw3b+hUUMzwWFSoUtF84FbrKWTHSM8x7pcTg86ISuFbMrnJy
	4woQtYmf+dqq/pRLy2mIqY/1MXX1T8yPgJ/ux8fpzsakxFNxEtUHltIQIt3Dh8Yx1Kc4rMB0Tzl
	TMEOCMENZJ6kZBfxa/5tEz3WPA+UOaDdfM/Qz5nZzDqmWvz8rvhWRK96p06Suxlu9xR98rxhjOK
	KOkW5nmZms/aahknYGja6rWJOEOQHqWVtv6RYtaqJv5TP7wDuS8btCkLzeytXYyKdJ4Ly8WXsxD
	cpfybP853xd+Us5iYvb3jlUSsIpcx8vZs85Y9tBJ6vaqPiL11S0qxQ=
X-Received: by 2002:a05:6830:3495:b0:801:b3e8:25ab with SMTP id 46e09a7af769-801b3e8a6c8mr4013717a34.2.1789010490678;
        Wed, 09 Sep 2026 20:21:30 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:30 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH 03/15] HID: hid-oxp: retain fractional brightness when reading RGB status
Date: Wed,  9 Sep 2026 22:21:03 -0500
Message-ID: <20260910032115.28669-4-andrei1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiply the hardware brightness level by the LED brightness range before
dividing by four. Dividing first reported every intermediate hardware
level as zero instead of 25, 50 or 75 percent.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 0c895bd..86a559c 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -334,8 +334,8 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	drvdata.rgb_en = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
 						 OXP_FEAT_ENABLED;
 	drvdata.rgb_brightness = rgb_rep->brightness;
-	led_mc->led_cdev.brightness = rgb_rep->brightness / 4 *
-				      led_mc->led_cdev.max_brightness;
+	led_mc->led_cdev.brightness = rgb_rep->brightness *
+				      led_mc->led_cdev.max_brightness / 4;
 	/* If monocolor had less than 100% brightness on the previous boot,
 	 * there will be no reliable way to determine the real intensity.
 	 * Since intensity scaling is used with a hardware brightness set at max,
@@ -423,8 +423,8 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	drvdata.rgb_en = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
 						 OXP_FEAT_ENABLED;
 	drvdata.rgb_brightness = rgb_rep->brightness;
-	led_mc->led_cdev.brightness = rgb_rep->brightness / 4 *
-				      led_mc->led_cdev.max_brightness;
+	led_mc->led_cdev.brightness = rgb_rep->brightness *
+				      led_mc->led_cdev.max_brightness / 4;
 	/* If monocolor had less than 100% brightness on the previous boot,
 	 * there will be no reliable way to determine the real intensity.
 	 * Since intensity scaling is used with a hardware brightness set at max,
