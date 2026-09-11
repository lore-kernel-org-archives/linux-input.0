Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430C470453
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151095; cv=none; b=ANxdpO3CKKZzfB6mV020epQFRHLPC71/jZj5A377+fEyZwS+Ccpt44eqW0kX6tCiIENnpjdMCVANGny90vmnbum/Ex9SUzipl9a0M1N+ncUokW1Jo+TgCs1lFj6bLdV6Q1vc/OmdyeqOi560JNC1QZS9Lh5Dbm1WseqbsTVJB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151095; c=relaxed/simple;
	bh=1LM1njdi12j0PGJlFDlq2HtxK5cpMY8FwY19TyBMIj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPWQLQ0VAbEhJGc9yQjPh4Y3lWwNLHtKs7FHi+7lratpjeLkkivsR7jTMUm6j+xR5RhTHZUw3BpVjGtEhsWUD/3DcLCsq15ZF3jnKs5LfvXkeLsy7oaEF6ozslrH04fFcq0Nid1W8y26CPRQ7+sp0VJAftxzOtCyWXUFPSPvQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRNuRvEI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRNuRvEI"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-485850cf499so995351f8f.3
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789151091; x=1789755891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=54zB5CgKeOfrsrOhVVVkcG2Pd6Kk/5fQ65j8geodZKE=;
        b=GRNuRvEIQBVhGQvZGXroLC9MiHjbDInW2prMHl1jbc8BakQUl0ypf2JW85vdPOmfHS
         FbhPJTkeDST+emR0wZYREGpEFV4of5g2D3lYSyB0AwuWBOAVxb0LqMHsMr8iiGHC3dGC
         40tD2/Mbf/fQ+7ZMWJ/SCKpFkDB5laEVOFLjcXyqU5Vl3NPiYvBrwVN0DrNr0IUv+9vL
         kp+MBVNpqhdj1py3FpEr7BbgyKyaWleqlvHaJ3fpCGCnZQxQpftxna4bdA3x0rKriNl2
         5qvvk7YxtLiM6Z3IR+tWFx2u5iETzhbzjufTrR2CmMu36JCrwSXt6HO1M48hG7lkqiyb
         8Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151091; x=1789755891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54zB5CgKeOfrsrOhVVVkcG2Pd6Kk/5fQ65j8geodZKE=;
        b=NhWrCEFK/6cwOTLFImUVpvNhsg8/FJGInRv6TE7O5nChQ9599TkZpiXHOnF8UI7qWx
         AoXBJ1YpPM2dO6j9C9G9laqqVtYqdcb/Dw6mn4xlHmd+PXTGIcIOufMayHyC94p4xZ6N
         w4a/lKSRsXzP7Mdo4Pz+XJ9PpCNxFtUltPvtvUBYaawMon/S4dSzFMMUrrtPLRmhEpBu
         ymllEQUvLvUdM2D0gLLY0X9YG8rojb6m8zg0YuuY4ZU5M7NnELK7/Xu5iMQEeaffyQZw
         YEpl8hYtTJz8zuQ+28CYdd1AdpkhoxzmsbnhOalb+aV6CX19LgaktD0MVQylziFaS8aX
         zmUQ==
X-Gm-Message-State: AFuF++mHnGXu6BJQmmWOyIGQqaekaS76gd8uJSnMf+edXhgYY6wQYfwT
	MBVF2AZ92kWjlW4y9MkodO7yhQOv7W1Z0+qE7gJDLFsv5xicRoEh8VABD7ckytmzGtM=
X-Gm-Gg: AYBFou0VPA6SxcK4dXr7bMtnOBqj5Jjh8Y/G3pOCEpSWwoXbOyBMAzCNGN9B3qlnEjF
	nuoRDVU+XPyQYeQ1pDwLoLMetcgCHPpRi891UYAkuWC7dMMSqgmrAMpFECw3jSeRVN0ZKAFudn2
	nKesd+qLWxbbe7jJtRfPs8eMkrrwV2u2UeXuZwLHOlMoEfkFK5q1Fz7qkaKiudQrUqVVsc0cHYG
	/x0qO/fY3T1sgbLHVmPx7V2+FnkjWfBoe9Q0e8kGwa6ihVZKJNbNlzAae9O+Ytt7aon1FteJ+v4
	4kzGkUIgVVpA+PlQeSbK3oVWq0NNDa4BZ0owHP+4Li7ahbK/cC3DT5eTgMYR5Fi9bsJ4IXs3YUZ
	jijSdmQDxHwVEF8UtL7hrHMgRSGPt3XKzlXy7cxMHA05FBLGEQXyy3PIVcAWbcpdBM/YcwJLT3M
	qrZvIQvVgDSVK7I0JJHlAfGgcttjFyw0B4IbwaDrAVhcaR1sOZVZ+0oXs8XuI4dnHUiLpg3imuC
	Cs8Y0zg5bJW0rtJbSI8oXTqetY=
X-Received: by 2002:a5d:59a5:0:b0:486:f4cc:408e with SMTP id ffacd0b85a97d-486f4cc40bemr1428270f8f.22.1789151091444;
        Fri, 11 Sep 2026 11:24:51 -0700 (PDT)
Received: from fedora.lab.notiustin.com ([2a02:2f07:7211:b100:4ff4:568d:f2c6:5ab5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm7810131f8f.20.2026.09.11.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:24:51 -0700 (PDT)
From: Iustin Ivan <iustinivan2002@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Iustin Ivan <iustinivan2002@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 14IWC11
Date: Fri, 11 Sep 2026 21:23:28 +0300
Message-ID: <20260911182328.9267-1-iustinivan2002@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal keyboard on the Lenovo IdeaPad Slim 3 14IWC11 (83RQ) does
not work after boot. The keyboard ACKs every command during probe,
including ATKBD_CMD_ENABLE, but never sends any scancodes afterwards.
Booting with 'i8042.dumbkbd=1' makes it work at the cost of the
CapsLock LED. Adding the atkbd_deactivate_fixup quirk fixes the
keyboard and the LED natively.

DMI: LENOVO 83RQ/LNVNB161216, BIOS U2CN19WW 03/30/2026

Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Cc: stable@vger.kernel.org
Signed-off-by: Iustin Ivan <iustinivan2002@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index b9ad2381f885..923f77808381 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 14IWC11 (83RQ) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83RQ"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-- 
2.55.0

