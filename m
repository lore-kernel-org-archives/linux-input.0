Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812658;
	b=N9FZqAZ0yvYG4AaUOm3kFkb8h5+9Or7go252vaq1mW0FIh/1I8su2X4ki3FmIBnK2ceV
	 B+++dsRRIrJREpoT+Y58abWVl+o8OngaeKLK2b10O0jvEwj7KlWuZzJ8x4P2n1WAfmqSz
	 wpEf9z7sPV0IczV0r/0LCJ40o2x0lgbMjKPSWbF0AcYqOY2doQXLjphJZvzC4Ing+maGn
	 9JemfPNFkQMA7G5+GRIsUE7kn24t58fHSdiwGIa5zNWhegR8t30KraP1+c6RHr0tO0Yld
	 Y0NtWdjnMfVEQXBVymKJcaSPLl98a5y0zq9iC6LUh1Hgh4Yf1YVX2DEpDJ7bZrs/Hkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SMS+XYATUvY7YNvEDxX5IVPCQZNzXnmL5Yux3ihoSpY=;
	b=RHsLgrEp3PNBsJeK7N5heud37thGNSE7V1CyC7N4WsWe+zaBqX1fDxqIzq1WG/mGEvct
	 DMPWJI3tpfi6YY8d4eU4ek0hG9PNIWzlIprBv8k/7ah5YyQObn8lhMUguUBS3BgDEh4X9
	 JfuEQqQWCmWhS1NjtlAttlNzyBgt55UpHC/QuS0M+qbF1mN1kYLJ0fsiTOQ/pGyywSi8j
	 ntXTYvFzeSZghkcp433g0q9aSgP0OkQk8zdeVLRUar2qRS16mnrQ+cRgsqFH3FsqQJdoI
	 ld4GHuYvweyA0nBM3sbIk4zGd4xjsJV/z8gi2WokMud7WRHtFoUZKhINEyP0vJ9wLfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xnbot7Li;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDC606A31E
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 03:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFDC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xnbot7Li
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36661f953e4so2548838eec.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812657; x=1793417457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMS+XYATUvY7YNvEDxX5IVPCQZNzXnmL5Yux3ihoSpY=;
        b=Xnbot7LilCE9GzQVggpQUtlm3O5iPC748Darj3t7UdYZ/Y12arwKbFv+cDmSrGM0cR
         mMAQ2QZ9CdPlz/yF9ebjqCNfn+15S0e18qDxAvWQ9UNNlmgvcnuT6A/sicnFXSDYFT4q
         1W6qW9e7xh4WQPakwDTQjmG2ekjgvOFQwvVzBEmsmwieOBTKQ6oIj1A/5UkT5giu0ukO
         L/t9k1mPmHYp8/13GtyIZNo/UXDvvZJm/nBcsZSKHFAEHlf+wJMJ51pArPB3wCzz3XpB
         OkxihjPACxym/IRBK+4LsPAl7dFFU57RlxApVF1AMALUHZFAP3IaEOb1+SPO7yRBunKW
         Ckig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812657; x=1793417457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMS+XYATUvY7YNvEDxX5IVPCQZNzXnmL5Yux3ihoSpY=;
        b=gGHIzdapyVlKjfCzOLRVnEh702VC5OLtilT8bo+rphv3yskb8p/Q+ZJSyyCrNoO94H
         UwlmIINhdwEJfbEB2Jt13Xs4sdDkQ6EgNc1KAYrfVJCyf5Z7Z81gOud6DM4yRi2eIFNO
         ke6TZZqvbLWHySYMijj4NOxhtOblfRpLn4Rom62YkWB0m4hS20ZbnEYRsjFAxQH9isyq
         t0SavsG5WfN3wTW6smI0sCLhE0P3dM59ojlGxdOLOn3cgPxjvftwbzbhyPlRVkIwp/UM
         4KBtAsU39rQoerKjCwbuEiFGckWXCckADP3UQZd3JwRndXYKbp5ryhBoIkncM8DvUZNw
         HlBg==
X-Forwarded-Encrypted: i=1; AKwUvBzKRUs+A9VuDY7+epRY3lbWqiLpEXHDTYViu/fwgZx7WIrlXdGZ/W9neRaHxLBRBOi0b9323QAL2pu5xA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYev0QKAlQQpneu35FSvGyp3kPXL6UhFttUAyLZstzmPKGkIM/
	kPMPwQOsIqmQj3NGOWL3MwmC4KJRaO44BJB2kUudJB8qac3IppZBMyYH
X-Gm-Gg: AYBFou0q8dQ+PG5hWQzcTO906GEdBFQcBhAvr1gmFs6w2WDqmCzL4i+ryWgXyv4Czxv
	+vghUkPm1MH+0qxnz2Nwd7lrhzrI8m7wjDgPgU4/4UTZOeVasSf6CcR+JLx0R3CSKdBO6dv8bfV
	LUNrB/Z1W/2R7P/rzSpoK1jZsJ8wetkilFjXJq8oq9cjqUL5uOzwtFZcU0zy0ksPA6JQT7ZGQsu
	YHmWsDvcdaBpY/mlPb76RiTT40FQ1DN8AFh5muCDuDXHdEjy655sax45W27tAxjtgIRXdAhYeru
	ui5DPxAyI3JLTVV1iGql3lqMUtRXwvzlChskreXeUGXRsBRS/8UZ+iEXqkakR8rPsj9UBmBnwug
	1w71F7WQjgJ/WdruRtddB88ge0k8l8DQJknOAPS54EIQSiWqrJoOgt480/0B6mYD6g66QBJM7pV
	M5MJt0WSfBrRd6O+8uBAeet0GC0vdMvP0lKCQX/R2NZPttm/cmOza4s01GceNLL78ED83CWOCtN
	G4MjisXsCMMol4vQK7bNeBBXNCtGqNYiPLra75+YEi+JnoHgv9SlvDQdEI3tT5XOVIxJPtIYtKA
	hCTfQDHRxyHiT29Sis9f2BhDbrCH
X-Received: by 2002:a05:7301:4543:b0:369:a113:7560 with SMTP id 5a478bee46e88-369e86249f2mr1546686eec.41.1792812656823;
        Fri, 23 Oct 2026 20:30:56 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:56 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 4/6] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Sat, 24 Oct 2026 12:30:38 +0900
Message-ID: <20261024033040.316652-5-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_bt_irq() dereferences wacom->pen_input in every switch
branch, both directly for dev_warn/dev_dbg and indirectly through
wacom_intuos_bt_process_data() which calls input_sync(pen_input).
pad_input is also used in wacom_intuos_bt_process_data().

Both can be NULL when the corresponding setup_*_input_capabilities()
returns -ENODEV during a successful probe. For INTUOS4WL, pen and pad
are always expected together, so guard both at function entry.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c38fbec114e4..6e2e67abf80e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1269,6 +1269,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.53.0

