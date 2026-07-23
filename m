Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514D483823
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832412; cv=none; b=RVQaggtBmeTLU9OZt4pS9grjmqoCkDgsUjMWpvMzbD/z9f4wmMiflkzByUca0FynEEfePJq152Gtc6UBGxTAPO3t9E86u3K4o3H89uGaWBZQz364CclWOISY7ZIyLf4P++gnGVnvREyJElUmoHDPJ5t7BXDDWJMQKog3aw5FdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832412; c=relaxed/simple;
	bh=OjuU5sZNyEfe3NY/W693mYnbMjjdy0/PtxQZI/XdJ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhGsB2BRY/RR2h5r6nCo8vkTf1SB++E5SYbTcbF437dv+L/AYu9ZqmFTRI8j2QDV614l0KyeMnPu782APQvvgBkCuQQcx2nUjDizBp/MOyGFhoV2y+oXxG0tl4pyhRGwMxpATeMLInOH9LKMLD0Jf8kMCzLyS3hp19vel8oc+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfn2gqhm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfn2gqhm"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e88b60121so792955a91.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 11:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832402; x=1785437202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZyPlyAUxTK8Vz/tunABGXVD0bibLKDl8Em93+X7p/Y=;
        b=bfn2gqhm/GGnWxwuwqByRgdWQ0oGWL0dfEhGLe402t2Jkrd9xl72xo+UF8IscgxRYt
         6oWbdXnUXmPJ2/wFW/wY9A4BBfMoBjLM41qpesvBg/6mWmSYRjmNVfopYWGk24biU+Mw
         Udu+DYkgMSye513XyNhElHr80sydkVL2DSGlQoU4/L74CKZE66Sej7Sx02+sqIwqnWLM
         EPCe8YuDgW3A/JKWk57YFHWsRnl01mVcHYlrZUnOTLZScDacRf2WTqH81fgeQj5b2L/V
         uadHYEu0zmDXmMatqWWSKjwjTWsjpQsMk7LSFTQm273w6bY2C3qfrE4c54kb/5CjRwSm
         kyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832402; x=1785437202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZyPlyAUxTK8Vz/tunABGXVD0bibLKDl8Em93+X7p/Y=;
        b=ZlI3gay6i7msgyf4qfNcTfwbYgvZ7AHJvqs/h83E+WpWAeNSe2NLcxamX6V2/i2XwL
         CpfR0BCg7++EwNiv+mfKnDyHZQ6wM2urt0h7CdfgsAxcRTrafRlDABrFirvEh70r64k+
         n37HyL1AjaA6reO58Nwc/r2gRE9mw745LhzSvyFDJd6i5tohlIEcvwbLC7+6xdVNAfMn
         aPDxTqNFXf7RwKoa+PaysLkdbK/6gYKOntMLyXFaxOjipLe7DYCL/sFBQWCMp/0joazs
         aPgj2n3xXjY0Q/rVdB7NBLtuivpR4nmVAqky/fVrWyyZ8ainVE3irKWanBvg47JpQI/L
         Hrsw==
X-Forwarded-Encrypted: i=1; AHgh+RrG4aCnf2K51/y5GnSKQgswY4Rp8AHA6R+DrDzuVQCp6lCNMXTKgvpb2kcCIYtKbdoLJBxwwPvI/rIs2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/SaKyuQTZSJWrvnWh0H6WnkDDlriF8vK690wXEprbiQh+CzG
	lWTWQI/wsd8dq5kVh4hxX/X/VwSwPI6H+CyrZKVGT1RPYcByadsSKbWL
X-Gm-Gg: AR+sD13gi9SnDJuJz7KmTx8HgcHIA2paDFVcVa5tXpGGutGPSaPc7fdlDOZsxUskO3n
	GbWRqH947LX2JoZRpJQ9Np1OL4WOVEBx3kIMlJ3gfupicPbdO4127oLxIXqwUYlmGj1HnlPh8oK
	Hm06OoyNNRYl9Foyw/ibccq4axfiZHQAQ+Pi9H0YiNhDtVt+Nrjyk9BF7UZko2McqGXwqpzLfNn
	DVsfAK1Rn2lKTPXZC82P68/bTg8TdbZqwqwtSBVKCsWMoj90387diQeVSkYzWhKvyHgR4NfKyXc
	Sp+3t7DXGxvg4Z0Nb+qLmLiWCZavv9aL366ZG+1uVw9lMysWST4nLGSW8Co1RLl6iFKd843DdgH
	x4ZlxQ+1xpPtLz2NzExEMIjiZiB3L4irqaKQIIVO/NZP7ycMIqk+F9zMyhIdFTbXFUKCqSTOj
X-Received: by 2002:a17:90b:1847:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-38ec642bd8dmr4696955a91.14.1784832401698;
        Thu, 23 Jul 2026 11:46:41 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:41 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: cocci@inria.fr,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/36] Input: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:18 +0900
Message-ID: <20260723184538.3888637-17-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 8 +-------
 drivers/input/mouse/synaptics_i2c.c      | 6 +-----
 drivers/input/rmi4/rmi_smbus.c           | 7 +------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 35d1aa2a22a5..c916e80e2f58 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -462,15 +462,9 @@ static int pmic8xxx_kp_enable(struct pmic8xxx_kp *kp)
 
 static int pmic8xxx_kp_disable(struct pmic8xxx_kp *kp)
 {
-	int rc;
-
 	kp->ctrl_reg &= ~KEYP_CTRL_KEYP_EN;
 
-	rc = regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
-	if (rc < 0)
-		return rc;
-
-	return rc;
+	return regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
 }
 
 static int pmic8xxx_kp_open(struct input_dev *dev)
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index d4cf982f1263..85e37e2ce45b 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -257,11 +257,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
 	if (error)
 		return error;
 
-	error = i2c_smbus_write_byte_data(client, reg & 0xff, val);
-	if (error)
-		return error;
-
-	return error;
+	return i2c_smbus_write_byte_data(client, reg & 0xff, val);
 }
 
 static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 6de68c602558..3160714a514a 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev *xport,
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
-	int retval;
 
-	retval = i2c_smbus_read_block_data(client, commandcode, buf);
-	if (retval < 0)
-		return retval;
-
-	return retval;
+	return i2c_smbus_read_block_data(client, commandcode, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,
-- 
2.43.0

