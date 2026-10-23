Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716276;
	b=tYsWuSZip5yl07f/0Z8HzqEADBKqOVK8cAniw47oh4+wwW42J4N00nfVu2R3qTCyMypM
	 ya7Vgat+Tsue08A1eHjmAoWftciAqYqSMpAdZ2OKzkxcFyUWZepM1NeMKp25l3QJhs+f4
	 LAzUjFJ99hjEeBejeutahalA7BpUvfbcsQ7Wy5qm6zKVnrWn6C2Bl4wzfUZ1C3drvELwB
	 mcTSe+8bEt5DkWLHrpkdKuvI9vE0XJjQQ76wv8t4L5Xrpg3AATObpqSwAljuVRYac425Q
	 h4pVxA5FRouMt5i67vzegJbJ8SaRyT9vb3wWXK6AEUWLofwmgHSWERFgUSpQv48W8Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=stbvk/Q4rllrKutChcAZtWpRBpIsSD5UqUSphO6Dz80=;
	b=uIn82JZzwtwvkWphuktNg0N9+nlJQMxoj9qZQJ0KJc/PBtEYwKjgDrc/kT64euHRXpp7
	 0BNKt2/GCu9RBmREdTxvuJzYfLdme6XDrpRwrmuhCADUl4vCr73Nq2t2CfCcDx2CbViKN
	 n/q/s4GBOZ5QZSikQkBek1rulZJHzQ01wk+8js4B0XPIraCP39ritV4Qf0Z4XVEo9VbHH
	 svvzWwLNmawmfmnH/mVoZ1qthEg5hvftyrtaXRHijPBAyfB9Kxk3FktwhwYXTRbyfvBvV
	 IiirsQJoALN+LudoHnw7UDTiZ8yMD0PT5Rl1QWsFq6HxQcPa6cynQ7W5c82Bz4yAV7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="T/9tDxDO";
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223E606A31A
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 00:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4223E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T/9tDxDO
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-980c4258105so234828241.2
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792716275; x=1793321075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stbvk/Q4rllrKutChcAZtWpRBpIsSD5UqUSphO6Dz80=;
        b=T/9tDxDOQD72Iun2lmGBi7dfIQ51B0WiegbeIMkKvs+V5aWBhE3aSiaQu32zpVbhPd
         0O1Yn/Ak62G3YqN/UMoju6qxIr4cR9yL4efzftrPqpvA5dm4vMCoc566dV5YmARTSsfq
         blL8NkSZhAGHcod7QtUmgZnfCWSOmLh2RD5t+BTSpa01Rr//lKBpIrUtsk7LsA6QSyWr
         Kl0mSiZ2Q58KF/i/DYM7yHn5w2SUitoWTc8J4Qa0Mbhhx2vQn6AZb9MPHcMpoBbfB4La
         Rea+gzBgCookYtMZB5krhUZN7SdrO+4BiSUQxNUVVlcDrZyNQ4K+pnj8ijHpYpdSB+VI
         tApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792716275; x=1793321075;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=stbvk/Q4rllrKutChcAZtWpRBpIsSD5UqUSphO6Dz80=;
        b=BlxVd55j011WJIfHoc4i96qcwzNwIr3PD6i3ibRlzieOKC2YHntW7m8vrsg+iowdNK
         nSBMnyuIsTjNFgGfS3i8Udvi8Tm6Qe99RbSsX8QifXrrWVJmye4JkV380ZRiI62AmodO
         gipc4QhViTd9zqsupbhEb/hpHpn9FBFZ6l1x2asJjaQ2+j8u/BthGVMCgEnRVg9SOR3k
         1VBClr4jt3VZcjcawjLhsaCi0lvmG2QhCQM187IMV4FqrumQOIHU2kZi1b73xAiBbWDm
         gJwmWZ3FQr8jc3LuffqLMQlyG88fgCMbYXUwYRUAo22NDWt2Viqf0YygxHZtlKl8QQ1g
         GwjA==
X-Gm-Message-State: AFq9FYLN1fUxb8+MfR/w6VqywyZKFWhFIKwM5VQ8XMZFV0zpBwkFmorL
	xjJGWhnxONMfXiOs+4yCPn3EWXsdGgBla3l6LQrSsNTwzh597QrYO0n4iFtgCkw=
X-Gm-Gg: AYBFou06ct+P2OAy0wOVNSinvoVMTKJ3Cox7kS9QB3OujkXWWiO1QxYCfKchwT8Xf/M
	mlf0Vy/GL2DBOcSj5V0aJ4gGHgkTJTep3LK96fI63tOQOPLgFFsmKBYQSYrarnDzFSxFJx6fiPv
	sTtZQBoIL7zGKIoVsCqZsBj6girA/av14cIq5VFWiX2iz1sxAmfBWxl3TFQY35tM6+Wby1A5R4i
	A5PRFBRQgflJpROI0/6BpczoGvmz+vAPWSNNHwUvItKg1gOvF5ADxUUEedeAJsUKiSZISmrvGd0
	rAFcNA5NNNN+T30luN5gR34L8H+mCdwUxxGpPgLsf31+0GoPbaL2+Va3dMQ6I8Z7HO2uj3nOJYf
	Psvfbv1YH/+Sa6htwGCWTyLOQVxtmQlv+68s8l4wLguIGY6l+BaNR/pfuPSjo/WQtyWIBFj6ZQl
	6QWtdBIOI3nxXkBQddc9zkHQVmSBg1pb94xY0q4MMZ0pFpjlUtQkjT4f/TocFLMBmn1WAuXM0J6
	1oHZ1IturG5ux3NmZkMxG7/I7zmzMgMHwKtb7rqyev0eGTRAbVJOl/TVMX3AC55JXiB1NKLIVMA
	Rg==
X-Received: by 2002:a05:6102:1625:b0:7a6:b18e:6d24 with SMTP id ada2fe7eead31-7ccc33488damr458301137.23.1792716275233;
        Thu, 22 Oct 2026 17:44:35 -0700 (PDT)
Received: from tatoh-arch.tailfce07a.ts.net ([66.60.20.59])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99101765cdcsm1038487241.7.2026.10.22.17.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:44:34 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Mart=C3=ADn=20Arano?= <arano.ignacio@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Mart=C3=ADn=20Arano?= <arano.ignacio@gmail.com>
Subject: [PATCH] HID: apple: Add "F108Pro Dongle" to the list of non-apple keyboards
Date: Thu, 22 Oct 2026 21:44:19 -0300
Message-ID: <20261023004419.53935-1-arano.ignacio@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 2.4 GHz dongle of the AULA F108 Pro keyboard reports itself as
"Apple, Inc. Aluminium Keyboard (ANSI)" (05ac:024f), so hid-apple binds
to it and, with the default fnmode, maps F1-F12 to their media
functions. The keyboard has no Fn key visible to the host (Fn is
handled in firmware), so the function keys become unreachable.

Add its product string to the list of non-Apple keyboards so that
fnmode=3 resolves to fkeysfirst, like it already does for the SONiX
keyboards sharing the same VID/PID.

Signed-off-by: Ignacio Martín Arano <arano.ignacio@gmail.com>
---
 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 5b32fb8c7..82118d654 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -357,6 +357,7 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 };
 
 static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
+	{ "F108Pro Dongle" },		/* AULA F108 Pro 2.4G dongle */
 	{ "SONiX KN85 Keyboard" },
 	{ "SONiX USB DEVICE" },
 	{ "SONiX AK870 PRO" },
-- 
2.56.0

