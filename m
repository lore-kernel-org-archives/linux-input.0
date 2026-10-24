Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860061;
	b=vkMWECJM9YS1TH8/6bNj5iDhgdeBQHnVgICxLW0c4viJCQxwFANpRaL6PzZ42mN2EFmV
	 M3WlI6W8rpRl516u2yga9GZSediRwMUTURi9F8cW1FLCsDAJdYIGDirsJahou6FfTQT3n
	 jyVcxZ2bbzz2gOmh7Mu5X7FiHJz1Fzy6gWGGIj4QCoTyvaCgE19VsnkKrC7GC4qUFxj77
	 1xOPRrtnDwZ/B3sLYJOiYfPG9JWDSaD6VCLeSd6YRV54TRczuuU+8CXK8V1jkItdWYtv9
	 ZvqRzIrsxp7+4N0jK6JW7ogvwYqbsPVEPcUhTZWtjdMCPebiXgCFbvv2RJdiVcVwFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4ad2t1zV6rs5pu/uMSIXOceDk/PN6jJRDopGqycYU6c=;
	b=01r0mXDLsW7pwElHvoCF23mulCjKxf8MayFB5nalNNaNLF0ZmKDHUW2LPzfQwwOIuleQ
	 46ZeFzaNvRtUrXB8FMmGgcitGAIIf1JIl2v+0o5StSGvO7NnW+UuxpjjnFfzbleiMyzMP
	 ZIBag5jHVcgKhbJA0ymI5VDvYrONaikCt9WuKc5ul/4JV1MPKLFvhdZz+1jif/myrhLwz
	 tL8io5YNNqeqXMuQws6ab4Xy+hfl0jkzZlDXbJ11qgqKMNHc/2WOlqJ3H0LFXMtYy/HqN
	 AZmoMjqZzKFsv8o0aJFzhcR0Ml16TXB1wlyTAPLxOQie8TSbEfZ/s7wae2Z2v7i20ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UA3m39+a;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016C606A31B
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 16:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0016C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UA3m39+a
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2acc1e170cso253560766b.1
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792860059; x=1793464859; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ad2t1zV6rs5pu/uMSIXOceDk/PN6jJRDopGqycYU6c=;
        b=UA3m39+aydE487+brVOvdcQ8P5KX5bhUq1nBcEroq+ligZ72r9aPTJJCQZbjjlfmPV
         +ndiDboTvMc4BrZq7/RyKcWL2DDxXM7hRDPEgk9BaG+WbtTjHgbtcZU3P3o4XVwNE3gX
         B87a5c5ybMU2RzhmaeZ0wTtoMtNz2WECtnqVOV1+sgB8W/6TR7PYMne7y4RcfXM+GdgP
         LCArXuyDBjjnz2aS6KosvEj5uzxZZqJ4nC7aGqGFWACNSjQgLDKGq83JnveJWYCalUaH
         tPjFyOhUUkPWRQBevYDECG5A7svGbU8abcxIwM1pKmxKRynF9KYR2KW2Of6krZ9zdX3z
         Sl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792860059; x=1793464859;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4ad2t1zV6rs5pu/uMSIXOceDk/PN6jJRDopGqycYU6c=;
        b=PTbEO95Opjx2XLgOCzEBsh+KF95KEqDlX6k1KSrfIxj4KsMdEsTVeT8yzgUZlJIj6Z
         w2rIvK5keNzkoMT3XeJjZKwKhJ+OIBAhK6y4WoLYaDGRVHOJoDjD94vyjQ2ijIdxAg4+
         F307mY14dVmYKl3fs8kmyvv/6MfxTHEXcIr3uIG9R2fajzTfHJMUIY1kpMolnm78awms
         PpRz4C8ZtX6mwsuUSaCrFEVQoC6gHJ45uLiAdQkqVjWCyRwe6iEKm9z/Zu6OlzqI4IOv
         GsBsv1nmursFG7HIMCgiVAMoC3zxEqbjlP2u+777vxbUTOcfed37b/EyB2vBTOWdig+H
         1zMg==
X-Gm-Message-State: AFq9FYIChZcAOw8TaObfsUlCddaNpuLZIrFSqGV5hLSfYLm3pwNdNEvL
	s+dlwD+X/GewR57uF/7S32i3O57HsonRN2t73JjZnqkXYjom7Okqo+HV
X-Gm-Gg: AYBFou28BufaM0LcLOIzoGqsTt4SSvF+Lh4TIG1Om71k/xfKznr6oqrAZiGMXkR4g7H
	vOrdYXeZr1EZdc2wknJHJE8EwiQjLdqk8scXPM2hkStb+Fil41OnPwDDSiJdC/3tXq6AByx1jHN
	Si6bekmQ3ylX/7JjAtT9WePjDeTYUpyvPHSuR3LP/jH2INKJdQLkDobkyOxy5JktWv7WhbyiddK
	KycadpivIfgAy8bilsdJwYwfhw2HmnfSnH4Ld/YksHDgi99mfRFGRDUUZFVx3V90+KdYkLum85w
	beyw+rJzsTMfareJboXz3BBe8PxCCLaZYS20iGWbz8tVufELnPxBISgUqVI49uJUm7OWUsAm6Ky
	XNkdatlnRYqP1j5LI0eJ7vr/1fGICqW1bJoqh+daAiExFnzAZAWhpgYyuRFG2ZMjUNa+EWdUPTi
	EaaOw80oBKbhrBkNaU1gHnoc7FL/S02XRZn661EqpODZyna74HF7HBJrYA2BgOSowZt/a+xL9Md
	DAEoDdglVTOWEnsnCy+hI4C1VXljGQTDxIGpGIfUtpYtgc+B1JpdqVgnnlbBy85bipj1FVDqjrs
	ZiN+DwXBkgft+ZoAHjjaTrZt
X-Received: by 2002:a17:907:3e9d:b0:c29:f5d8:9c78 with SMTP id a640c23a62f3a-c46bde88fafmr273566266b.39.1792860059082;
        Sat, 24 Oct 2026 09:40:59 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd524271sm110499666b.35.2026.10.24.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:40:58 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Sat, 24 Oct 2026 18:40:23 +0200
Subject: [PATCH] HID: steelseries: space Arctis 7 status requests
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261024-feature-arctis7-v1-1-583951aa6583@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBPMIqOrRAvTsWZjMVYE4t2Tl
 m/xf4aETJhgEhkYH0p0xIq2EeB2GzeU5KtBKz20SvcyoL1uRmnZXZSM1H4NRnnjsBuhVidjoPc
 /zkspH1P/X2BhAAAA
X-Change-ID: 20261024-feature-arctis7-2dbf70d7ce38
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792860057; l=2998;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=Xu3sgi6/Q/P6fbXoUGNE8eUPeai1Rp0Tp+TfEJXdUww=;
 b=bqKh6tUQW8kkunbRfDPZRBhv4k8kUfFiuD9e7LJVXO/DLuFTJ7VJda3GNoKXXgG2x7WRXVXd2
 xhU1Q/pOYMyDNY1OlHQAD+ZjaVDbyct3NUJAfl32lIXGOONL7JadcRq
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

A user reports that the Arctis 7 (2018) frequently reports a battery
capacity of 3% before returning the correct value about 30 ms later,
causing false low-battery notifications. In the reporter's tests, this
occurs when the receiver is connected through a USB hub, but not when
connected directly to a root port.

The driver sends connection (0x14) and battery (0x18) requests back to
back. The spurious battery value, 0x03, matches the connection reply's
connected value, suggesting that the firmware may return stale buffer
contents when the requests arrive too close together.

Add a 10 ms sleep between the requests. Arctis Sound Manager uses the
same minimum spacing for this device family, citing the behaviour of
the proprietary SteelSeries GG software in its configuration comments.

The reporter tested both versions on CachyOS Linux 7.3.0 with receiver
1038:12ad behind a USB hub. During separate 60-second runs, the stock
module produced eight false battery reports of 3%, whereas the patched
module did not exhibit the issue.

Reported and tested by a user who wishes to remain anonymous.

Link: https://github.com/loteran/Arctis-Sound-Manager/blob/342194fb24873b343a4b38336aa14bffabfe6e09/src/arctis_sound_manager/devices/arctis_7.yaml#L2-L3
Fixes: 7e749a797282 ("HID: steelseries: Add support for Arctis 7 (2018)")
Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
Assisted-by: LLM
---
Add spacing between the connection and battery requests to prevent
spurious low-battery reports on the Arctis 7 (2018).

The reporter confirmed the fix in an A/B comparison on CachyOS Linux
7.3.0, with the receiver connected through a USB hub. Their reporting
and testing contributions are credited anonymously at their request.

checkpatch warns that msleep() below 20 ms can sleep for up to 20 ms.
That is acceptable here: the delay enforces minimum command spacing,
and status polling repeats approximately every three seconds.
---
 drivers/hid/hid-steelseries-arctis.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index df61fa33d4c6..dc5a421e8d76 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -6,6 +6,7 @@
  *  Copyright (c) 2026 Sriman Achanta
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/kref.h>
@@ -111,6 +112,12 @@ static int steelseries_arctis_7_2018_request_status(struct hid_device *hdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Back-to-back requests may cause the device to return stale buffer
+	 * contents, resulting in incorrect battery reports.
+	 */
+	msleep(10);
+
 	return steelseries_send_output_report(hdev, battery, sizeof(battery));
 }
 

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261024-feature-arctis7-2dbf70d7ce38

Best regards,
-- 
Erik Håkansson <erikhakan@gmail.com>

