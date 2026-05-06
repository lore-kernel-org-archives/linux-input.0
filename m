Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F1332909;
	Wed,  6 May 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096019; cv=none; b=Lx/ruosKiB9eYVaMjBHD0P3REfAD8KPidp2Q8vRIGjHH9stnWEdd0M/hsh+tiWadOiYZMTmCmRGO78wv7nFTWSknxPud8RNLtRFMlhN65umOWP5mKeuB1zB/+77ernDW+31yekW8Gyc5uBHuRMbmTEJKewVXIGEwrmWvaBU+Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096019; c=relaxed/simple;
	bh=acAqpCuG5vdbCm/VILd6zEIEiskYNw+niNY51lb9HLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQaFVHkSyWwDl8l+JWt1ZEaibNS4GegRvJRt4Lcggv/HX2i/ayatqSwLOrbaXV69zoZverpxxIXouVqoMLoLeB6iQfgO/gUR9IxW0W4BsUP0swaZNzPVxj+1HjlY4dCLZX7XMWlj518z6wgqKcc7CPYD0+YI/wit6Pus4HEvvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=cipZb7LY; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="cipZb7LY"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4g9lt02nvMz1DHpT;
	Wed,  6 May 2026 21:33:28 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4g9lt01Qypz1DDSy;
	Wed,  6 May 2026 21:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778096008;
	bh=5plDjFUkjm3z87K+GUhrRwUtHmmpSxf/2NvEC0qQWv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cipZb7LYQyNmlNGG0nCZgElGSFVJCvT1iXidzDonHvgqR5ihi2kcn+Aj9vzWEkwmW
	 3+TrDbUOUyYCjDtipc58R+EqUkV5JlkdAuZmJkagHWZL89LPDry5MeLGdknYp3Hlq4
	 q4hbfl6LuMQ6D2HZFPuv77bYNX7d9RF5jT6NN2A02CEoowzjPqbnGyxD3sJjk+DxLe
	 ADO72R9+oq3G12LGU7wv58HTGf7jllrSLIvms46oVYS9vwUuu8+99qF6Nbc/Uw9+PX
	 i7Pcf4NbGeVOdsd0gp8mepWGVsdldyM70sL2Bzrba1Q9c5Acy8RyrWKlGgcOGn/lkV
	 3T9AiFPGDPBrA==
From: =?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
To: platform-driver-x86@vger.kernel.org,
	denis.benato@linux.dev
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	corentin.chary@gmail.com,
	marcus@grenangen.se
Subject: [PATCH v2 2/3] platform/x86: asus-nb-wmi: add fnlock_use_hid quirk for ProArt P16
Date: Wed,  6 May 2026 21:33:25 +0200
Message-ID: <20260506193326.5862-3-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506193326.5862-1-marcus@grenangen.se>
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
 <20260506193326.5862-1-marcus@grenangen.se>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ASUS ProArt P16 (N-Key keyboard 0B05:19B6) advertises the WMI fn-lock
DEVID (0x00100023) as present via DSTS, but the DEVS call has no effect.
Fn-lock must instead be toggled via a HID feature report sent to the N-Key
keyboard (handled by hid-asus).

Add a fnlock_use_hid flag to struct quirk_entry and set it for the ProArt
P16 via a DMI match on DMI_PRODUCT_FAMILY. This flag is consumed by
asus-armoury to select the HID path instead of WMI DEVS.

Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
 drivers/platform/x86/asus-wmi.h    |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b4677c5bba5b..44e4cf68ff70 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -155,6 +155,10 @@ static struct quirk_entry quirk_asus_z13 = {
 	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
+static struct quirk_entry quirk_asus_proart_p16 = {
+	.fnlock_use_hid = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -553,6 +557,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_z13,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ProArt P16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
+		},
+		.driver_data = &quirk_asus_proart_p16,
+	},
 	{},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 5cd4392b964e..6c50b11860e8 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -52,6 +52,11 @@ struct quirk_entry {
 	 */
 	int no_display_toggle;
 	u32 xusb2pr;
+	/*
+	 * Some platforms report WMI DEVID_FNLOCK as present but the DEVS call
+	 * is a no-op. Force the HID feature report path via hid-asus instead.
+	 */
+	bool fnlock_use_hid;
 };
 
 struct asus_wmi_driver {
-- 
2.54.0

