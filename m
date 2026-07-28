Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B73BBFB4
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279354; cv=none; b=mMV8LUv0qCaBuO61swF/D1dj/yDkc4WiRjp8f6XG+CvYKvidA/2ZqWN+kJ92KbN/3T6RsoeL3gzndjWtjb/xhxLwMfafpmwjDFNloxDfttNOrs4PjuXJtvpF07eHdt6+mP+obBtTkG8wh8HD1TUXnOliWFgVCdhAfXDinZsJ9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279354; c=relaxed/simple;
	bh=8QDTGea8YD5fzdTqveHssulvg3hImMkLzrmbzptehnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmLzIqHUVusDZhSIhzCA3maR/N/ehTEkqD7zLBA4aBtv3UZJdX0lTCtYrXUh+NoEW3r5wZ+sXc5KfGDpuASPKlqaAwFPG03LlHvR+RHLX5Edi9U8TkHsRr5Bli6SkU4JHoNa45oqtuQJoMNLOark4M+8gT26LQbcJqn39lrfcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPawdzmh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPawdzmh"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c4436d02cso2136031cf.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 15:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279352; x=1785884152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ye3eMu6vu5RBUSzIcLpzipwJNEqmUBEyQ4TiICAypL8=;
        b=nPawdzmhrFq7TRmUHRZwxbmV73cHRqgtYnaO7Le9pCtX/C5a07PxJthvC8wvKUCMuI
         jnd5bXKv37RU2jVSMmoPE5fg2S1aCwwAfGUOlc9aZ3GXNn6A5BOb8SrjD4GhnZtMoaD+
         WNxzx6lnsspQV8vWWTq70Nfhr0s5lmUX5LjD2T2l1FhZpDGUCHTqERIq0EguSZp4wRVH
         hSsP+mU5x5KxYi0BF+PMf9uA5ZF0+ZBWiMfsv0rcg2R68nvLWyPF2H4ZFpKsDbVjx09S
         cR9+8rLINrWwdTYZQgVVDaKyYVKU7g1kkLBOf6R2zwjRWCYrXar/hg3+XI+0pIf2ngka
         Q2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279352; x=1785884152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ye3eMu6vu5RBUSzIcLpzipwJNEqmUBEyQ4TiICAypL8=;
        b=f0w3xwdqebMkqFe9FJ630fPEKBioERLSVbjiNfE/NvtulzdVTGF78HwfDR5hXJAmMe
         RkkVddWTsT0SFAgpDFmhGw79o8onhYThQ1sUNLCm883C4bkIP+oSiHvtVypjvDRJdNXI
         GA1XuoJLt1+VE16weoGuiCeNfkNdoZsg/3CudRixPGjGwk2LUyTS6W2hK4os3IzHStgT
         z2/VAleYrnB3FRB8YIGfNEyG8lxWlLVQW75+qo9hlup5k6P8/YRJlFOJdSEqDqj5+KDz
         VazZPoegAdGRhqrGJfoHOUHGAjF9q6ZnxWsIInTDjtFPmAHF8to5JbayhNcjz+M+OpA8
         W9UA==
X-Forwarded-Encrypted: i=1; AHgh+RrMUzLNz0j1RO7A53DE4vRmYp5WeyK5roGlQaLFWXKm3qtx8Vrv2YZ3765XaLRN781rtXdGJjAcGRlHuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6nF2YqPSkVG3pkfTAOY/lnAftzMBlani99lxDoo5y8au1W5C
	bkUzJXacd2XbDr91jZkY6JOGhyde7+8+vzKkHRq6qxrjhdJytQgJVoYV
X-Gm-Gg: AR+sD118KqYvA+dMlpwvXPryiFMsbiHTbbHWDH+6MNeBgLeB5ccOLYXe2eD3QS1ppFo
	l88HKmW7pb4K/b4L5cPR+TFCAPz4wzq9Lu5yI3V0hPtAkEwwV4PlxM/9swJL2OPsW24fsqCTZyU
	CWd1SeRKzdemPEZuA73hb26G6EQHnH74hD473Y9cwmSL4K4pOOTTbiBKxOA3oxZmZP3hg1WmVvY
	whjfN1zgFNeFtXtjCRUlwduQpT5aTMpxcaoJsP6Ih0IIguWYgwP/7Q4c2J1wT1qPCFrn/aO1gv2
	Kb0OGRZyet0BzMVwtYx+N8RBM4oP1ChsxvBL9KQQRqV6US3UZSvs6i05e3rjPlBJzwetFU6lZ4w
	KYrXObYF2dfdt7HmqUmB4C1ZpzcvmwkquOvP/pjNIGreOdOFaNiGnAkfUXY63dJI0jIVW15O7bL
	veymqwgWEOx/EUrBVw4g+R0LzBi60a4Y3YfXRYJhRIM1iskFI=
X-Received: by 2002:a05:622a:1a85:b0:51c:1e2f:1281 with SMTP id d75a77b69052e-529d71e91e9mr40343311cf.42.1785279352015;
        Tue, 28 Jul 2026 15:55:52 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b4f241sm8017991cf.7.2026.07.28.15.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:55:51 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	W_Armin@gmx.de,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v15 1/2] platform/x86/lenovo: lenovo-ymc: Suppress probe on Yoga Book 9 14IAH10
Date: Tue, 28 Jul 2026 18:55:43 -0400
Message-ID: <20260728225545.1333610-2-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728225545.1333610-1-carvsdriver@gmail.com>
References: <20260728225545.1333610-1-carvsdriver@gmail.com>
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
