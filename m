Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE1299929
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438374; cv=none; b=VKAff1OiN2nDosqX+nTG/OQsgVgB2IWcf1rMIzQhlppTS6p4ebHk3bMRrlySYVL4o/JBiFb2rZczQOsOqJC6cmQgrXsflsR9kWpBtQAOCMVKNXyplYyLKQ1KdGvixgPSoevQJe+fiBW6hBVwE4DUKdp14iMlWMBawyph700qH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438374; c=relaxed/simple;
	bh=FGrRbKRt0eoQO99iU3Dc5Z5iqzdFbEcsKVVA8IuQ5+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SmNrrjdPTtlY9BXhkVGoHNBK+9TNCv5ZyoNN3lJUm6Q7uUTSDOEFdlYHoUCVghi4Ed+Lx9xluyB8vEPZmIHOQrc0NuwPvo5w+7YXL7jE2gq6BZyjDPXt1ctHSP9fxKS3MkLI6I7I8p8by8ogAf+XKBEZlPd0eDsen2GZsrCenGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqyGuhiS; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqyGuhiS"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so350470eec.1
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791438372; x=1792043172; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMfPzgt3xAK5X+A2OuqXJNVUyenGzQ87xP08w+wp1aE=;
        b=CqyGuhiS+WZyaXufWnG6UIjgiKavyepD3X8RdrQjyTwfdlpnjij8bouJv6QDpKBw+b
         EvqECGk6KwTgZXbcin/3zptvEYZS0uoHpXa1kE0sDhoQytivie+zpKgz9c/g6BDsfrA4
         CnfmSH9afECWz0LEDO+9nqf5EZ9qkpzR/72l/l0ikzgJIemnWr0l7LRV6+h+Cbuf9kJw
         RT5m/jhK9KW3f8ZrQrgEMfB/m8PbjEaFPH0/6poFEPjUsYH0hJfDaT70x9PvJA/LGJl0
         fJgyYgeuVvuDWvKdRMSyuv8tzW969hAv2tYIBbmzIe4AdJ6d+GaxFHNipF4Gdat8pJM9
         6g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791438372; x=1792043172;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMfPzgt3xAK5X+A2OuqXJNVUyenGzQ87xP08w+wp1aE=;
        b=Jl7PGBLkWKx1MXK/YGS6HA1/+lFHf7M4xext/TvkO7+SjxY1V+sFCPnbmQ+p92gtlu
         TvxmOYTv3ku3HjJvoVMcA+JW7P4Ig2fdDncF4zja12oZGCBNAcbuRrFkKkDL1NnSPq5A
         IaBin37y9pCBqRVgNbsMbLgz/YHtzCe0aagyvJrV/xAHTv9ba+e5ncRcXHikflxQmzBg
         cPran1RaUyMG3mJVETPHg/ByAOwT9gxVk0jSqZR1cRHc2gsZj1i04cvLl/kDph02pDRe
         BiNvzm9os01XNqfyALHaZ5ykZiYLxzdE2eSxr1OTQdLQ6DFylYvctnfNq4txDoCbUlfD
         FPsw==
X-Gm-Message-State: AFuF++m4fsz9e+EqW3omMWA+uRPlNIBfCouB3qu5YbYizYjSswvVcObZ
	h8/ilNyO5esUcEwTkLguz3jD4IPytFIocp478MUIA1oVae/y4phhplPSspccaElYcLE=
X-Gm-Gg: AYBFou1bjF/wCVTM9u4//DNubRYW9drNvYcvOU35Ztq6+qUu+nSFwfTstZk6uVaAMxe
	7yrENzqOEFRrQqliqi14kMDaQkDMq84zGHXRufI/7RHXdkX8XwKko74naRGK/7k9ESQMGovPNH2
	rrl6IhpwagPV+ubQXL2PIh4KYGKyYQk89S2/fBRSzHeROjzjotoTIKG2cxNdwsE5vIZFaCKmvkH
	A05EMQ4SDX7l19Esj72JEuhvPVfegOzVTINSSRxJwQbgE1pYAfpOFpbJBs+vSkg5l9QdTbUH37M
	H9HMs2rHMlMtHQo2aaj1TGjHBQLG2SO+9KrK+B1QYt4SAwRC+vnAyRXsDOuySnaDe3x9ubABWfs
	cc0jgFKAqff4XfdpKl1AtrSfseVywJam8W56RjLpiVODsYXInXeBe9po8Z8JykT6M2io46qRVSk
	7D1eMHePHmOtgnBl8BmFFaT+fWhc9+BfQTzHj0Gjl15Q/fsL1KWse9f9g545c8wqRZstfzqEiRX
	6vuSPSIJO097Jhg193dVzAvW9kbgITA/lXrapV4AKCeH7QXngk=
X-Received: by 2002:a05:7300:d185:b0:351:4bff:6d6b with SMTP id 5a478bee46e88-3515dde3a20mr5014522eec.16.1791438372329;
        Wed, 07 Oct 2026 22:46:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c2esm12095989eec.10.2026.10.07.22.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:46:11 -0700 (PDT)
Date: Wed, 7 Oct 2026 22:46:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: gpio_keys - drop redundant input->dev.parent
 assignment
Message-ID: <ascuEtUKzVdo68uO@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

devm_input_allocate_device() already initializes input->dev.parent to
the supplied parent device, so the explicit assignment in
gpio_keys_probe() is redundant. Remove it.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e19617485679..defe4074a60e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -885,7 +885,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
-	input->dev.parent = dev;
 	input->open = gpio_keys_open;
 	input->close = gpio_keys_close;
 
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
