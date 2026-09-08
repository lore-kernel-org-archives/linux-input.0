Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C26524AEC
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859155; cv=none; b=XMLB6FZs/r2W8di0g8081Ti8oLF+9rMBHD41o4ki84Pyy9t/WHJmbvAGouEiBf9L7Peqza716ItQqYtaVQqhK9OdqdR1zXSw5obU+bc39DzpY4ZKMg13bWS9bjFiREQwGtIR9ykq8OW2rO7WpoiGjDZ+y+Rg++j7noW/CzyW7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859155; c=relaxed/simple;
	bh=aRiB+/teBjIDoYnRyGta0AirMhnk2B3V+bGT69BxTT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbqXNYdbtA/DddiOj4W08knzHR56jCmDbPhPGiMhxP58keNDELGIcG4X+9rIaIf5XyQZBDqKkqrZNfQ6SaR9EY6LUhSdJu92jy5opOFv4pJu/i06fz6GbfIsQpdbOIi2zUwkFuT6EnWMV7WlDZtxooKMDVu4ouPxXiNvw3YmQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=hpN+HYXT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="hpN+HYXT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2db59f54ccfso10221265ad.2
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1788859153; x=1789463953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+p+eQJQq3ynMvnkReVl5XGX2RkMKrQ5ziE2R3ggq0Vw=;
        b=hpN+HYXT5sygnHKi22fCWVMGkdcxPif1YITvIhnydpyIwUCnOfAVvx/JFf7XwnBUWs
         x6e9prKs5xrXJhfakzFYV8J7FGuOx/GRUHGBAYiVI4pMifplt/scF5XvV4I+jOs2uNxl
         D5sgxFd536p+PZoZEtz8fyxpQ8RyDzNz+cK9HBolRXrd0x6mh+iPu1tCYlqk5quD/R94
         pj78x3r8oM+SVmjixPOr+A4/8yN5W3DlRQ2e9Dq1J7qO2a8B95tq6yIMwftAZq+745LF
         UjMUo/GQhKC4OdfcsQj/1/J1uZFjyJW98P8aqEd6mnhBE/hhYspc7qvxdP9/uBjTMNCj
         t2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859153; x=1789463953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+p+eQJQq3ynMvnkReVl5XGX2RkMKrQ5ziE2R3ggq0Vw=;
        b=N89BNnpzu11bbbtvKNtLT6r63z4KNt5O8QMbN1LbKoH6AqSXsALJH5FHS6Znk+T2tg
         8WvctcG643vfasYi6TivRqscuMJy1qqG1JfCgXk7vVcN9jbmZb16HlKipD3r54hmNiLl
         HCi+miCA4MBYjLHzR5oVloscq0ixJxBcnHWfqhrlefzxk0ki8k6IJSNwrNV6ATKId573
         l0HE5uFONF7bnPdAiVhg5aUrndVdiJkAsRhzmGxDS/AhLvMxMzcPzhpirA8CKM+oRNz3
         9Rxewqz7fZ52KOImjkqUhRuWCTBjxQ90oE7nFS7+WosqJXUfr39mILUiL7dI3I5zgYON
         s1hQ==
X-Gm-Message-State: AFuF++n+VNJdyu1P9NCvdAADjm2jMk3uv7OLbmUpEAxnWKCQap/hv08R
	/tix2iM6VDnGiyZKZkrMbaTwN6+5xBNdAE/JnLqu+RzjOxAOj9yuNySAl53vUiApw3jB4rId5GB
	9WO5K+mLS8A==
X-Gm-Gg: AYBFou08YOQ0FRovYSH+Z57/IrArIbYrf9tWLu6rcFjXy5trxcs0kTAxUS9RkR4BbLq
	hNlk5ySvslpdWWSLi1GCAFKI4JhdpUPOd8N9R7NkBu82o0AgEQD23rW8qW4BxJibjtFx1DxU56h
	CZWFpjoC3T0qyrDJZfCAC5vWN2kigfanp2FzTRm3cJ8f/cwV9hJQqy8bhFvxQhZ4Ofta0HjFogX
	4bSEB4XdGxYV/E697h4tkJ+cy7Joq/h4U4bloOQN2D/+CTYkY9YDGe6RC5XvPwEVR6mdBibpoGV
	JqeMBR3b+jkcxyeikFaDufvZvqYLe98bg8cqRye59o+rPT/xc9n/sN2LV5FkU9OQVkn9TlR1jX9
	qw/sjrEkx+ZcVy5SpglOp8MDMurEtweSrgnwsta+MnGFW/PIxVOF/94ggP/LtG92z4xX+68+hGo
	V+dA+GTg38t/vFawRpondAL/Vza2E2fTc1RrisOyUpxrrAUjLsOkM2eKrxUTWduzDSM+0R+ZaZi
	VnO0Q==
X-Received: by 2002:a17:90b:1343:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39b26123302mr48843690a91.3.1788859153130;
        Tue, 08 Sep 2026 02:19:13 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:75be:f01c:dde1:cb38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm32015722c88.14.2026.09.08.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:19:12 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 08 Sep 2026 10:19:03 +0100
Subject: [PATCH 1/3] HID: hid-google-hammer: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-acpi-hid-v1-1-08df24c4b139@thegoodpenguin.co.uk>
References: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
In-Reply-To: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788859148; l=889;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=aRiB+/teBjIDoYnRyGta0AirMhnk2B3V+bGT69BxTT4=;
 b=ud5CAEzaFbggl62JW7umNOg15pODvY1/dk9PuhlTmnx5RRzcWUGmdiHXEJjWArahDBqReD4/v
 HBKAzGJ268rA6jh4FRctvpEUBO+711N51N6NINJBX2KXCeRXSxLBc3U
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index c99c3c0d442e..847b1ddefeec 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -268,7 +268,7 @@ static void cbas_ec_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cbas_ec_acpi_ids[] = {
-	{ "GOOG000B", 0 },
+	{ .id = "GOOG000B" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);

-- 
2.43.0

