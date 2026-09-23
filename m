Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA449E12F
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161668; cv=none; b=uscH0bcbsWiMXowV2qBWX96YduGNt++ifk72RMd+j2I8U2qzm9BAFv6VVib4mikUjQFoHxE7FmERcGPrYaTS/QewhgJukYEb3tEvhKzCB9LUnG3eoJXuR/CjLkKzgkgWkT9gmIWpaCUIeqFBTfWA5LnL+OsuXOj873ClzjxrRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161668; c=relaxed/simple;
	bh=Lp05HvS7MlHdv0hfaKJnvCR0qiPp//Pn4+6+M3Ynev4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fW4US2uL8eqwyGfZrmA2+qGGuGXBLFeWsZ6vQbNb0ddC5zU74+1YFHeuywFL+6E3uJIvWTjfzL5ISXRXmlUH88X+ZUM5LkLNSfB72ruTx6pb65kDJNybMSGQsbwlLdbLGyfRn0HelvGxXBQiB+JA/AZRuCAMn0jXwBKQoHLX3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5Z1J+lX; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5Z1J+lX"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49c068e85so5503531fa.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790161665; x=1790766465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z7/IdbLY9gftiE1cMDmaoR65MCls8WYbgHoLCd/1QnA=;
        b=k5Z1J+lXTdRn5BsLxIkXl/BhOKMJ45MybcOOE7/LuhKk62SpHgYemMRYyM8U4quEsn
         FROQTaKPk7/cPkSgCKtgqOUxtOjXEYZu5HsuR0mfAaVDPHwsmF3ATTRRc0qz3s2M7vbe
         shN/C5/J3Dz2x0UE/A9BwwuCX3cC1FoS/mYXjHr7YIEvCf/k+3WxDYpEcrwjFZkIOcFE
         hTfFb5DWdgIgxRoYM96xy5YvU1aJ/300IbqzL8STYeQzlgtiEWP74XadQnB2HxPNopqv
         /R2VSVZnd8iKa4wE9rEnRkYDBe5h4axqjFqx9qNHrjIy97vqAVg5cki0qLV55vzKnvXZ
         xJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161665; x=1790766465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7/IdbLY9gftiE1cMDmaoR65MCls8WYbgHoLCd/1QnA=;
        b=z+jLGRImwEfVzxPoQb019r2yFMkCwM0JwrNOFpjlEHAWqtgJRtLwDCnRGBFiw6ZsQm
         fC3IfzaY/zM35C4MdAZHt4kBxwaHps/DL9UuDFMs6XaDJ1leIT9O5QyR/nuAbNBSHTgF
         cw+cGEq4mMP5w8IVbleRQaZdQmGHfXuA4O8QcTYXWW6GniOhU+cCLHJO/dU4tbIuw1aq
         j1cO8Ycoz4apoue5ozvuxsLx3zUG6LaD2Re5iwn0iFJx4Khr/4DiKTvh1fPZwOB/Bb6j
         p9jkJATRkdaZx9hR4KMWVUsd9xZ6WK7alSaNq5nGbZ3CTVhVHaV+hIvkcEbyA25a6GZo
         qGIQ==
X-Gm-Message-State: AFuF++nzjgtyqw3S4B/8N86zJjC9fu54U2IJfmE7AkVEoOJ/phhk+gyZ
	WuA1DhiHjbkiVGBwLUMPcgqgEbLJNC51MZXW5UhlfnGADZH/ropIFj5/K5MgA5gWkdnrfg==
X-Gm-Gg: AYBFou3k9ln8oUki+LX3pzP8UjA2U+NR5wY4F02a5JDe0IhPFuwtLuIlqYBUDf+LxYf
	T2+tK0YB33h8S0EfEmhnGwGAsGseZFK1DzqNQIAB0MEoy4kqbOz3A1dlJsJYg2yYlDT2qKlz6S4
	O7acME1VuElIJ4rPwhga/Xbi7J2PGycILfPa5LJRpITvRxEZZrfsdiLDSQlAHWgNPvwcQk/cz9V
	MccQZAPtq8EGa1FpOvwOB9s0htGvAWwn7/jsOj4UEwo4ngGTJqPsLKdNQNyqF6zPIXBethSI/rz
	XwCR4L5YIor5RIBnqxokHf5MhsVTslxeym9lCmoXY+Ds/n+WE+8llvpCt4f4ZLDaja+k2lZfr58
	dEHbEyzdSdWXrF2M2f3jAAR3GsXJ2xNgeXkObH6lOcJN0JzcXvYhbyVnjWWpfVzUsEM/HVIEWs1
	lcxQADljgG7f5X7bhH5NfglYLHYpYL6FRcSoTQdE3RXPZ674myf+4tM6dn/Ki2y0dmpWU10h+zb
	fckf1u0v+9yeqRxjo4EzyOTN8hipzvxAfbkEdX0
X-Received: by 2002:a2e:bea8:0:b0:3a5:b1f7:a7bf with SMTP id 38308e7fff4ca-3a63063d280mr5098451fa.21.1790161664609;
        Wed, 23 Sep 2026 04:07:44 -0700 (PDT)
Received: from DESKTOP-7GRJKK0 ([188.226.104.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a62f5285b0sm6063071fa.35.2026.09.23.04.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:07:44 -0700 (PDT)
From: Vladimir <anykey196@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2] Input: axp20x-pek - add AXP313a support
Date: Wed, 23 Sep 2026 16:07:41 +0500
Message-ID: <20260923110741.1880-1-anykey196@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AXP313a MFD driver registers its power button cell as "axp313a-pek",
but the axp20x-pek platform id table only matches "axp20x-pek" and
"axp221-pek".  The power button therefore never probes on boards using the
AXP313a PMIC (e.g. the OrangePi Zero 2W).

Add the missing id table entry.  Unlike the other variants the AXP313a has
no PEK key/startup/shutdown registers - AXP20X_PEK_KEY (0x36) lies beyond
its register map (max_register = AXP313A_IRQ_STATE, 0x21) - so give it its
own axp20x_info without start-up/shutdown times and hide the corresponding
sysfs attributes, instead of exposing files that always fail with -EIO.

Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a), kernel 7.1.13.

Signed-off-by: Vladimir <anykey196@gmail.com>
---
 drivers/input/misc/axp20x-pek.c | 39 ++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d893d..b912f13b607 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -85,6 +85,16 @@ static const struct axp20x_info axp221_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+static const struct axp20x_info axp313a_info = {
+	/*
+	 * The AXP313a has no PEK key/startup/shutdown registers: AXP20X_PEK_KEY
+	 * (0x36) lies beyond the end of its register map (max_register =
+	 * AXP313A_IRQ_STATE, 0x21).  Leaving startup_time/shutdown_time unset
+	 * keeps the matching sysfs attributes from being created, so they
+	 * cannot fail with -EIO.
+	 */
+};
+
 static ssize_t axp20x_show_attr(struct device *dev,
 				const struct axp20x_time *time,
 				unsigned int mask, char *buf)
@@ -188,12 +198,35 @@ static DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup,
 static DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
 		   axp20x_store_attr_shutdown);
 
+static umode_t axp20x_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	if (attr == &dev_attr_startup.attr && !axp20x_pek->info->startup_time)
+		return 0;
+	if (attr == &dev_attr_shutdown.attr && !axp20x_pek->info->shutdown_time)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *axp20x_attrs[] = {
 	&dev_attr_startup.attr,
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(axp20x);
+
+static const struct attribute_group axp20x_group = {
+	.attrs = axp20x_attrs,
+	.is_visible = axp20x_attr_is_visible,
+};
+
+static const struct attribute_group *axp20x_groups[] = {
+	&axp20x_group,
+	NULL,
+};
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -393,6 +426,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp313a_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
-- 
2.55.0.windows.3

