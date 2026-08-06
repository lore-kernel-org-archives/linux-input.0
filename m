Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0822389E07
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785995069; cv=none; b=ra1p5MUW7tAOPDooFSj0WJScZoFGhkT6Q+LVd6sgPk9QSkWDLTwnGcRatdEnWsVru/UpJeHSOwzCHqdhP/wq4BSa0j79Hva6h9nhuUACrZSwuccN0dZbHd9HM80bena8R/m1xKJhRpewDMc/Of+vVr2rV1sEFHBoeXnS4iwuy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785995069; c=relaxed/simple;
	bh=BB0XDwtNsg5sGEaL5ETDBRFLTiF+vf+mXIZ7iLAQGXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tOY/y2euUtQzbEga1M4rw1sF9OV9SlBW9mdkE2sa3N+U2yt/t+PbUz+wFfiUDEyzlYJUzF+ctp5zNWvxICVXIi9O1OZLTiKjiz3yf1b8dm88N1UcvKW/dM7nbAVj+68B2X+sxSQMuChNEV/fEnFkHOfKpAoPT6tpbY2Rj2SYV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5fOf9TW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5fOf9TW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cee9b74ee1so16001645ad.3
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785995067; x=1786599867; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pychluIunaubpB1G6cK611lZWZ6uJ2B672d9+W8YoV0=;
        b=l5fOf9TWd2qdryEfPxK+6/aQZaTXHWbp/XEtX9xkDQQpZSetU2/U4wLeCel2fCVuuC
         qkqgdLrucEiasAOcCPzH/BU3LX3qZPkPXHTOaxkkMhjHg0QzZCvHsFNFNz3YYV2xw6RA
         SzQGPLn51dP5WtuB8RqVsu5V43BUI3T4oZZrXxgkF72Ltmw5uYSmCDjYrty/yfqxLyiY
         ZqGYDPFIyAWwWGTLG2vXB/8C2Fpt2F/jkgBbPzGyTmYn5aKO1NAd4lpYOEsujO9VVGiA
         NiW3IAkZ2w6uP/crGbFNVAdHMTuPIp8VIP1+rhfOPJ0ABhI2DX2k2LB0QvhcV60jGP86
         uxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785995067; x=1786599867;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pychluIunaubpB1G6cK611lZWZ6uJ2B672d9+W8YoV0=;
        b=LYiv6hYvRm0l8k8JICQVOahs4DqwRtKijJyzzgcOBaY/nevPU129kK5SKhblG0lC2l
         Xl8k4VaOX9Uk4Fpzjzw18u8vsezEUuSXENVXL0V1Su4FAjnUd8EzzeuR+JdOoKMZoRcF
         FklXJLf6KdjoNfW3wywWoPuzapz86jShryer77+ZrkLmshFk1mME0YBHCvWggqTCJam+
         6m7pVMxCmG8Q/Rh4hub4Z+CNI/wxjJ1kMAxzWxYX8Z97HFG0aU03fC4de7Ay6+QQHI1t
         H9cZO3MctDzpqwLBnRiZvjxTxEVphnQmY4m1XsC9B/7HHnyXGx3Wbr4YJSVxgxtwUmja
         mvJw==
X-Gm-Message-State: AOJu0YwN9yr1Rvl9IYBcIzZGc1FPoY2wMJPeMCb29//BmyyP3Ft9lkAx
	GaF9pXRXRLHjys42Z0k2WXIIuh8Er+bKU3XlnsF4kILUTXZfoYa221j66sWO9g==
X-Gm-Gg: AR+sD12CTfvczIOBswVUj2ghpAwU8VWhOOhVaH9ojuRkXlIbFucuncbZkIYjQ45UMX0
	JHKuIMVzROYVG1Uh+KAHMnM4bRtHiGADPXSrte0HdzYOjlX+UvFWmcIweu4tzKtZOTe8yUlfPTw
	c39yAOhNbCs+542QCMR8tofdNwo1VM0DgK26QjtCwHpxkTamj1+hKwtMDJqSFhv44VTd9CpIFOG
	U5m/exoa5JvlzyuEUEcj91dfkqH2DhVkrPwYBA5eaG7jnbs/qw5k/S4ThJeQfhUiBiR/tUrF1HV
	eu6iQuSQtZLnTUqEOri/orGLw6PZ6fis2XQ5rMA8PL1g7v/3EMOQ7ZsohjFxFn5x7dIYstyxSoA
	7uSukfpGfdqQ4GHwg+VzoQVkKyhzSsVLmK1+meYj4i2DPChj8Qa+h4L8zK7fPSPwOVGlOAd6wIa
	TiA2wAcFP1HM2WUHDfTEYNJ/DCl7X1bUF877f25LQ4M2fPupXsyZqBGeP8ESeF13v/vWRCCLHGj
	pR6sA+gLavX/ana8fxP7vHLILyg
X-Received: by 2002:a05:6a21:391:b0:3c3:8044:8b0d with SMTP id adf61e73a8af0-3cb85e2b60cmr15315703637.12.1785995066874;
        Wed, 05 Aug 2026 22:44:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d081:36b2:965:e66f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca908068sm20185951c88.12.2026.08.05.22.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:44:26 -0700 (PDT)
Date: Wed, 5 Aug 2026 22:44:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - fix GPF in suspend and resume when
 unbound
Message-ID: <anQe8UiyUR4x0flD@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Transport drivers (such as rmi_i2c and rmi_spi) invoke
rmi_driver_suspend() and rmi_driver_resume() on their child rmi_dev
device during system power management events. However, transport drivers
are fully registered and operational even if the physical RMI driver
failed to bind or probe the rmi_dev device.

When rmi_driver_suspend() or rmi_driver_resume() is called on an unbound
rmi_dev, dev_get_drvdata() returns NULL. Calling rmi_disable_irq() or
rmi_enable_irq() without driver data attached causes a NULL pointer
dereference and General Protection Fault when attempting to lock
data->enabled_mutex.

Fix this by checking if driver data is attached to rmi_dev in
rmi_driver_suspend() and rmi_driver_resume(), exiting early if
no driver data is present.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Reported-by: syzbot+09103639e39c989e3ed3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09103639e39c989e3ed3
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..a349dfd17519 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -991,6 +991,15 @@ int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake)
 {
 	int retval;
 
+	/*
+	 * Transport driver will try to suspend RMI device even if physical
+	 * driver did not bind to the RMI device, because transport device
+	 * (I2C, SPI) is fully registered and operational. Exit early if
+	 * there is no driver data attached to the RMI device.
+	 */
+	if (!dev_get_drvdata(&rmi_dev->dev))
+		return 0;
+
 	retval = rmi_suspend_functions(rmi_dev);
 	if (retval)
 		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
@@ -1005,6 +1014,10 @@ int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake)
 {
 	int retval;
 
+	/* Skip if not fully bound to RMI driver */
+	if (!dev_get_drvdata(&rmi_dev->dev))
+		return 0;
+
 	rmi_enable_irq(rmi_dev, clear_wake);
 
 	retval = rmi_resume_functions(rmi_dev);
-- 
2.55.0.679.g6767b8d81c-goog


-- 
Dmitry
