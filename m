Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766E28688C
	for <linux-input@vger.kernel.org>; Sat, 11 Apr 2026 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775880829; cv=none; b=S9/zZrSilkl9K/zTNE2C5SrtXh+9arKPX+xCyEiROw7UGglmBoN5j3299Ha5/NBPGirrqQlbVWqD3bN+G4NOFpHbNGV0733mdcn05Ss0bdxMQahVyOwt0tauBT7oezJANopPJ+ti7ADrfpBSrzaeZkYLfyKATKhr/VkSue6aUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775880829; c=relaxed/simple;
	bh=xZoJgL0pWd54xK6T7ncCbEYLmx9ZCILwjmKVz6EUJZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jaUVNuVLTzdF6l27eNGQsKMXu9NOiDHHPCoNruolNCHcM+kzxhKU2vfX9ucbPD6X/rdpPMWxp0Nykqe6gj+/0H7IWrsGqCh5PZiN0WxshkXDDGZ7bwPSgE6y9lBsz4WFY3g/CfHOlav7yJ+0fkT/c8whlne4qP5Kg6CkTgMxNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGtbHY0e; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGtbHY0e"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3928127eec.1
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775880827; x=1776485627; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0p0IRU1KSDrxTilJ3GLn5OhWBi4jSO5LLSmcLZSXUM=;
        b=JGtbHY0ejRWBAJaUwULldIiAF4RmxjIJkGzoRC3t0u8kHBOfHsfrtPWHO4wHm+VOSV
         a/SuQQQm/tQKWkeRq4C/g4qmd3aa5dDk4EU3ERr8SdtaSDoMOO7sl3Ow8jewFL2E9zJy
         taU/dtibDyOxiFuz4vXGOOugC+jzSf2Vu23mnBra7M1kZctdVV9vjV86gcqNFUj6yCDt
         xGiV7dvhrmHs0VBUkBXS9dS/BioTTWC3UFNl8mvC02b1p6Cq0Ev/P1123WKueakC1/a6
         ePc5Fwj5v2qguNUPboF9N4gWB2SyaLeyACfVBK+Oo+UU+cywPrKoJUruLRoAPXxsOEJh
         gbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775880827; x=1776485627;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0p0IRU1KSDrxTilJ3GLn5OhWBi4jSO5LLSmcLZSXUM=;
        b=ZQd6JQZ+yb0e4wAYDYwI+AMnpAqMJO5dmqVaXNTtlb6mq0x3TYlnNDF5yRuhFD6xnB
         zyUnOwxbfm0AB5DawNdpl/66HxwxoV2txn8QiQvk01dky8PwjqxKqwYsEWsBFx8uboEd
         /XbLv2qD/xUBmb4CLtetPOaiJI0vNwqEHn+g2MHxcz3Kd2LU4AbCpSQHlTXqvPH/NOaw
         Scrj+9Rxp1F4H+8v4Nc9O29gSdG1flvVQx9lEUmQwn6byXTfEs4XdDp/yZKZbpgi2AQw
         7GVoom0wf/wdPhkDT4rRGV3e8ANX0Lpo7bF9wJ4NcGuIoWIWiKovpj2O4GJFiqoSNmFK
         +FSg==
X-Gm-Message-State: AOJu0YxzF62RpD1mWFnXe+ZB/NTOSxo7F9OlC5BF3UYt0RrqlGkEKYK3
	ief0fTrjpEUmUda0tKd9+13UmhlnqNRrLXkZWYd4ZPThITWttX8+152GH7Uidg==
X-Gm-Gg: AeBDieta0KwzG1nWx0GrZ7q2MThc3p4jEfdv9vAfUls6/wgnBtbK0mY452YYHT0xB9o
	nQtJg6LFUea/fECF2j+AIUr4AbeKfamdc2Qz5YRtWbtfYcDpGuaZ3vw7AweWBvdZ+V+JvApNyc1
	O4ATKFDmm5NYUdp5kpbcLlP6YIJjsWPpTfrYYMzaKISrSd7XXQfa5nHd5RQJgc5se4ZzpyNym15
	G5ntKaNk6Fk5NXlDLhoJ4lIkFrmOuOqzmZKPhkHjaHUQfAbjngm8CCrzLUXHHtCUd8jr8lO1GxR
	DWXzgfmpBMqLcmaVJPGmXrYWpgX2lV6Taj+iHcABKwhnTVZsxaH1OESRY4v59fJqH55d6U0N5bU
	wtBnk+38qklmwimkoCRXADBYuxgnSTSvx192F3BASmxQzxTAQ44AwNV+ahWswL2lhNuZSFQy9jE
	ydW9VL3/wYi5MyDPk/xx7QWh+eE5/UqI1PUxYjra/BDR3ub+Mv5DoktIQ4PJAfMGOd3lE2M+dUV
	Q==
X-Received: by 2002:a05:693c:2c85:b0:2d2:cf9b:ee6e with SMTP id 5a478bee46e88-2d5895690b4mr3325634eec.22.1775880826747;
        Fri, 10 Apr 2026 21:13:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:39ea:e04e:4043:56c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c698esm7926503eec.6.2026.04.10.21.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 21:13:46 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:13:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: edt-ft5x06 - fix use-after-free in debugfs teardown
Message-ID: <adnJicDh-bTUaWXP@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The commit 68743c500c6e ("Input: edt-ft5x06 - use per-client debugfs
directory") removed the manual debugfs teardown, relying on the I2C core
to handle it. However, this creates a window where debugfs files are
still accessible after edt_ft5x06_ts_teardown_debugfs() frees
tsdata->raw_buffer.

To prevent a use-after-free, protect the freeing of raw_buffer with the
device mutex and set raw_buffer to NULL. The debugfs read function
already checks if raw_buffer is NULL under the same mutex, so this
safely avoids the use-after-free.

Fixes: 68743c500c6e ("Input: edt-ft5x06 - use per-client debugfs directory")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ba8ff65f7ea6..d3b1177185a3 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -804,7 +804,10 @@ static void edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata)
 
 static void edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 {
+	guard(mutex)(&tsdata->mutex);
+
 	kfree(tsdata->raw_buffer);
+	tsdata->raw_buffer = NULL;
 }
 
 #else
-- 
2.54.0.rc0.605.g598a273b03-goog


-- 
Dmitry
