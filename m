Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825883839AA
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872607; cv=none; b=StL8OgGs6WRc2FZvCVKj+drsDfb2NjKZ6Y1ITZs6GBrw8T9sm2X+2Vu/hOcr41Qjban9OWW0F1/q8R2nQUJ7nMI5FFZiYUBRgzuwlVBAET7svBYh3/QyR1YIOdtIpFNCu2yQNVZUxUQ9VRQCEX6CH/6eMdq8FhL1Juig20B10/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872607; c=relaxed/simple;
	bh=oCddYuoTsYPPcLkUBXWxx1kKdBtdMsF20eD0FytAAIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWI59rezbIMQxDeoS8FXgPfA/Go71RBv15MZ2GYHWy0Zme98uVng67LhNX8OgEfnu/50IuL5C0IBPnX0cT2BLrTt2bOhyzVaCWNjmtIKREXs35huZ9z/kbHNUSiW1vomD2pwkrzyl8Sd2CSVjut3QkBFNViGRBFbsBYY/tKGHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp3ISGIo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp3ISGIo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b9320423cso1431065e9.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787872604; x=1788477404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgM2YmzxkKBqGF8ip3+p7pPQCfGLs74Br2HySqIdTbo=;
        b=Cp3ISGIowMc3mS8puCjdTXWG1dO+PDppSzQwUnallrrEOmu8i0LA68W0NV7KY6Shib
         2pyIYyGnSseTHGpA+MoAahKsslNEeTtkJZzF1qJZOfh1Mvb5JndrgHJu3Gw0m09DtNci
         GcCaXDhaVKgFaUOuqHHpObOKVPthlIjOEgjJAPq4VRTheQCwHYFb9WzXnnUwkVYUmSZb
         n/892VV7S5FtqHZPHMW0JyPXcH54YlLehQI3qw2z3kifEsXYZDIc3TiSZNyi/LG1ED+E
         V2Z5GGWrcEYCNjBX4ZckL/Nkit9drK/etY7dX9TKLN+PmVMEuD7t+rs1OVpZlfnXu8R9
         WqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872604; x=1788477404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KgM2YmzxkKBqGF8ip3+p7pPQCfGLs74Br2HySqIdTbo=;
        b=S841Td028WECPSM7Ka4QYLK4Ou3fFydqM3wRjmd2FrT9w5DvMeNv9W2wXA7LZR0ci4
         NrRC5mdYwiA6nS6b2ndqjZqmPgagQyIGEepGqnt7i9543mTEMk7JML2jK73WG69JIaWC
         LIIi1NR3ahG0zIjKj/9n64+Bd7p6FFDh3gOsUE0Jtfps5DGkhQJTCLtAN66bu3AlT6rp
         nTuO7e9EpJPqC4UNXsNP/5Inr56RfSaXbRB3I9+P0jgaek1H/g2srqdsTu2T8iutnZp9
         8BGyW2LmoBBHOmcR4C6Iz+n71M0xwPHDOOK1xg8IJbrzp/zNr0wHLEPP/ph9GpIzxVRo
         8IVg==
X-Gm-Message-State: AFuF++kJd3udmcgQOHZ+b8+6TNmg3We1O+XEd9F/9bZ4qshpmCR2b1t0
	eycsdIF7Y+dDg0TvWF+CZ0+qpUCMIjCqMFYUmOjaSQVLNUe9mH0IJ5QHW4XKDBOj
X-Gm-Gg: AR+sD10Y8Ho7HpmQqKJktu+HLiyf91ZGDm9NG8F0wP+bZ6s6PwC+2BNXs0E+yAkFPQT
	PAqgFCLFYAjZGiiBYZHoGLGOd9S5gbp82VollIFI+aoSz1KNwjtDdK6CyIIhRZujWrmQNEqub+Y
	58lKxRZH5G6FtGV5H4/Tx0Wo099b56xRwingAiZ1txg8sQLyPmv5RL6KhpoVybpgQB77k/J7WkM
	Za9Eyv7MRbhqc0kJ/T2liR6UcAgLB449w6XiOYuqFakL3rdilQ3KTv0mdluh7LbBasaPyCNaNoJ
	xe82E+4qwZU7HTh7f1PV4lXzCYMH/5Y+PDrkOWJIKPiZjvIlVDV6a7ReQqJCv7MxvjRODK8hxd0
	7ALCWFoAdMbDdvPVVdonnDcF70uMmu8ZABFgpkQOA3RA+WdSgMZEwcXrloGYH2YE15sWaDvCrNz
	moYJ42euYQNsIssMYpZz24W2d7psZccgFcWCy/nuOlFF3gFIeE8KQOrymdi8hbsfWKEzMRQ3TXH
	DliDxzZQLsP1znuTJzeob/+xAwjxW2YxYAH2BnxAFAGNO3JYCHqVg8=
X-Received: by 2002:a05:600c:4f86:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-49b91c4faa6mr27292105e9.12.1787872603783;
        Thu, 27 Aug 2026 16:16:43 -0700 (PDT)
Received: from 1Z10 ([78.213.170.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9269f1b6sm9835725e9.4.2026.08.27.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:16:42 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/2] Input: drv260x: Restore configuration after device close
Date: Fri, 28 Aug 2026 01:16:36 +0200
Message-ID: <684969b0f53a9e5f83636b219c139e904e74e14f.1787872237.git.mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com>
References: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enable GPIO resets volatile device registers when it is lowered. The
input close callback lowers that GPIO, but the next open currently starts
playback without restoring the actuator configuration.

Raise the enable GPIO, observe the startup delay and reinitialize the
controller when the input device is opened. Keep the configured actuator
mode unchanged during playback so later initialization follows the mode
selected by firmware.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260827182855.DE8E91F000E9@smtp.kernel.org/
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
 drivers/input/misc/drv260x.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..f26a9052edd2 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -243,8 +243,6 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
 {
 	struct drv260x_data *haptics = input_get_drvdata(input);
 
-	haptics->mode = DRV260X_LRA_NO_CAL_MODE;
-
 	/* Scale u16 magnitude into u8 register value */
 	if (effect->u.rumble.strong_magnitude > 0)
 		haptics->magnitude = effect->u.rumble.strong_magnitude >> 8;
@@ -426,6 +424,21 @@ static int drv260x_init(struct drv260x_data *haptics)
 	return 0;
 }
 
+static int drv260x_open(struct input_dev *input)
+{
+	struct drv260x_data *haptics = input_get_drvdata(input);
+	int error;
+
+	gpiod_set_value(haptics->enable_gpio, 1);
+	usleep_range(250, 500);
+
+	error = drv260x_init(haptics);
+	if (error)
+		gpiod_set_value(haptics->enable_gpio, 0);
+
+	return error;
+}
+
 static const struct regmap_config drv260x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -528,6 +541,7 @@ static int drv260x_probe(struct i2c_client *client)
 	}
 
 	haptics->input_dev->name = "drv260x:haptics";
+	haptics->input_dev->open = drv260x_open;
 	haptics->input_dev->close = drv260x_close;
 	input_set_drvdata(haptics->input_dev, haptics);
 	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
-- 
2.53.0

