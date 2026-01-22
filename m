Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A5349B1F;
	Thu, 22 Jan 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068293; cv=none; b=uL2D+KdKsTN4XSOL8VB7bKGNI8s/VyBKNlzUvi7VkO5BT/IcdTCYd1kYrSq217z9uTv7SNrs3qxNDyPTnkowCxwFNhkrqBZTC8fkD2to+o3FRyIUIbn9yY08DPMNBzVPMErcbbbT/LeGRxrfQn6b+xMO/4ZEUwbQuCea2qJJRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068293; c=relaxed/simple;
	bh=4lexwRZEnHWPw4e4tK3vG+oqsnUqV1hQdWczKUiMWwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5zgQAlJAQ9oXqDOdZiVtGZ/dmMRMXnaINhFNrE5Yll0gamf+0AXdmt+l/C9p2uM6icdyarRRdvIVCYIfR7/Vgd5Crg8p/Tev1Tq6f697GMIeYbyaLZWfsGToJIgnRp4Uzl1ILBCPThVqT2hcda4Lb7VD7f5sXveVL2hVFmiO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=RyiPMW68; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="RyiPMW68"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id B41255E6B2;
	Thu, 22 Jan 2026 09:51:20 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 4E61F5E678;
	Thu, 22 Jan 2026 09:51:20 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 94AA01FC563;
	Thu, 22 Jan 2026 09:51:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068279;
	bh=TEENH9jWJHLVgGP7nxhly/nrZLyFgM9WXTiIXJ5clXM=; h=From:To:Subject;
	b=RyiPMW68wdYyPRBct4DL9YVPtl+TvOv1d/Hi2Vt2+kiqgssYwjkOf+JsNZjNYYdcC
	 QjQ30bkgBdfppANgBpPdL7mRN4yEQJSJYHikHqa+J7Vkw5Wf75vwQdGYMmthv2+StX
	 cj9tMEN+Nfj1F1JRUt8QLmSEm3BHgjv2gaRU6HQmk6ekxoI0yCrRK8KkASHabjt8k2
	 jRBPfDzwEmHYbuxzzgOEY1bNAvw7PCj0YYVnxCCJivOaCfpbCIwzGZJ7lF8A426Sq+
	 aLFLz8oqH2ehgHQpnHnvFCE52tY/nVRBIkzTKWq2RLX7X5ZLgySQjDHlg1msi/XEzE
	 l9CWSAdQMvKuA==
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
Subject: [PATCH v12 11/11] HID: asus: add support for the asus-wmi brightness
 handler
Date: Thu, 22 Jan 2026 08:50:44 +0100
Message-ID: <20260122075044.5070-12-lkml@antheas.dev>
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
 <176906827915.715566.1005201925374772954@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

If the asus-wmi brightness handler is available, send the
keyboard brightness events to it instead of passing them
to userspace. If it is not, fall back to sending them to it.

Reviewed-by: Luke D. Jones <luke@ljones.dev>
Tested-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Denis Benato <benato.denis96@gmail.com>
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 415629ebee15..f5c8df20b88b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -324,6 +324,17 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 			 usage->hid & HID_USAGE);
 	}
 
+	if (usage->type == EV_KEY && value) {
+		switch (usage->code) {
+		case KEY_KBDILLUMUP:
+			return !asus_hid_event(ASUS_EV_BRTUP);
+		case KEY_KBDILLUMDOWN:
+			return !asus_hid_event(ASUS_EV_BRTDOWN);
+		case KEY_KBDILLUMTOGGLE:
+			return !asus_hid_event(ASUS_EV_BRTTOGGLE);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.52.0


