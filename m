Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9332C08AC
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645364; cv=none; b=rWy5FQ1yg+a56CQgCRPpSKBYZXV2ICgDhcdAj72gcJZwd1ssrcbSjS4eriDIDdLACvfUFJgFTa2BUPUXUJHUNfrTT7IVPNyUYHdm3TWXD4bBs0zKjQtm7PVHHm4fdkhwJzA2YY4NpKrlSHTkyVAFS1fPfWuXyPfmXKCrOox+KLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645364; c=relaxed/simple;
	bh=JepkO0OxBLNbdzM+sY7O9zfCw+GPn0XpgWDyblYtgmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LisJhQdfh3BOlE+k/z4zBykqcSe9DNmPJWIJgw6P9WUtynENTgouDjzg8NRhlcaXVqs5o6+v4Knaxzndo9m8bPs6BibNiDGXocnZUjkolyWSGjFPz+FV4KflQ8Jpyxh6ERmCSI6TwMV6RQOW0edwJn82uOJJSyUGut/zfjJneoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5SSa3iB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5SSa3iB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-367c26471f5so5699070a91.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779645363; x=1780250163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZe8sDfbFbrFagrlSiLzrDPDhtWv1FCgy5wZfrXmVes=;
        b=N5SSa3iBaf4AsN+87519Lrk+Gh/l4IjJthXxyjj8Zx4xHzXWw5QrekDqki8ydWGOHq
         PhS6fonxpzLqHpg0Bb7NaVEv0c9piCh3QcojXR9G6v/JFpcNID2R3Q9e23oxFK6HYhpd
         dFdDECqb36RD8aWaUxOz30RL6HE0EJd7xeiytDdaUno1ORunoCnP/K1nhQEcE+SfYtx3
         R+RKxagYLMJEbIEfZ8ufIQ7wpb/lg0FSCxQHV5NUE7fDgJxy2j1eroQuC3YvTOQG3ttU
         i73Ma0i+V4SfXaLVeuIOFP9aZhc6zM+fnzz8aQo/tiIUv4uPHLtrs52KXBy2cw1gF0bT
         s40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645363; x=1780250163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZe8sDfbFbrFagrlSiLzrDPDhtWv1FCgy5wZfrXmVes=;
        b=OA7NZnAahDHRVW1xit+vSDqXugjaInVSAGNZKomItW02NNavDREzgVcp3QCTQ/uOho
         kK5e22BYXPtFZKjWQ79jmwUJOjm0uA4j37DTbKkwjsk7EoH0r88Q06NAq6K42tuOj1BA
         JgslptN3YajT/a1+qXa6BhhSmo0bj35c1XgU82QlnjQrWn5p+bYBkaBWy9jQOcwX9Z1i
         EmBX5TLu1NR0PH7wA/Mu/8ktu2znZoKsQ0bSgmiLBYgaZ2WzbpPLdlucJioEJBAwSL6K
         UjYPEZ9dXzhJAU4oguNEYJXMUkN0XzBt0jdwZiGjbezRfXfBEezXaMUVn+WS/7UQHoYG
         cuYg==
X-Forwarded-Encrypted: i=1; AFNElJ+v05hueePHp3aFStF/zJkxOdX82OwHLT8f2tzZgO/TWd5Me6LIrVbIsDsjLU/+1Sv5FBNlMxkOU26stQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCUlTbCjwVD83KLk8loNQhzyuNiNMDypI2pA06HmkI7W83sxh
	RR4ucWUKwZ5/HzOT35yy8y4Bn4aXoO0zyRZCz6x/4GvvkMMRC1nadHs=
X-Gm-Gg: Acq92OGU7qx+axeuhylvUhQtpXjkxHBaE8waEGyw1BAWlv2vNWqtS7YYXcEpQVRlE7F
	QOpVnD7TzeynrO/7lSDTB6ruymqp/FPHB8Zb2wB13DFHm/p3WSOJ/YBPNebexfRoNfBdlBPzqwl
	ShB10kd4ogziwKVLbDXQZP8iTGv4fPycRLir0edY9Vhbfr7CNhf6N3sHyKxFlZ8ZHevV0fDZ3iT
	S1+5mCtlOgu65QrYeWBiGEs1QuiD3Bc/qZMF2biSr7lEmofmVYn+iM67Q+QZDVJ+GlWqSDyyg+y
	ul8ZAOkWIhtTkY24b/gAimNOOo+fm60hKE2TXbn189xQTd4+qpKDK5dxMCPQM5wI1VL/USYKbbz
	Vl/qckncfDQdomLy5PuMBqlK778tBbR93xB0rvXVM4WuAFz+LRaGQ3TglRwLKCzVIMbIbrOAchH
	z4lagYCCYykD32ZprBFot9EEOIFsbOsv6HBm0tkCk2bbpfxn1Hk/nxcWUC9d48lKr+WJBxY9YIi
	1wWhOXgMA==
X-Received: by 2002:a17:90b:58a8:b0:36a:cd8c:ad3d with SMTP id 98e67ed59e1d1-36acd8cb47amr1301821a91.22.1779645362771;
        Sun, 24 May 2026 10:56:02 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852058557bsm6080557a12.30.2026.05.24.10.55.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 10:56:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] HID: wacom: stop hardware after post-start probe failures
Date: Mon, 25 May 2026 02:53:33 +0900
Message-ID: <20260524175552.1973-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_parse_and_register() starts HID hardware before registering inputs
and initializing pad LEDs/remotes. Those later steps can fail, but their
error paths currently release Wacom resources without stopping the HID
hardware.

Route post-hid_hw_start() failures through hid_hw_stop() before
releasing driver resources.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hid/wacom_sys.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0d1c6d90fe..c824d9c224 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	error = wacom_register_inputs(wacom);
 	if (error)
-		goto fail;
+		goto fail_hw_stop;
 
 	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
 		error = wacom_initialize_leds(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 
 		error = wacom_initialize_remotes(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 	}
 
 	if (!wireless) {
@@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	return 0;
 
 fail_quirks:
+fail_hw_stop:
 	hid_hw_stop(hdev);
 fail:
 	wacom_release_resources(wacom);
-- 
2.47.1
