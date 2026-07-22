Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE4430781
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751431; cv=none; b=nMJqnC6ueghlYNotsvTLvar2mo0ea3hTA9ANozFrA5KWKsB4kBzdNSXfQFhiYmGGxtQgT5ikbZzSTXNnVA/W1r/1EG4K4ISKoYFfgjGvD9bROZVaTdBgZhfJVOoQdj1LigdY4OLduN4998jHx1+Gkak0uQYITXRZ4MviZNzQQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751431; c=relaxed/simple;
	bh=actw4T9fTpSGGTTYUwiLZyBOk9cwJel/ZOVeKk+BS08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or3TToBmYS1i9N/InBdV2DWbcdigIcvwMvb82C7CVYm94UjFKvGpBKxtTyZfgLHy/EIFXT1b02i9WiQ1u2ySOfuSOBzORXAnC9IQW0YwvlgRFdSr/k74iPcSfjoZxsu8TbUvFSorcaHzwRXPRRuOjX6jMrM9/tPYgGZxW7k5E7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8yMaeTe; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8yMaeTe"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so75352056d6.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784751429; x=1785356229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ye3eMu6vu5RBUSzIcLpzipwJNEqmUBEyQ4TiICAypL8=;
        b=J8yMaeTedsUVyZnLGUVH2QQ8ILXrg9zO/Fky288FkgwusvS31s0gzMCWOc1OrfixDl
         eRqpxPkVWmmZ7fjR7L0b0mkkxF02/P/uRVMNMy26l1hy8xFDXJOJ6VH38FAJyG/teVXs
         8ktIk3r3HCTjUw2hTHEhDGquAhtawLTshPcRYHlJJGlay+wdqs46qMdE20qDxfb+5TEr
         /3zelunkAfOl1SSBROhvhiJDqeMDQBfQB1Ua1bn6morvjYJoBlm/3IR7XP0bhppoycUW
         chiA4MLlraVW6gn4pBARfaHj9nlBnhxNrzuLBvBFWId/DjthdGnFH3Lp3dczbbC2EItO
         6YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784751429; x=1785356229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ye3eMu6vu5RBUSzIcLpzipwJNEqmUBEyQ4TiICAypL8=;
        b=YxX4VI3SDer++zWg+3aUpCoXIbATlGk6ol9ekUpVLn8sPZdrlemdNL6EM8754hjbpj
         yPv55MhMJX4nSiXTznqhyjVId1D9yVd6ldpJq7p1nPOrYkqTRxMvWAP3E9OtnY7yhFym
         2R/BTspqwH+6qwrYsRCwqb9V9jujGrJV9A4upKEuf7H6yFt7UJsHlaadphkOCk+iYPsg
         L72B9jk2ctVTne1EycELccJZEnWR/HRHi0R2MGWyrPBkbm5YSvEuUPJC2FXZ+uBJ3fj9
         cHQK1lq190rhiaoiwHpuqhkc99ZSjKAXB4diUwLKv83RFdbMIh4DlOUq4bDBe7aKRV52
         9vFw==
X-Forwarded-Encrypted: i=1; AHgh+Rr98PVY8wGZWffE5dJd/5jB2tIeR5tYyFW9LB6zjHemidG92NqxIKGSeuxiNZSF2kRhVFDJBuiz5xstBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhAeRxzLG0R9eZRY8/U7f2DMnZlCXgttWPNPZoUpLE9zz5Cyuv
	yKUwtHG8kQSjqgA6xpXih8P0EfgnOTn+zBNxsvFxK+zjjcDCMkNQuT9m
X-Gm-Gg: AR+sD11v/02k/x+Itq0n7Fmn1+55PJ9Ukv3ffE8BQUMlJqrlCzKKlBtZgGxKGDMRpmA
	0kbN2dO4KTrXa8bek7wVEyptTmi7JVv97//U085aYtgSpPVmmHewy0CWAEKOBP/OJwdLJliYC4N
	KHwFZ9Z1q+BZCewDZ6K20QSJZVOFL9jBrMg5XiqjBhUuGE98/CKI6uQny5HIA4MhUc4aclAS884
	DTcTjIPL5hCmvesFP5gr3xfV3HoSOATDnPj76vbB+/UH6aMj1D927HVcIra9N0IiCwM8Z3ZYRcS
	TfAgpIrTfpfc+kiJ+wNSALNVpCYQROqAaJXkjBUjgjzGQh3qRSzgObccLt9Tx1A0PKk/4eHqN88
	nEG+hnyMf00qofvwouTA0NScprx6dgSJop/oPPsj73nBXjVybPLV2CnvfXzVJTQ9t54loPIDz9d
	nKswO9WgvE2ht6Za0gcvFO
X-Received: by 2002:a05:6214:5a0b:b0:8dd:2260:70df with SMTP id 6a1803df08f44-907b9b151b8mr72163156d6.6.1784751428808;
        Wed, 22 Jul 2026 13:17:08 -0700 (PDT)
Received: from fedora ([2600:383:440:3e74:66f4:dee9:6d5b:1526])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b7494sm28767506d6.8.2026.07.22.13.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:17:08 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	W_Armin@gmx.de,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v14 1/2] platform/x86/lenovo: lenovo-ymc: Suppress probe on Yoga Book 9 14IAH10
Date: Wed, 22 Jul 2026 16:16:58 -0400
Message-ID: <20260722201659.874469-2-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722201659.874469-1-carvsdriver@gmail.com>
References: <20260722201659.874469-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Yoga Book 9 14IAH10 (DMI product name "83KJ") has a dedicated
yb9-kbdock WMI driver that registers an input device reporting
SW_TABLET_MODE to track the detachable Bluetooth keyboard.

lenovo-ymc also loads on this machine and creates an input node with the
SW_TABLET_MODE capability bit set.  For input switches, the presence of
the capability bit has semantic meaning: userspace (e.g. GNOME) reads
the switch state at startup from every node advertising the capability
and does not expect more than one such node.

Add a DMI match for the Yoga Book 9 14IAH10 to probe() so that
lenovo-ymc returns -ENODEV on this hardware, leaving yb9-kbdock as the
sole SW_TABLET_MODE source.  The ymc_ec_trigger EC write, the only
other action taken in response to a YMC event, is guarded by a separate
DMI table that excludes this machine; no other functionality is affected.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
---
 drivers/platform/x86/lenovo/ymc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/x86/lenovo/ymc.c b/drivers/platform/x86/lenovo/ymc.c
index 470d53e3c9d2..a13c89dcb285 100644
--- a/drivers/platform/x86/lenovo/ymc.c
+++ b/drivers/platform/x86/lenovo/ymc.c
@@ -24,6 +24,22 @@ static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
 
+static const struct dmi_system_id lenovo_ymc_nosupport_dmi_table[] = {
+	{
+		/*
+		 * Yoga Book 9 14IAH10: SW_TABLET_MODE is reported by the
+		 * yb9-kbdock driver.  Suppress lenovo-ymc on this machine to
+		 * avoid userspace seeing two input nodes that both advertise
+		 * the SW_TABLET_MODE capability.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83KJ"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 	{
 		.matches = {
@@ -101,6 +117,9 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	struct input_dev *input_dev;
 	int err;
 
+	if (dmi_check_system(lenovo_ymc_nosupport_dmi_table))
+		return -ENODEV;
+
 	if (!dmi_check_system(allowed_chasis_types_dmi_table)) {
 		if (force)
 			dev_info(&wdev->dev, "Force loading Lenovo YMC support\n");
-- 
2.55.0

