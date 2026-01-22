Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE833F8CE;
	Thu, 22 Jan 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068287; cv=none; b=QfVYmICAarNne2BFRqFhKPUsweHoIe3N9AaJS8DM7vXNz9a9ntCMJD5sVhmt4sAOgxB05aVRFoBCDhbc0sAA6q7rltC+PajlAZ8XxbDJAuj4eaGIlAIGvLN+6wVacjm+tngVkeqqyebqR5CWtZw1gMAOysxo7s0PFmj9xICoSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068287; c=relaxed/simple;
	bh=VsOw3HPaZRxf8sWWhh+Ev9Bxm7uLkkouC6SML0+EUW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4ULUdI1xbVPIuJGLvOY2qIN+GYQOUtYPbw3h2M/R3FABfAvlFbaMjut6HAY55cEUstz2hHqjTt179QuThx9GB1+Oq7keiIyHv18EbtK1fsh6eebMpBtLnPF0LD15DCNcetg3Nhc7Y/rvyUDpAjIkKkuC43Zqnn/jgEggkabf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jRUWKSDF; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jRUWKSDF"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 0A8193F568;
	Thu, 22 Jan 2026 09:51:12 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id E31573F57D;
	Thu, 22 Jan 2026 09:51:10 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id ABEF51FDF44;
	Thu, 22 Jan 2026 09:51:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068270;
	bh=awXicctiiiJaGKwdCs0xKhCq8RhDNIQeBWV/kYkKMqc=; h=From:To:Subject;
	b=jRUWKSDFERrF5wze8RiT1L3peBxCOCbiQX7Awm1RvB6kIFQjUkoLMv7Uc9MngkX9D
	 1A1RgSESs0/lYDy8Hs8gHbSXbt4OwZ75DY3He/w+vRnA9etGQy5nrKa0HnikyjmIkY
	 kxhnPxtzxJUGwxAvfo7y3Gvwr1BqqtHXrb0ckjAbSiU21Ue4ExI95FFkPuH4slEyVu
	 4I5dotcyYFPO/mZTePS4iUdqxC2Z7AZCMpf5srMAWnqEKtJY2cgU2OefwbeDUzW7lD
	 V/SUeNgDbNowQ0YA9vlHX0lf2hX3ZxxT7AwYUMO6lG+pnBrkPtoxpQ/3pcQbY5OjrV
	 ai6tne1hGdomA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c3:fefd:0:42c:a43d:2848:c282) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v12 06/11] HID: asus: early return for ROG devices
Date: Thu, 22 Jan 2026 08:50:39 +0100
Message-ID: <20260122075044.5070-7-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122075044.5070-1-lkml@antheas.dev>
References: <20260122075044.5070-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176906827026.714981.9162258020554770072@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Some ROG devices have a new dynamic backlight interface for control by
Windows. This interface does not create an ->input device, causing the
kernel to print an error message and to eject it. In addition, ROG
devices have proper HID names in their descriptors so renaming them is
not necessary.

Therefore, if a device is identified as ROG, early return from probe to
skip renaming and ->input checks.

Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Reviewed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index dc8795b59cc2..6084ec66a134 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1232,6 +1232,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	    asus_kbd_register_leds(hdev))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
+	/*
+	 * For ROG keyboards, skip rename for consistency and ->input check as
+	 * some devices do not have inputs.
+	 */
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD)
+		return 0;
+
 	/*
 	 * Check that input registration succeeded. Checking that
 	 * HID_CLAIMED_INPUT is set prevents a UAF when all input devices
-- 
2.52.0


