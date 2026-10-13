Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7451CF72
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904543; cv=none; b=KsTbLVUCz1rCCYlPGrcuc4INcDARQQU2QeAgGgEJcNAd9jwSPwfoY4j6mItPTlYTtNCViCAVcQcrnqJ1mUg6anLaebs5JtkMOkUncVuGYAcIuIrEkv3tLF/pmWGAI1zLE8o3zutuxLWnCTWkSl4XxwYGR6N0u3+9eirkVbulH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904543; c=relaxed/simple;
	bh=R+x6yCbTEhg1iCA8UJulcGnJ+nBmRBOkJIUUtKTcu9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjG3IGJSvrZPNt0RZXwMZ2kHsrvc3I+iuwKGJ2jAoAILgWJDQo5t1ARgsoX0EAhTqp4Iw2iVyY6P8ad9kSl5Q+sBB/+qwiHOsAjBNzc2WrGJzYipN3YGmFaa2JQC8goaVm5BPilBhwYWOtyAXHU1KnA72Assw3aIgkckdp2B7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=vHocCCxH; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="vHocCCxH"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1419d3416ceso4705663c88.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791904541; x=1792509341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twoJ2ZpEkiCJSMJ/PObObKqGrhHPIutiqyJXjtqIqUI=;
        b=vHocCCxHqL4nYWc0Wp/pOiBxM5jb1B9v38sgNpb7gK+1BFs3izxeUqvVALMZNcQx0A
         hKVN7ZW8JwZ+r1bU/wkIyXYAkMaXSNKicQwOgcozjXzr6Q2mywdBNdCSoU4QxdxPQtNO
         wTv7hJ3DtuOtWqIuwFZiHxzUlou8SWeib4gJJ+/QIrCedEFfA6/i4uhnCjkRtJ6kSbj3
         DQAHo7KGbAm3dWR8RPF7Q656GiCk+VkzbGruyNe6JJJ+5ODGEjvO3SiBxp7pw28XZkhs
         g38IwHvT1+wU9WCyM348aWfDFpsADq1MjDzYW/juilGzwNuIhXX0DsRJqprdDgWvdb9n
         Htvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904541; x=1792509341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twoJ2ZpEkiCJSMJ/PObObKqGrhHPIutiqyJXjtqIqUI=;
        b=W1P54CZ1Afs3gSPIe44YyMzlkGiLeSkxx/cDQSqT9kLYO3nnaRxXYP3J8QZsUWUH9b
         K5Ds/+v4ZX05STKDZEup3A+i+Tbx3ib9kDNOg0cO4TkWMhq7LY9oK4wj4oVn5IAQ7R+D
         SZ603ybDjS0ldG09m1DdCoeig2J0SyLKRCAwvAijpM+ozPTrCgrUPBJ+Iz5iZz+lhmVm
         6J4q4h1bhNDEA7XQVXR6e1/buuUWmZMi5mhvmoYpSO+DlyXsN6fAqQhms5OYEWO/lat3
         Ur3Uc1gFDJJyRSDqDUsNYtbXrTFwo1eO1Sd6/+QYL7c3lOCOJYv1xovNF9OfwnHgZdrI
         trTg==
X-Gm-Message-State: AFq9FYIhtW1c82BD/+Yz9f+bDgPIDI5uz4sISPNpC1g305dBPfrQ5O4l
	rSMhyo0U8PFlMQcz8S0NkLlrr8DmGm1mTaK7NGi8LRFrBvmy6j6VU70g9TpEGIlp5oE=
X-Gm-Gg: AYBFou2PN7C1SwDyzhNgY6MpIG4w7ouc2C0NjBCunSxFGZh7rNC5O1v5m77Pn6tPupe
	TocY+aF4PMBo4esZc44gzO+vrVVatZ1wjtn0wgGPhrQKcALVczYff1yITyHj433aOUzwWWSgHRn
	EWMCNWt4iTfbi5lRuWC+NN5VAZ7EoJT2ZZgJWWmJ80a0cIyjdtVD/aQN6KWYQwUYlrGJlww+y2b
	mmYZYajpO0vsKXGEcXKED86C3oREulqx5FeDKabCHukVp8302iXVyG0vWWJbRtAtGpq+xtfkBlZ
	yP00VJ6QqOYxiZfnRnjM6PCQqx7N5HhpPV6ObEY5pjnUo2q6BUB4COR3dEew7LjKjsjAv2/POXR
	joLHjqEXgR9mzDMQcuic6g16yw2XLL5mc7arhcQ+3lo0XpnqmYLAiTIVjmt3offn03W1PN0pDOj
	cWB1R3pNCxRJRyDVQa03NNKDEBHDnb7lnqqtVESoW01Y2uAKbCGxx3J2JQ+SElP775w+yze6UHd
	glDg2mSZv6Fz4w=
X-Received: by 2002:a05:693c:88c6:20b0:359:89b9:5e09 with SMTP id 5a478bee46e88-35989b98cabmr11650319eec.36.1791904540781;
        Tue, 13 Oct 2026 08:15:40 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:49b8:4c98:b3d1:72aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm30691751eec.31.2026.10.13.08.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:15:39 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 13 Oct 2026 16:15:22 +0100
Subject: [PATCH 1/4] Input: keyboard: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-acpi-input-v1-1-53ad09ba82b7@thegoodpenguin.co.uk>
References: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
In-Reply-To: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Nick Dyer <nick@shmanahar.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791904532; l=2155;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=R+x6yCbTEhg1iCA8UJulcGnJ+nBmRBOkJIUUtKTcu9A=;
 b=tynwRR07lflfN2Adn7AWs9XuSyVn8FGf9xgL5LPv0Nqj7tPig8HEwG2G+MdLPy08kruyo8R1k
 Ax7l/6Y24inA8KyqOSBwWhD8NCxxp0pAXI+9hTrmm6cz4OOUXMThHXB
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Unify the list terminator to have a single space between the brackets and
no trailing comma.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/input/keyboard/applespi.c        | 2 +-
 drivers/input/keyboard/cros_ec_keyb.c    | 2 +-
 drivers/input/keyboard/goldfish_events.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..3d04f54c04e2 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1904,7 +1904,7 @@ static int applespi_resume(struct device *dev)
 }
 
 static const struct acpi_device_id applespi_acpi_match[] = {
-	{ "APP000D", 0 },
+	{ .id = "APP000D" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, applespi_acpi_match);
diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 177e5d4a3382..bbcca6f265b6 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -911,7 +911,7 @@ static void cros_ec_keyb_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_ec_keyb_acpi_match[] = {
-	{ "GOOG0007", true },
+	{ .id = "GOOG0007", .driver_data = true },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_keyb_acpi_match);
diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index 57d435fc5c73..d0e387f22faf 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -179,8 +179,8 @@ MODULE_DEVICE_TABLE(of, goldfish_events_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id goldfish_events_acpi_match[] = {
-	{ "GFSH0002", 0 },
-	{ },
+	{ .id = "GFSH0002" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, goldfish_events_acpi_match);
 #endif

-- 
2.53.0

