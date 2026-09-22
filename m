Received: from mail-ej2-f26.google.com (mail-ej2-f26.google.com [74.125.228.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9C56B872
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098844; cv=none; b=sVpeaMZrvTPfJMOTPae4xopWVPSz6rITAdeHzx3/+rTdVYnUbfij3UY6nfLtArx5Uk3zpFeZgLk3E8UM6TAdaGst/JqlcReflEtGq3TruAcX4gOEOX++GibUTX/TeeUGWNqIAcgIpt24ig7+WJFKckj3zQOuYQL6A9jU5dczYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098844; c=relaxed/simple;
	bh=OWEJMdTBu0jP2WNpqdbULLuSlNd9muovoetscvcQ3H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owZoFiOHV70Vc2GrhfaTfnczqb0AwzE/KLzjv6iXkYGL8/Jb5p2Vml90iuTzKOR9wqRDaz8jtogvQAU9+lYwRkXXMqXZKHary6I7l5xze/VN7LYEbpiHfFgZChlEz2thNPeGlPH7V9n0cIEylCBfC2ZunIEJh+frBPaMSDAbIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDFhwGqz; arc=none smtp.client-ip=74.125.228.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDFhwGqz"
Received: by mail-ej2-f26.google.com with SMTP id a640c23a62f3a-c2940ef15d3so6014366b.2
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790098840; x=1790703640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXjel/GEYSSOkZjkdg5PQyeWDuDBxnbzbHNvvhwBbkM=;
        b=NDFhwGqzV1jBjLIw1nthS4WLCsWVA5YDc3cIawVU2VQVY8E5IMP0lsudGCYoOCGpTV
         G+hAE1qxZ5/H4dZcV6EjMirCU5jGWjU4YidWro8kYt21HQ4IU0P44TArxx+NC2JJ2Z/2
         I5cyk3fTFFHei6GAQQ8Mw/DE+P1RcqayH3uCfxzg0AhYSzIMw0ygcNRcvEglw968O1Mw
         RwdN1VHAHLrb7oyP0qNpl3nXFZhv0ItqsLvbbVyVpEWN50i8UOaWOVUTIWtzLM9OF9Bv
         7Ah7Ob+nfnUbPMvhzG1Ki0Ynuu/RmwXIGftCvUTUC0hhJBqQJAN29sdxbbGZDif3Pfwn
         W9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098840; x=1790703640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RXjel/GEYSSOkZjkdg5PQyeWDuDBxnbzbHNvvhwBbkM=;
        b=v5dpT5iTKTVGlAZ7RYAGx+w2IPEfOPtpbkbN3jV+W8ofEZ9VIzVZRN7CYTF4kX9fSR
         nEcu3Yua+2IinxrWtgSBdDJ3ymhuYtJjQzjCruUlT+9eDNOMGz9gBwNdC6w2FW7HvZmx
         pjmFv80bUKovmb66uPeMsp4UKUSFhjYR4O967KvXfZMXaKcY/cW08Z0Q6nI/DAf/o+Rz
         hYCQsQyT/TNh9t405DHktwQizbEiDkhE3PrR6juRx8E655oyTgMR9F4C5+NAJhY3pW8a
         5VbakBTnJvWAGyNTm1pqw4amHeO8mYm/vYhk3TGcPM4U6OQ7GDHl+CHHO7+CTpRWtOSV
         OtyA==
X-Forwarded-Encrypted: i=1; AKwUvByKfqrL9Ethv4cJRKUL9/fykLBF1R7ZP6Wh3cYcsziPp/2ocUtvt6kMSTL/aHx4ztoYJbNWaucLqX5tNA==@vger.kernel.org
X-Gm-Message-State: AFuF++ns1xdgrsNsK4Gd2BNpD5dnHLts+0r45tWkQYgOow/ZC0V/j6r0
	p6Q2+dX5bgtymLNGW+FSJBLRY/9jnqtWWnvze8Dm9AniF1PihFABIi2Q
X-Gm-Gg: AYBFou3HW5qezxgjQICaSKTczn6Hl9uZ3mEt/XDE+ayZZp9fHeZPAsetofyb2XJRmay
	fnjJIZdM5yEyQm2AmlFc2ivQtUKM8YWkINKCdmllLS0tehq/DZm4+l0yVdYgu0RhW2+s9G9zKm1
	Lehis/eDWhOHJxE+JUmGOVBrDP7gjQ8YLB8vS14pWIvMWJwIkP0QOJtkRnNJZYsI97lYYbvW6TQ
	o018b3ck+6IM0odizGz3TgxyMygLGj2+80Kc9QJCOuBDQEPblot+bOc+mv42YKD+Nq9UCYdNzcY
	19h4C5wPUw8FqIXAFNldRNqsdXEbstnzypWNHxR/MYMXlsw4O9OKKxA/tnTPz8PXPQAliWdLC4Q
	lhzuoWaRr+MLkxMtjpoWE0m4di6EGofqlBIVrt1WFCCVKXeppCDeDv6DP0DRzEvzV0G+Bm90wx/
	ifmbYAZWpebwly+tmgKTleoUOlVBE0e5IaWwy9WZbpjjXM0838Ix//rCeYpMj6fy66dyGBn3HUg
	Cke/mlas+xB03VJPAXbWoQYU7l86kLAdM5AnjfnpSA=
X-Received: by 2002:a17:907:a88b:b0:c26:2a5:819 with SMTP id a640c23a62f3a-c2a156d91a6mr1280716066b.18.1790098840455;
        Tue, 22 Sep 2026 10:40:40 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aad5bed0asm2549666b.18.2026.09.22.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:40:39 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Tue, 22 Sep 2026 19:40:27 +0200
Subject: [PATCH 1/2] HID: logitech-hidpp: fix hi-res scroll for
 Bolt-connected MX Master
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-feature-bolt-fix-v1-1-63b0fa8da0d3@gmail.com>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
In-Reply-To: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790098832; l=4424;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=+prpqfUWmP1OpGCxFF2B3VUevolHsrLw2Fu2JUnwxBM=;
 b=FsRfPpH6KLaza16wXkt3TzJO0qSsADmN+pCZ3BlQBYjvMBB22Spz406qlHD3VnanXneRtO6YN
 mziJ9enoO4GASjwjdNEsVgJhMTRJIIYV8Suu6A0AF+DHZlFnYWr4txW
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

From: Rafael Passos <rafael@rcpassos.me>

The new added support for Logitech HID++ caused this mouse to
scroll too far for each tic when using the USB dongle (Bolt).
Previously, this mouse was handled as hid_generic over the Bold
connection, and logitech-hidpp when over Bluetooth.

Cause:
Over the Bolt receiver, the mouse reports  are forwarded over the generic
interface 1, instead of the new HID++ child device. The generic hid does
now know about the hi-res scrolling used by the HID++.
In my tests, I discovered this mouse has a multiplier factor of 15. This
multiplier is only handled by the logitech-hidpp driver. When piped to
hid_generic, the "hi-res" value was piped to a "low-res" field, making
the scroll unbearable.

The fix routes the wheel using the HID++, so the ticks are scaled by the
multiplier and correctly reported as a hi-res event.

I also had to move the hidpp_is_bolt_child function up, to use it in the
hidpp_connect_event function, where the gate for
hidpp_initialize_hires_scroll function lives.

Tested with:
- Logitech MX Master 3S (mouse) via Bolt receiver and Bluetooth.

Fixes: 022eb347ff3a ("HID: logitech: add Bolt receiver support for Logitech HID++ devices")
Signed-off-by: Rafael Passos <rafael@rcpassos.me>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Alexey Zagorodnikov <xglooom@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4e00ac91493f..166980be57b7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3891,6 +3891,19 @@ static int hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
 	return 1;
 }
 
+static bool hidpp_is_bolt_child(struct hid_device *hdev)
+{
+	struct device *parent = hdev->dev.parent;
+	struct hid_device *receiver_hdev;
+
+	if (!parent)
+		return false;
+
+	receiver_hdev = to_hid_device(parent);
+	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
+	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
+}
+
 /* -------------------------------------------------------------------------- */
 /* High-resolution scroll wheels                                              */
 /* -------------------------------------------------------------------------- */
@@ -3901,7 +3914,9 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	u8 multiplier = 1;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
+		bool use_hidpp = hidpp_is_bolt_child(hidpp->hid_dev);
+
+		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
 		if (ret == 0)
 			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
@@ -3989,6 +4004,19 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 		return 1;
 	}
 
+	/* wheel movement event: 16-bit signed delta in HID++ ticks */
+	if ((data[3] & 0xf0) == 0x00 && size >= 7 && hidpp->input &&
+	    hidpp->vertical_wheel_counter.wheel_multiplier) {
+		s16 delta = get_unaligned_be16(&data[5]);
+
+		if (delta) {
+			hidpp_scroll_counter_handle_scroll(hidpp->input,
+				&hidpp->vertical_wheel_counter, delta);
+			input_sync(hidpp->input);
+		}
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -4379,19 +4407,6 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	return ret;
 }
 
-static bool hidpp_is_bolt_child(struct hid_device *hdev)
-{
-	struct device *parent = hdev->dev.parent;
-	struct hid_device *receiver_hdev;
-
-	if (!parent)
-		return false;
-
-	receiver_hdev = to_hid_device(parent);
-	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
-	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
-}
-
 static int hidpp_bolt_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
@@ -4553,7 +4568,9 @@ static void hidpp_connect_event(struct work_struct *work)
 	}
 
 	hidpp_initialize_battery(hidpp);
-	if (!hid_is_usb(hidpp->hid_dev))
+
+	if (!hid_is_usb(hidpp->hid_dev) ||
+	    hidpp_is_bolt_child(hidpp->hid_dev))
 		hidpp_initialize_hires_scroll(hidpp);
 
 	/* forward current battery state */

-- 
2.55.0

