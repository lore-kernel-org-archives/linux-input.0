Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5A47AF4F;
	Thu, 22 Jan 2026 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068284; cv=none; b=mmIFwblS8Sxs+svN054qvwnvlPaopM+RuB2uUaU4bn+tAk8PD283l7p62+xnovvuo+nCInyl653cTRhIEefQ7wOGdiqC07xLCrxH41G/5sgDUMN0a5YNdojjFjDFIWmeSv4Fu6mvG0bUODiAIkDTnAtVKteG7SdT2EzlPBzpAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068284; c=relaxed/simple;
	bh=asPpGdlfGiuN5jRnlVRzhgZyectj330JM1MS3UQWmOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpO9asgc3yxYi74U686wD65gayjMIeTYUG1H3bovKCWNypQODxa0GHa0yeWaKkoOz4f723oXPRa9XB65rF/kVoDBl35VYYzO5yAXOQPhmUZDNRXxwd8+ivT4FlsbyK5mNjYxIQL015NFPX1ZsyTNaWFTGwQOMxFu5ia8BaAmuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=l0oEWzcL; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="l0oEWzcL"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 15418BC02D;
	Thu, 22 Jan 2026 09:51:09 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 4EB44BC108;
	Thu, 22 Jan 2026 09:51:08 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 9BD431FDB07;
	Thu, 22 Jan 2026 09:51:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068268;
	bh=YKdbyFTbdMgDU4R7OiMOgOKjfCg2pYdwoQ4bBxOaJu4=; h=From:To:Subject;
	b=l0oEWzcLmESHtcsXmLe4xdnanYaDaw+qcocZhOHi1tFfsvqQNXP16TInPmpAkwj0d
	 19nYab4Uu4JMu6pL0VC9PvOtDKp+YIt0/T55AJ54vNIk+ftWxmR//F/bAXO8Lc0j3r
	 BTG9tJpGdme7E06rZm/vFiolkWVx5kOPuQvcPwYSjJmgym3TlfYSdDyfKdrw+irQUJ
	 IAPiCJliaIqLTGIKMEL5fMfYRr5ckJ0ZuXSctzmSgXDEgpZNnXbuznrE2kysR6ajMd
	 sdtuiO6Zb3eTdMzEMCEwc/7W4ZoWWwx/RQO4Nzrogu40Jani0Okv/WaVTTZFIsI6N6
	 bp1i/3FT2lRzw==
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
Subject: [PATCH v12 04/11] HID: asus: fortify keyboard handshake
Date: Thu, 22 Jan 2026 08:50:37 +0100
Message-ID: <20260122075044.5070-5-lkml@antheas.dev>
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
 <176906826771.713936.12501197286239134259@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Handshaking with an Asus device involves sending it a feature report
with the string "ASUS Tech.Inc." and then reading it back to verify the
handshake was successful, under the feature ID the interaction will
take place.

Currently, the driver only does the first part. Add the readback to
verify the handshake was successful. As this could cause breakages,
allow the verification to fail with a dmesg error until we verify
all devices work with it (they seem to).

Since the response is more than 16 bytes, increase the buffer size
to 64 as well to avoid overflow errors. In addition, add the report
ID to prints, to help identify failed handshakes.

Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
Reviewed-by: Denis Benato <benato.denis96@gmail.com>
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 2ff2170dc30a..cbf5bab9113b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -49,7 +49,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_REPORT_ID 0x0d
 #define INPUT_REPORT_ID 0x5d
 #define FEATURE_KBD_REPORT_ID 0x5a
-#define FEATURE_KBD_REPORT_SIZE 16
+#define FEATURE_KBD_REPORT_SIZE 64
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
@@ -395,15 +395,41 @@ static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t bu
 
 static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 {
+	/*
+	 * The handshake is first sent as a set_report, then retrieved
+	 * from a get_report. They should be equal.
+	 */
 	const u8 buf[] = { report_id, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
 	ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
-	if (ret < 0)
-		hid_err(hdev, "Asus failed to send init command: %d\n", ret);
+	if (ret < 0) {
+		hid_err(hdev, "Asus handshake %02x failed to send: %d\n",
+			report_id, ret);
+		return ret;
+	}
 
-	return ret;
+	u8 *readbuf __free(kfree) = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
+	if (!readbuf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, report_id, readbuf,
+				 FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_warn(hdev, "Asus handshake %02x failed to receive ack: %d\n",
+			 report_id, ret);
+	} else if (memcmp(readbuf, buf, sizeof(buf)) != 0) {
+		hid_warn(hdev, "Asus handshake %02x returned invalid response: %*ph\n",
+			 report_id, FEATURE_KBD_REPORT_SIZE, readbuf);
+	}
+
+	/*
+	 * Do not return error if handshake is wrong until this is
+	 * verified to work for all devices.
+	 */
+	return 0;
 }
 
 static int asus_kbd_get_functions(struct hid_device *hdev,
-- 
2.52.0


