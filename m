Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30353164D9
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771577085; cv=pass; b=iB5N+N49FglezNa4FIZ1HZd4/0IN7uEDN58BMmamxGkcExDmChJ1BXV8TBTdi5qTNJbns1PnMB68FarfNtism23cYJG86TOad/Mpx7eDkXk9/qugaCAq3ztf9S1r1wdiuvTOzLEQKg8lwjqZuTBTXjOemO+339vGL1zylIH1Aqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771577085; c=relaxed/simple;
	bh=D1d3nMZ8GciEhhzINPmS47VAgCmnA2SuG+3VbAKzaDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LJ+MnTNrbX6DVwRCww2uEys6jvLjCk6lXAxu4S1ZfIeR3bwgRC4A/9vafDiMYUA/i/vPtBFVHXsRZQtgiJOkthGItHRgtLYtGrIz4141qMUMZ8GufZa5Aiiyjn273lgTWrj3hwbOtfauFB+Ua5bY82E8u4YNDwgt+hbb2BZThDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiwRkYjz; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiwRkYjz"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-386714da2a2so15529131fa.1
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 00:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771577082; cv=none;
        d=google.com; s=arc-20240605;
        b=Plrh+3f6BNupwLNJ9xo0nbOytr7hClaMM9UvghP/2CO4R3EoTwQ0MwvTt7wMMQdtxD
         aJKY/dOB+vUMMm7bL2lira+4QuAvRiFU6QnVwtNrgwzfM1jL2s+kuZ1uVTY9EoDHZ3Fd
         8NAp6s/qP+6LWYNhfemvnyQdTiSv5i4B27WEc1gkM+NSayy6hI+EM8KRVnmd/QZlMe38
         V1ertVRcMEgx66hcDWbbBhQjfYT/4uLUS5RjGTpwA8XRapC4u1uC7eLY72LwAVSTW4+3
         uNaCFFoxXk6latGqzTp2fOCAdbiyRdb8grBUiXCF+5ktg7Rjc9+LxRcicLiBzC2uwQqt
         sMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8qKoRJoGoOXyGG+ED8eoFULD1E8tDVSYzdIvFnMgNlI=;
        fh=aU9qPfDfLJEZlDqh1q6n6WY/02+PfIDt4/JLaGomBu8=;
        b=hbekzWr0GAHgreDIUanVU41PwGVIgwV74LtzEKQvBNGWkB9qz7vFwZ9MSiHuPBzYN5
         9L6P7joLc++vGPdBdl0YFbZ1McWL7PxBWS8q0G3a7EGblwUqwhrq3MK0rb4vUxyblBxv
         7SfBPzr0bhVr1FLWPxI4BigJfZZUP9Ia0LR8xxH8r+YS26hFf8BL9tsA2lsy/2yoC1bX
         ZBi1rM1/XKn4IAM9Azc6tjbBTN69n4QXol1Sc81RcZ4k87vP7keysb+CXPpW41B7S3Rv
         sF/FIVgAOiCTmWk/Qp4VgtHqnyujGvQUxPm/WS1plFaaJE+H8kWVSzWjWT87NJwzLqEN
         0g4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771577082; x=1772181882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qKoRJoGoOXyGG+ED8eoFULD1E8tDVSYzdIvFnMgNlI=;
        b=fiwRkYjz4FvCoTHtM0lk15LPfBCK18RQXqxAm9ajbAPhBNi7FJkphzkMKt6GSEZ8ZI
         lLn0BY3XbJhTeaubsWSD/NXiCbvD+QkAB2ISyOGUAL9MDLdEwDuaTE0wtfiEgXIsY+Al
         qi3egbu2aPnZWVRNSz8ZUfheI1teSRJ2CF+5Qk+/AqT3r1vfn+kaRlGmLofMgybKlBvX
         QhFQA/lwxEZglsiriPjWs45SdUqEfr9XMl0aEx2IqVJQaQ1EI3go3JyQpHhcLHkjdRkX
         VBoLcO8bBGb/PX7+27jHyA9v8rvtkbs+8Df28NMFziN2GendAS5BH2ubgMlAwTjNoSsk
         bP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771577082; x=1772181882;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qKoRJoGoOXyGG+ED8eoFULD1E8tDVSYzdIvFnMgNlI=;
        b=jHRLXbnYFI37xviY/ta1Wk0XaWRbLa4fxE9ONMya7Zqxc0vq0+fPjdqrq3XcU7aNC3
         OXVQgohXpR86yZ7RqcgIBUpq3MeMpYKy2FDjRsD5h56Ex6niU3Fagg0hcI9HJlJipACj
         dTzzubqGDnJ4hlZYHvHGp7Xm0Lgj+ACUJh94UCszRzjuw21j9/ebA+LQgZEwIKbnO2my
         AE3JfQZSC/dAdUi+QZTKFpdcNXMsO00BEPD0Gs5HTwbibuoY7MjCTYGkVOAieNb7eJTG
         xLIKsJf4hAaRMFX4l570Puu0O6hFevf/56xnvNGIdhwhmgovvTlaDjnkWwbEZW70x5V3
         2qig==
X-Gm-Message-State: AOJu0YwBC4rk9Koe2OHOsmJ+H9vFGlB3fFk/QEVMbRX8tI5UnDoQZmyb
	byXgZaW7EkA3Qvi2LGuxmVNAcHpfT16lZHm7zfStjeR244khOLlx4nu8teM0u3lMjc8o+5Sps7t
	HmwZr9SbhStoiuHqBsDAYEznqqhjx1EgEPT80KOA=
X-Gm-Gg: AZuq6aLHMSbGfNldgKxuOIIaZqtEzAKcjEyMf8E3GpFbJPp+9ORCs2H60YIy0fDzzoJ
	Nuf4nZ7k/83eKFtXwPkmAY7LBCNwt7nMsMPJk2oY7HS/4yh5+a1v3x6aK7RdmCOKSSgM3twZGYk
	2dca0wu5Uap9reXyqkHpZ5TPId2laPMhmMtZuxccgAJFJ6lOnNH2dhyhKSGSMlSc5WYoDRxJC9b
	q8HiMo/ZFcUz4gRWaJAHhoECYemZIzquoG4qdm28X/e3AL92TIM/MvDw5A9hqC79z/bFDHqsQ6v
	us6S9gbu
X-Received: by 2002:a2e:bc81:0:b0:386:eb27:8ca0 with SMTP id
 38308e7fff4ca-3881b8b436cmr62469191fa.1.1771577081418; Fri, 20 Feb 2026
 00:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ariel Silver <arielsilver77@gmail.com>
Date: Fri, 20 Feb 2026 10:44:28 +0200
X-Gm-Features: AaiRm507GrU7GU8euPW7vyh0hEPKVj58rhtMZtN4UCnPQ7GXH9v7SAX8gMuaR3Q
Message-ID: <CACKMdfnPQoBnEhP0oCe1gXCYzJYyWBJsgHCHiMOn37XYYLAkVg@mail.gmail.com>
Subject: Subject: [PATCH] Input: atkbd - validate scancode in firmware keymap entries
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The SCANCODE() macro extracts a 16-bit value (0..65535) from firmware
device property data, but atkbd_get_keymap_from_fwnode() uses it
directly to index atkbd->keycode[], which only has ATKBD_KEYMAP_SIZE
(512) elements. A firmware-supplied scancode >= 512 causes a heap
out-of-bounds write that can corrupt adjacent struct atkbd fields and
neighboring slab objects.

Add a bounds check that rejects the entire firmware keymap if any entry
contains an out-of-range scancode, consistent with the validation
performed by matrix_keypad_parse_keymap() in drivers/input/matrix-keymap.c
for the same "linux,keymap" property format. When rejected, the driver
falls back to the default keycode table.

Fixes: 9d17ad2369dc ("Input: atkbd - receive and use physcode->keycode
mapping from FW")
Reported-by: Ariel Silver <arielsilver77@gmail.com>
Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/keyboard/atkbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1111,6 +1111,13 @@ static int atkbd_get_keymap_from_fwnode(struct
atkbd *atkbd)
    for (i = 0; i < n; i++) {
        scancode = SCANCODE(ptr[i]);
        keycode = KEYCODE(ptr[i]);
+       if (scancode >= ATKBD_KEYMAP_SIZE) {
+           dev_warn(dev,
+                "invalid scancode 0x%x in FW keymap entry %d\n",
+                scancode, i);
+           kfree(ptr);
+           return -EINVAL;
+       }
        atkbd->keycode[scancode] = keycode;
    }
