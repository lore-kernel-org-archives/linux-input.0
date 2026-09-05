Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593A3DD50D
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591844; cv=none; b=L1Mhz0j/qQFrxD6GMk9NAgMfw7iejHzfhDxPseCENxRD1SJdqKwdu0Qx30Pf+Kvhw0S4EyVI/SvzQ7kY60YeQ1hnqKKchaAp/t+Q/SvehZngRP+gbdix/oNL+wkvJVbg68RoXE816tmpESfIARGbhYAlITFziS8R9pY6owe2qRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591844; c=relaxed/simple;
	bh=BaEoG/6SLaF+j+PN5tp7+Wdp37OedR46Vcq2/qxVkD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVtZysW/QEDnsuEptxXPrutd+JsWRchlFrQMyl1pVLQRrzBe4yNNQrIxpT7kvMJZPExITBAubU8ooDamGXdjLSXDehG8Ii6UaWG0qM1gyui1l9x2euN+gNh0FWM9nBHREnQ+rmGKHsbQwwXQI/M/USMUUQ67fbwVZ0k8HusklZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXucSUZp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXucSUZp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so23611645e9.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591838; x=1789196638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=oXucSUZp2Ol3i2pEYHldD3DV+2ASo+RTBaAeQzrMSdJwFrR5JTHpquTfUGJO0VfRIE
         nefv+Ft9QF+dcQrSpTKb+iYlhkj58POTcznx68yNS2hDNCcTJdUCP88Zu0+afuCjy9IC
         7gNO6PgkNSM31jvqT0DA7Zwli22mUDcz0OfS/y8E7cQyIjV+TOQPD3EmJhc32MvzlrqW
         ppVUzNkWullisof5hdVTWYukpstjDvRQD28atGI2A/LQKX/B3ZXElMe7YWp7xNwWh2f/
         l1D/r8Xgl58iLGD3h9V85GVYvVjIuiwEHWZYDkvQtAcAyXa8xPaCYW6G+IShSsQN+ix/
         ncHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591838; x=1789196638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I1Jlm5MucKkfjFwaOiA/wi4L8q8pr7cNwUH5XJFU8M=;
        b=HWx4WY675noOeLkXA2eZqihc+8CKEORypIfl9GnjR3OxcjZHsiyURhhE9x0K1dC3sy
         4dd0+pLBNP2b/hNWr2pjddUVsLDyBr4YWe+MIjalEGgItNVhGir0H1N2eIOxut2inxoG
         AriMe/R6f3+LyRqID5EGydscIc8LQZHHlmo8ovTmGViO7JWOz6/NisEIw37esvyPfOu5
         2vuP7ak5TjjYBqvRd/TA0QxMwAFjABWGf6QlF8ClpxzJMeqFNvApe2PfxgPL5ZvXJrLV
         JAF47a+Ro0jCgVs4ZSZQIpUOLb2TZ98apyG9oDbd6hqDGvIUfjEwuI5fVjQGqn93t0lG
         Z+jg==
X-Forwarded-Encrypted: i=1; AKwUvBxA0SKwE3AGvPUhnPScyC70YcPN4cny2N/RZ/vFQhHiHogqfsgiFLfMEC28D/9PyqZq8RU2dXavdxGqlg==@vger.kernel.org
X-Gm-Message-State: AFuF++nkKLzcAX0moPeNkHY94wn094ppKfJGG5HSVvTnbMoCMaDH6KIA
	s0qTmeUuNSomnWNhCkjCkaWjmP62FtoRso1RD0rZUlScSccvjOznTxfn
X-Gm-Gg: AYBFou2qSSi6PmpK2WL915vYGavq/knLwwFmJMzQ24CTqCgPbZF99XnV+tRfkaMWsK/
	o3kMciHZipSJiauXoZ16c3CseYCIFl4uut9Pz9a94OAwzK3SKWxwPqw3mPlMdY4x/lUD2t5iXHG
	Edcecx0o75F/ji0/Yd4PN9o4W8KgfivN50XfyfagvoTOrTgR4/DTXL9adLG84TeL8FPDe836WAf
	6TXwj6ouz+Itf90g/MF0+PiEdaDICZ7IigbDRHwOEQ2FJOX7GR0yUWOVMOBrb9gNnsl3uGAI8p7
	hmsPBLTqmQNvGkHWAlXoCkAvmy1xFbw6L6T/0/Qjxnh5YYIFWPNfVaXZK8GD8FlCBVdEh3mpYXE
	8rd0f+wi0LQMuBIG7mGAXLfHUf8mCVYEZkA2Z4Uq1EhNqrRZoAhoKpPWX3pKDVB3fxho6VqCaYj
	u2MWo843W2sfJXpCZCTHnRUp/ncAZtecU0rNXzUBuQI7ZAKS7oFanbByFtZASE/4VOPChvhcU0O
	99WDTpgKUpTAlNpXq67KU4NKsdEbN/wZwWMAnUQfZO4pfxmEs86ZfRmADMXjKXShcsNUttTvxLD
	O0ESkIfjLfjiePdleM1aYGkJJxDMm2LsBD2SU3l5otcoFJZEkypXjCVpsQ/CQGqs9Of7uPmW
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49cf826c5f5mr97941975e9.13.1788591838387;
        Sat, 05 Sep 2026 00:03:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/9] docs: kernel-parameters: Drop the bau= entry
Date: Sat,  5 Sep 2026 09:03:40 +0200
Message-Id: <20260905070347.25902-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
BAU TLB Shootdown Handler"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c8d96de4c00d..99d5bb68968a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,13 +624,6 @@ Kernel parameters
 			Format: <int> (must be >=0)
 			Default: 64
 
-	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
-			behavior is to disable the BAU (i.e. bau=0).
-			Format: { "0" | "1" }
-			0 - Disable the BAU.
-			1 - Enable the BAU.
-			unset - Disable the BAU.
-
 	bdev_allow_write_mounted=
 			Format: <bool>
 			Control the ability to open a mounted block device
-- 
2.53.0

