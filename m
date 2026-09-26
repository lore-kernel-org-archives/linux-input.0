Received: from www620.your-server.de (www620.your-server.de [168.119.26.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57233A63EF;
	Sat, 26 Sep 2026 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.26.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428151; cv=none; b=eS2kp7Y4NMIozpwcxhWxhya4UJA0Qb7xJhjGEWwLoMJ/g9eZK13n0u7CuT++Gw9ecr9BO2JL4ijzZMxw5ncdx4Ob7mB7hjSCrBvFCXvcMZs9OEBx9eEhOTvbAVloR/DEyBjd/jU3vF02sC1btePCzLBCC8gYepfouGayOIKJqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428151; c=relaxed/simple;
	bh=BbQ5akPp1BQFQ9ykGY8d/FuFUN9iRBXAJBm7G/qNlak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uroxwNsU6IryFr5M2fw6fZ+dAPCOeKeIs01NW8z2VDa3wm+EMuIVzVQpojz2wgOnLTEPEvdueR2Y4ND4kKgAfK40V+2DGU/ZyvZ5buupJ/LdvuxtEqvhvdFElxUO6GX52Cxs0a7ZhqotrvaKQzfvUJCGAOPvoP5E+of4No89I+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teffenberger.de; spf=pass smtp.mailfrom=teffenberger.de; dkim=pass (2048-bit key) header.d=teffenberger.de header.i=@teffenberger.de header.b=G+v724GF; arc=none smtp.client-ip=168.119.26.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teffenberger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teffenberger.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teffenberger.de header.i=@teffenberger.de header.b="G+v724GF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=teffenberger.de; s=default2512; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=wdhKzywdHf+DaB31Nhg1gsI3OI6zK98p+n+CISESsKg=; b=G+v724GFvmMCwSM050r+rx4e+4
	E3aJpWAT3HQ3uFkatczXqxiYDxuWVQrb+qlmvIlQwlLLkN/TRAEEUqKXmdw2gJkIn4UAXet5JhZub
	sQV7Ebh2rjQJGr5RLpSvlz+nb9iOXMrpD9zwNSrwFDbztuwc8+aZrFFEJHZ/8s2odhUbjn+fCM3P+
	zNaApeAEQBnn4uwB8U0waUvgRL8NHaW60+mO20iP0LAS/D+mN/Np3/ivo9aHMZIz+R+UieuIuG+FV
	g+zWdfdeup8cZOqBUG3GfC8issM6w2Bwf++5hU3Wqf3L/z4YWwZGi0DIau7hygOhwmNf9nX36hg3a
	8DKk4YzQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www620.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@teffenberger.de>)
	id 1xARle-000NGS-06;
	Sat, 26 Sep 2026 14:44:38 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@teffenberger.de>)
	id 1xARl6-0002ci-17;
	Sat, 26 Sep 2026 14:44:37 +0200
From: Tjark Effenberger <mail@teffenberger.de>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Tjark Effenberger <mail@teffenberger.de>
Subject: [PATCH] HID: Kysona: Add support for Kysona M600V2 variant
Date: Sat, 26 Sep 2026 14:43:37 +0200
Message-ID: <20260926124337.45870-1-mail@teffenberger.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28135/Sat Sep 26 08:24:13 2026)

The M600V2 has a different HID ID on the wireless dongle.

Signed-off-by: Tjark Effenberger <mail@teffenberger.de>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-kysona.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9a473f72c8cb..7ac47f585910 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -822,6 +822,7 @@
 
 #define USB_VENDOR_ID_KYSONA		0x3554
 #define USB_DEVICE_ID_KYSONA_M600_DONGLE	0xF57C
+#define USB_DEVICE_ID_KYSONA_M600V2_DONGLE	0xf5d5
 #define USB_DEVICE_ID_KYSONA_M600_WIRED	0xF57D
 
 #define USB_VENDOR_ID_LABTEC		0x1020
diff --git a/drivers/hid/hid-kysona.c b/drivers/hid/hid-kysona.c
index ccbd8380064e..8457cb7df7bb 100644
--- a/drivers/hid/hid-kysona.c
+++ b/drivers/hid/hid-kysona.c
@@ -272,6 +272,7 @@ static void kysona_remove(struct hid_device *hdev)
 static const struct hid_device_id kysona_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600V2_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_WIRED) },
 	{ }
-- 
2.55.0

