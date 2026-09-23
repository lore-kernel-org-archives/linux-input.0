Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC7497B84
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160754; cv=none; b=EIWxwVpNS6aTemr5eWkxzVBz0JRc7GBwJA58M5xVcpzpUXTTctYkWE58e+VPuO3NtuS989mWSzEdemmtMLsrtZ4I7cbeJFPGNPA5qANzHOkj8G1zQju4qFNLKtqeHqo9fzp+8rppzI3TmzN61HfPuntfsYklb3kWIuXtw2VoSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160754; c=relaxed/simple;
	bh=xrHgSFEJMs78mvMQZzVM9Z+570q3BIZmlyKkhqlhnVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4d6CQv3dcJNB45c0TW+k0Vry3mNlwPxrCdj4NelAAm4WpzJ3Y/mcV+tpDX0i9CB9LEw+Q9Un2HlTrxAjyL976Wn0P5HZpHet112VJ8EL9WG961lczbdt3YqRuqqXd8EKPLqPOthzgMqgCE3WHLtob4j/09rybW2+wl2toRTtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4AiaCk8; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4AiaCk8"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744eso571306e87.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160739; x=1790765539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKBPC/HUfOeYNRheVRrqScAzgVBluDo4sVjYT3kJwDs=;
        b=P4AiaCk8q33o00b6TkSm1uwzVp5j0bs+/88asbiXZtADY7f1+3KtNXu9rL+3FsG0E3
         T42MPte4MQqs8LOxFJcved1noxayJhtXz5YyZIQG8V34OtfN0D4kNZVkiVfe1YqgLiOg
         x+QEyRGDJ9FRoJBdn45QI/F3cB6QTebsVIuV+qNylPrGk5kp0C8y9IlGy4+caRpSUC3B
         MVBX8EVUQ4kyNBZaLX4DnzBerymMZ66Rp8oi26CEZ/Sjvp/9nE8rMl+bgi6e4DYYnyOX
         rgJWpKPatF6zcsnF5eqrcW3Xmp5tiipbqADwuPH9lBA42zq6FCwLRVafz/ixT3DYcRee
         1Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160739; x=1790765539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKBPC/HUfOeYNRheVRrqScAzgVBluDo4sVjYT3kJwDs=;
        b=hFsCqrPZHbPWwwrwW/WI2oxpfHTp/pkB/vthIbUxRTsAl76QGomH4/AZzs7FQvG8Lk
         NfRv7dp7TnuAfa4LMMBOrkk4GugzG/XLiyc98pNL71E08GmzcGmyZr3ots1cX8eH0oNv
         YRgOVjNDuTmsOwbQIgnXrxFdjMevpVtB7PJR7s0IaODPxsaJBsxJX2A8tEtnlYbgbyNA
         8ziFuSEpOTEwJkQWpw5aowl6ijdlNG4LHVXG9qtF1tq/wP0DacuvZ0D63H9wA+YcnDbE
         cXoxYAYSSlTF77ZG+F/X0s/uW3dFuTgTjJVeuKhe6iZ/8Z+Lvk5Uq7S7WYmkXmt8F5pm
         pD6A==
X-Gm-Message-State: AFuF++n5AY0Bl2vJ4VpeE4dqnSdkrM/55ESVomhCPeBakcm9K1LZKhSe
	6+9/Vqu+2ecdlT8ALMraJxbmpJTlef+BQwXYL4DRIbXy9d+UyrKUOsJJ
X-Gm-Gg: AYBFou0E1a+lyu3ITyi4JbnbtWssL/dMQr2U8EVLGsgHEJaVJxv24ACNig3zYBsMWll
	xtsThWus5UlAO61itPG+WBCSiiw8M5hkz7jBJSgG6WM7vDW69N82Q96yVRqUgqEz8uQCs3wkZSf
	rCHICOAIna4x74SRwZXhvvEVXTbrm9EmzhPhBrAuysaVaz1Bzd4oRgzlFbuSmBUa+VwwoIns778
	DIf2NpcT4j3Kj/q6VtKn9wQNEx1mqDYgqBGvQfvizOAUzOkFlNxMua3EZ/G818sQjjOTKH+T+uz
	ETJ9DfK5fCwI2iRcYtEaB9pSr/yYuw0z4xwtyLeeDqrQK5BuyPECoFcogOeJUSgXjiS6+EIGqJr
	Y+6rOTAiEoUpwxE3tz+jylDJaI8kLg0IOYn9VwwmnwvHnsRLNwuBqpfHF91pJ+/Zfbu+X+Znqy9
	YBtfkL0Mtg04o0ctWgMyRFCdzVgm6adK806d/zeHx227qw8IAfMsKtKpw7XjV31POuN0hhKmJOk
	6wNH7e4M0XfpNU/nBW7uzUjBavQgA==
X-Received: by 2002:a05:6512:b1d:b0:5b5:e66f:2ac2 with SMTP id 2adb3069b0e04-5b8d8952ef2mr759840e87.6.1790160738756;
        Wed, 23 Sep 2026 03:52:18 -0700 (PDT)
Received: from DESKTOP-7GRJKK0 ([188.226.104.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8589e1csm503208e87.54.2026.09.23.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:52:18 -0700 (PDT)
From: Vladimir <anykey196@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-input@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Vladnwx <vladnwx@users.noreply.github.com>
Subject: [PATCH] Input: axp20x-pek - add AXP313a support
Date: Wed, 23 Sep 2026 15:52:14 +0500
Message-ID: <20260923105215.1633-1-anykey196@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladnwx <vladnwx@users.noreply.github.com>

The AXP313a MFD driver registers its power button cell as "axp313a-pek",
but the axp20x-pek platform id table only matches "axp20x-pek" and
"axp221-pek". The power button therefore never probes on boards using the
AXP313a PMIC (e.g. the OrangePi Zero 2W).

Add the missing id table entry. The register layout used by the driver
matches the AXP313a, so the generic axp20x_info is reused.

Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a), kernel 7.1.13.

Signed-off-by: Vladnwx <vladnwx@users.noreply.github.com>
---
 drivers/input/misc/axp20x-pek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d89..d4e2fc9a9 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp20x_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
-- 
2.53.0

