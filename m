Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B62D1931
	for <linux-input@vger.kernel.org>; Sun,  8 Feb 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770570780; cv=none; b=YvY9yJuK9kK4KRDPIg+m4fAHy+8918v2zt4ISYXEZM/fgvqaKvOmoGo9U4eCIZe/kCM1NGaMKvtv/ZT5+2A3aop+lH/5k4pj30sse6nJGHhLMHTkFLZmGITIy/jvNfiL23yZL73lQDxmQLhTl2HopqqwZ/5Jr0V8uUBrGU2FG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770570780; c=relaxed/simple;
	bh=mhdGlb1t/ORpowAdA81B+hfxkL6dR35ohtzKQDqvK14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZVW9RncQWi3+Ak5XS/hx8xBCds23PwbSbneJ2ufRQfmwnZWb1ZmmbH4NaMxhIiAkDcF0EzV4dLZnhSENU8dabsQ/yYIhMYiy1WgxJjpTqz525X0HLppkjCEuMiLJeeqJZHktTnolO4MAnHsn6iU3KarPIDY0Py+mAlbRHziY54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX7vjSic; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX7vjSic"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436263e31abso2488233f8f.1
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770570778; x=1771175578; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pvwzpJVVWdrlZd2NDzfr6xh4JKcYdWHSQxCaogW/r78=;
        b=cX7vjSict1bsD0vMsB+mmRfET8M7H/i5JSv6sBnzz99nfiUSljoB0rivBaEByCgFnM
         7gBQrr7NomgUPKUArdh+0Jf1npGyrodNWffxB3vnne0wmNWrQnTkXz/gaVQQP8+qALeu
         FUfPBz+25gwU5c+5CxjnAlgQOCvLDDwfN695h/3yJosQfcpcMnJ3Oirt2hpyyL+sM0jf
         FK4feTe3mm1ykHefSMrwR2UbC+ZpzPkzWPEZB1LIMbSxX0jh2YLnAwnpqDDTxMLblP8i
         2kYLTdImTBzNX9tdGuUa4SQcyQEKJF4M3RYvJjVpheKc8inN8aYpna6ybzEvOrqmxoUP
         6GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770570778; x=1771175578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvwzpJVVWdrlZd2NDzfr6xh4JKcYdWHSQxCaogW/r78=;
        b=V6VAYyKWaesUD1DeiBJJiSyfhRiaEc07CTSRLNAIXplrVWPCIunecki2QtBeUs2fgu
         wVExmuK7sQ97RHdsq1oQTLYS38qS20UdMUTpcj2Xm1rOdF+Qsw8CB+Zi24qIcjnIhs7V
         xF6UKKE6WDpumla3FeFIaxmHe1TwD2S6qTp2L+jQFwu/8WKPAudMlo52cedmft8tHHNI
         iC79j2niL0GKAYGu0N58BC0l2KImhbReu/ZomIsI3fcRAWbRhcI/t5TOmKqxbGB/Gcnd
         TYnui68lZcqXNLV5jlHzPasm/YqdhnDq4APkm16BtsTCYelr4ijfyIVnPHQOoiREKHck
         YecA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Uts8Ivf3nMM40WpZG1Lsvi3wSzodlFA1d5B5viRD3L1pS8QSH9Onz+pSgxCQfahtwhDHNdeun4zZmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYipKJR5JwQfd/p04RpGrdLY6n+CeBanAo3ZESuwMNtcUVzQ7m
	rB4tJnc4y7i/VZ8/tkKP+LV0kfsVOXFdO+oSAMSawOKkHqa7yPIQku3Sdv54Rg==
X-Gm-Gg: AZuq6aLdd71cyuiDKGFiXcbLCXJX+BRIVLxvikika6gYZbtIZ7b3D6jPhOLZoqtSOgV
	Ur0WBhcHcfS+clOva8qpwX7mg8pLe5H9f/ByWj8MCdVvUXFVZwdwJnWqVjDZLaQ9YqAu6G+P7LL
	RwNEgBjIOd0Ij0ur3Eoqv6G+fq7QN1tCxrF3Ee39cGNyQJ3IXx8h5SmwKe1NG7qDt9+vM+8nwdY
	bay5caGY4Yv0fiQomC7TxKHRGE6J3RpMP5CENEOPt7L4gdZN7WrLqmSVZIjYaNlZVQNkeHMNbL2
	B4PS6SgJ/rksy177z43EgAHcUZz2N96Yh7c04we56UQ26357/emKgKUtIOKstg/E164BP3y7luH
	fGaE7HTTiVrQRvr18BpoiCd4AcmlsW5JTkp8cs3mvCEsZqIdowPU0Xcxgn0ZNtY7dLAjDplG9FM
	zoef3JR3m9E6IIHDj4sFVmf83Ekg==
X-Received: by 2002:a5d:5f88:0:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-4362938ffacmr13963638f8f.47.1770570778245;
        Sun, 08 Feb 2026 09:12:58 -0800 (PST)
Received: from [192.168.178.21] ([2001:9e8:fb98:1600:22c9:d0ff:fe7b:79cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc0bsm5451770f8f.32.2026.02.08.09.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:12:57 -0800 (PST)
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sun, 08 Feb 2026 18:10:19 +0100
Subject: [PATCH] usbhid: tolerate intermittent errors
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwML3dLipIzMFN3UgqL8knxdQ1OjZPPEpOQkQwtTJaCegqLUtMwKsHn
 RsbW1AOpKY4hfAAAA
X-Change-ID: 20260208-usbhid-eproto-152c7abcb185
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liam Mitchell <mitchell.liam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770570777; l=3087;
 i=mitchell.liam@gmail.com; s=20260207; h=from:subject:message-id;
 bh=mhdGlb1t/ORpowAdA81B+hfxkL6dR35ohtzKQDqvK14=;
 b=Ya3bIaypa9Ewxl1KQHmRS4/NfpBCMUt3ZTOCfdVztCt1pod1ob43r+3jt4L5nUqpATl1H2SpA
 knKUZSaLzxZB/aMVifGEFE/OxK+fpTZtXWv61BVpxlOX5chism183Z1
X-Developer-Key: i=mitchell.liam@gmail.com; a=ed25519;
 pk=Y9mPqBk1OuHZ0OaUZ5a8Nc5X7YHs7+SKiNwUfcLfPmg=

Modifies the usbhid error handling logic to better handle intermittent
errors like EPROTO, which should only need resubmission of URBs and not
full device reset.

Reduces initial retry delay from 13ms to 1ms. The faster the URB is
resubmitted, the lower the chance that user events will be missed.

Increases retry delay multiplier from 2 to 5, reaching max delay in a
similar number of retries.

Adds another check to the reset block, only resetting if retry_delay has
reached max, effectively only allowing reset after 4 errors.

---
The usbhid driver will reset a device after only two errors 1-1.5s apart.
The first error will be handled with a retry after 13ms.
Handling of the second error depends on the time since the first:
* <1000ms: retry after 26ms
* >1000ms & <1500ms: reset USB device, taking maybe hundreds of ms
* >1500ms: retry after 13ms

It doesn't take into account the type, count or timing of errors.
EPROTO errors can occur randomly, sometimes frequently and are often not
fixed by a device reset.
Retry delays or device resets only raise the chance that input events will
be missed and that users see symptoms like missed or sticky keyboard keys.

See following thread for more details:
https://lore.kernel.org/linux-input/CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com/

The following patch is a minimal change to better tolerate intermittent errors.

Using existing variables, we reduce initial retry delays and only reset in
the 1000-1500ms window if 4+ errors have occurred.

This should reduce issues for users with intermittent errors and retain
the intended retry-backoff-reset for erroring devices that need a reset.

More comprehensive error handling could involve counting errors, time between
errors and/or switching on error type but would be more invasive.

Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index aac0051a2cf6..b6e956ca781b 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -160,12 +160,12 @@ static void hid_io_error(struct hid_device *hid)
 
 	/* When an error occurs, retry at increasing intervals */
 	if (usbhid->retry_delay == 0) {
-		usbhid->retry_delay = 13;	/* Then 26, 52, 104, 104, ... */
+		usbhid->retry_delay = 1;	/* Then 5, 25, 125, 125, ... */
 		usbhid->stop_retry = jiffies + msecs_to_jiffies(1000);
 	} else if (usbhid->retry_delay < 100)
-		usbhid->retry_delay *= 2;
+		usbhid->retry_delay *= 5;
 
-	if (time_after(jiffies, usbhid->stop_retry)) {
+	if (time_after(jiffies, usbhid->stop_retry) && usbhid->retry_delay >= 100) {
 
 		/* Retries failed, so do a port reset unless we lack bandwidth*/
 		if (!test_bit(HID_NO_BANDWIDTH, &usbhid->iofl)

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20260208-usbhid-eproto-152c7abcb185

Best regards,
-- 
Liam Mitchell <mitchell.liam@gmail.com>

