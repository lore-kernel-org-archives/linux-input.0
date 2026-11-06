Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994058;
	b=C4sw0fVZIOey5BLi5mR2gSKX1fOgYixFGBjnu10JvlsnwXoOwPZxrUbO53Kp4Eync1WF
	 I3wL8o7T5TLK4gpy2qZgrgZ3QbBabq/udmWIzEE6tKl44G8YnYblsvKumkUUjeZP9lk42
	 zssFGDI6+ZZDR78DVl/GRjEHjVkBR/6mLFOIlv/hsQ0aT2mc8uStpcRc6GCZnepZdgZth
	 MxaiM7gB4/iMecz5ci+9Wl5z3YDdEftYU77shTQzNQVgMzYYNnM0GKnNDCpFYCDpHeBvq
	 EHhShhd9LLD8K9ZlCfeJlvdtpn35JCyyvJIDEooBZBbZgmRHE06ii9gdI1Q3OhF5ugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:User-Agent:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=lItl7Ks3Ko4mpofEkC41Hng8AAxtpjFcDg8vOTtiDX0=;
	b=k8CiHtJ3hp/ocmbKoF6lKECm5CsDrkCms+lAg3DBanEa05SubYk4o3jZIG9EGIz7sovL
	 FybS4eUMgTgHLkEWUdp87nkcLyd0HX2x/IK7kWd08jexXmxkyNjI5Th+Dut7VskBgquTG
	 1w616yCEynoulkYwsKT4JyBHjOO60hW27iQSXii2ie+JqFTkELG6M5iRzJhAllhHFJl8P
	 taPAGoKEMw/3Bhm+4dodgI3nLZqvCB8Y/Q/4fGj3k5IOA9mtO/A68+Nn3UVtNZBWDHCEu
	 fpMXMaHFRNkdcp6nHYOlTsYyDwcNyALNot3d86qHOLw5/wpRJrYGsaUcIHsAxg0weuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYGwVGrP;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE56606A32C
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE56606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYGwVGrP
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14fc585291cso942008c88.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994057; x=1794598857; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:user-agent
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lItl7Ks3Ko4mpofEkC41Hng8AAxtpjFcDg8vOTtiDX0=;
        b=lYGwVGrPHdswComoR/WYOn83ZRLgSC0gUdMbJ7VvvuwEopi+l/+AhzGKpBvOdnU5I3
         ZFZ+vJrdP8s6i1IZDNYvc5FfKe5snxeA6ZJu+FvJ5EO79lfjcBxZO0Vnn8E4xk+xTNdV
         4Ca5sXwz06lkq0t1kiHi5HzP3lHgKi0Fvi6ejn6ryyNB4NoynkOGSiTzH1N60VF1xqdm
         LB/hYxIjaC57x3UMCOBsTOwxwC70fZiwv7x8jyBVt07yLLyNMMhTqFY4r2GHmGGwa4GZ
         chSPW+hZyrzFtb60FUQDGO/rntRxB/IDcIhlJGk0/kGw9sJLO0SKUOFQIA25P2nhHCUC
         mGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994057; x=1794598857;
        h=mime-version:content-transfer-encoding:content-type:user-agent
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lItl7Ks3Ko4mpofEkC41Hng8AAxtpjFcDg8vOTtiDX0=;
        b=zJk92oISerwBAIxEv5ZI964s2gaskHjIp3HVcxyO8LhStl5sLyrbUv9n8korsHXLeS
         Nim2IOKbBP/EhWmZQNfFCk+5IhPFpzgvRW8Crz5SDjgeUnK0s5w4mmzIG4Q31Vt9Sjdc
         sy+CBAef4dn6pYlv13WnN/+MnVJrTTzxaoEPU0AUytR24/+G213axwxmdaLrw0LoHn6g
         r4iY/UgcID3uZmwAy/yKnR+jVA1iDH4YcRiitgIhYDQ7wH5RyIfXR45SYkdOUdXos0/X
         5A4k9F26140GNSW7rC2WigwH4Uga8rtPowWUw0Y3126XxfzQy9Gn9At+Tdn7/4oU86kA
         0/Qw==
X-Gm-Message-State: APuU4Z8k914TIU2o7r2k0EDdYUtdOuxf1HvdBmvPyERBpKxKOpFdiiRF
	B91VfA3MeZ0TM4ohiY94SkuNdIbswcZ965oYDNGMc7uwJJH3Bw3hZOPS
X-Gm-Gg: AYBFou0pvt0pPEaP84rlTJp/GB6QsTRPH+6Q9B2KSUm6PVG4N7EVzC2V7ash7DBuJt+
	fAnN+WJZ5KScsVkbLQTXnPGhbH5VJjUKMe7AAWS7mnt2c0G8QOd2d9pUydhMyxBN9amOjvl5evZ
	DeByJgjJZtD5ZY9nlF0ts6Y7N11mtklvYacYpksZ7478Fr1sK+/en+PuE+Mw6EARwnSh22gwWVW
	QDrNTqibzT3gCSWrZlENgFr0pgHkmZB1hd+GGDUYIISezNtKXgyni6+NmqC2NGIunNXNVQ54nyr
	WX2prow0vZNbMCIi1CgxCL21vyopCcWkMgRKAB4dFpw18qGW8D91QwsfhVFdWaj4J+au3czhpET
	tIyUUqaQV6IOpOiTlH/UhaxBXeUXef5wtdt9dusqRCOuunQr2h4lLcoxMRrolS7miRpw9P9/DkK
	8NZWWdTJz8R0Z0yW2BCTsu+j4Liuxy6E9EMJ4RposXW7qRy1LslbOK6nKU+154RA/PtUB+6/Wzw
	BBOzRmvUuu/1cobLcZAZdX5hpd5QeCssZGH9jlb/g0O7GF6MPkI4reRcHACMYBgSRI9+BsIsFnA
	ELbm2KyQQ5NzESDXytXoaBk=
X-Received: by 2002:a05:7022:286:10b0:143:6525:f9f6 with SMTP id a92af1059eb24-1b25d2f7929mr4156861c88.13.1793994057316;
        Fri, 06 Nov 2026 11:40:57 -0800 (PST)
Received: from [127.0.1.1] ([2406:b400:21:7ec1:90d0:3395:e0de:2d21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4c1df6sm7788930c88.14.2026.11.06.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:40:56 -0800 (PST)
From: Vishal Tyagi <vishalxtyagi.oss@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 [PATCH] Revert "Input: synaptics - enable SMBus for HP Elitebook 850 G1"
Date: Sat, 07 Nov 2026 01:10:52 +0530
Message-ID: <179399405216.85438.8327280593401118083@gmail.com>
User-Agent: git-dispatch/1.0 (Linux x86_64; git-send-email compat)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

This reverts commit f04f03d3e99bc8f89b6af5debf07ff67d961bc23.

Commit f04f03d3e99b ("Input: synaptics - enable SMBus for HP Elitebook 850 G1=
")
added PNP ID "SYN3003" to smbus_pnp_ids[] to enable SMBus/InterTouch mode.

However, on Haswell-generation HP EliteBooks sharing this touchpad controller
(including HP EliteBook 840 G1 and HP EliteBook 850 G1), the touchpad fails
to resume after ACPI S3 suspend:

  rmi4_smbus 0-002c: failed to get SMBus version number!
  rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
  rmi4_physical: Failed to resume rmi4-00: -6

Following resume from suspend, the touchpad remains completely unresponsive
and dead until a full reboot or manual module reload (modprobe -r psmouse).

Falling back to standard PS/2 mode (via synaptics_intertouch=3D0) allows
multi-touch gestures (two-finger scrolling, tap-to-click) to function normally
while preserving 100% reliable S3 suspend/resume behavior.

Revert this commit to prevent this regression on affected hardware.

Fixes: f04f03d3e99bc8f89b6af5debf07ff67d961bc23 ("Input: synaptics - enable S=
MBus for HP Elitebook 850 G1")
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Tyagi <vishalxtyagi.oss@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a8e2a14..0d1b54a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -195,7 +195,6 @@ static const char * const smbus_pnp_ids[] =3D {
 	"LEN2058", /* E490 */
 	"LEN205b", /* T490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
-	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
--=20
