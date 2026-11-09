Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253341;
	b=KgeGPcY0GwuxeZlBxbdkLXRQoW4e9tdOtp/Dl4jmrD/umYzYFGF6cd3pbvK0nqYykhkW
	 QV/HSnRdaQyX8ACMUdAqzltUIYaK2zz8Nd/LehqU0xG8VVpEikXpMpoySogKA8ERnGtu0
	 IaKN+EIWQgNfVc9+wXuGh9wztnypuMqqx77azVM4A9B2pdViHH58GfuVhgSc07IGlSDTy
	 3yDxqnWuNgMs23w0fo3GDb3GvQFg09OmOMQO27gFpAiGsqBsXSSm3wBiFCnCQCknu/5pg
	 UB82rYltM2OEbpd8pp3yZy8sgZsMJMNOyc/jdD3szKcd4u0nWhoEUkTB+sAko6L9gPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mbBQPOCqIPjbtfPgMbeVngds0pJQUl8FFvkH7QvbAp4=;
	b=PHzpODnv6tWwu2GrqL+pL67LeWLSVJgk6FvQpdqhE4NlM6X37alfWnDezvcBybvBDDpC
	 vG9XR97ELUCI1Hfm0FOjnyiJioPipdaUigcljbHXSOVBRklysioufbjaMFg/cUbyIHI2D
	 gIIaMf9l6xpuh1yKw5t5GrcWQAU2yhHriarpQHUCAe9qS0rrmqvVrWWWXSH0tgq/zMA48
	 4qRLanqQYthfN3g1dMW16zKDNjtkbpvskqsf5Gxo7j4E2mVd1LsYcPMua/LAr85gVdQqt
	 eg2Xx7YnKuAQ9KbEdtp/A6pJXn+mXEmNl4ddNJ44nVy5lSr7DMjTbAdo3xZpcgofMyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9DI6TLu;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1483C60A2633
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 19:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1483C60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9DI6TLu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so13830715e9.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253339; x=1794858139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mbBQPOCqIPjbtfPgMbeVngds0pJQUl8FFvkH7QvbAp4=;
        b=n9DI6TLuifxiNVwKA4DznhzQkifoSkSXBJTCVttgS74ke6jNV+089dK0UaJbC4oBUt
         a63pXZLc44ntIvFKJI3V5EtsJ4nNoIpB0BYnkD0T+ETOTGcO86bRxkHso4L0cmgAEyN9
         IGvNb4c8YlEfmHRCWXtkoobhkSBDGuXvh76wze+orSOlEvUL3E/GcUQPvavtFIYwENz1
         Wj+RPPvjfMums+bR9OUFs2N5v6a0H5hRE/tXRRf3isFmBTFLF4jwTcbMZFVCv+h5dzTN
         RkOa+02Y8zJHlhgeD+e3VBUZVVgqZ2bt93eqvrP7sciut89gZAWtDZUlkIMiUNZVbeC+
         Wu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253339; x=1794858139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mbBQPOCqIPjbtfPgMbeVngds0pJQUl8FFvkH7QvbAp4=;
        b=fFfE6oRAGf87CeHCgQoUhCsGEEImWo3Kb+ekCxHNQUyuErgXQjEmRIWqeVRg7YgiMv
         pgz3tZUzIeW9q/DBj3B8eH0QcW4nmYxeJGkFm7hrLR0JvsZJeAXME+HN6dVaX6Rz7wk7
         7k7d1d2Vf0HfVBqakp8mn1AQcWxUV0ABaEk6Y1puIkFTUsO8V2ajJzzL/nYFNR8WrrRB
         AdxAC5UvwCVWJGXnbxh8kSsEPzfUYJtZpz0HFYUkbLj21v/Famuy+tRc6RmVWlmkX79F
         guJgvCdVbNwhvvOagExynM7S10UEgWz3X6A7iZ+76lGtHnd1xVDWw+ItVMVJKOvoeeic
         k1JA==
X-Forwarded-Encrypted: i=1; AL+hErGe/qjtn+VCFxuBenZmbbOLDDZjg/3r/rSmkR80Fz3Kb58A53HX6FtblOHyEfUIxOIlR5s4AfK80SDRKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oXobmrekc2P17RcQfPyo2rnTLe3VViFN961B2kIJuyHgx/J+c
	GB9Ubp//TKjcubwfBtULOed4smrpbXb9PjD4qsvzv5+eO5W8lZyvlV/u
X-Gm-Gg: AYBFou3+MBd3Kip8f/4Ltza3ODtLWh8WEgy773B30FopUKbUsjQAlqO6ICLaaA8ym+Z
	mWTmYNJ0DaGD0wSl98m+a0l8zZ5ZJUT0NNpKACqWQKexh61obgYlbnCIp5yCyPf6olCKek+kq6T
	Z7hvWqXP3oemjshNMm6ac92xdHZY6in69FlKBDnPeDTbsUVSnzqCn8o3msCX6HTgZ/oq9DaOcQf
	ZTipe+FbWUzdwjt0epKoOIxFQlFc00NgrORCyGhu/uiPkKW828vQwuHAzV0FUqbLglvEBD58mhr
	vBlCPG9P5aQzG0WqY19g3GB5HPndX6fSXxmNmKO3lSk1jZGRLUuqOtp80gtH+yTbLcyTWkK4VJl
	KShWktZTu9vdEEUy+rcQuh/jV+KfsywBTTB/17bc7SO8+W0VATd0MsdtCyvJdqWS+2huGe1eJ/5
	L3xq3H/OzmVm6rvzpGoQnDAPSOHc/AB7ZqEpUbEd+OR+1pbA86Q/am7pDg61F0qSyMBU4M0zYPQ
	UbIU1a8jSEBscDp6ctWA8TyRSkcG+trWG0c5ZACicXnlLAEnR5U57zIbdvUvx+chhnlhglPgQds
	SMH1ccJrrZFmmDytElL8m6ceJUBO7FE7akTpfGBWL75F0wrT21ILChmhr5zXfrhPwnEwDI/X1w=
	=
X-Received: by 2002:a05:600c:3b2a:b0:4a2:148b:c88c with SMTP id 5b1f17b1804b1-4ba0233f98fmr4406435e9.8.1794253339265;
        Mon, 09 Nov 2026 11:42:19 -0800 (PST)
Received: from acer-gaming (121.red-88-28-14.dynamicip.rima-tde.net. [88.28.14.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fef675sm9446975e9.14.2026.11.09.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:42:18 -0800 (PST)
From: Juan Parrado <jparrado.1817@gmail.com>
X-Google-Original-From: Juan Parrado <jparrado1817@gmail.com>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com,
	jparrado.1817@gmail.com,
	linux-input@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Juan Parrado <jparrado1817@gmail.com>
Subject: [PATCH v3] [PATCH v3] xpad.c - Add support to Hori Real Arcade Pro 4
Date: Mon,  9 Nov 2026 20:41:18 +0100
Message-ID: <20261109194118.18127-1-jparrado1817@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-204846@kernel.org>
References: <sashiko-outbox-204846@kernel.org>
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

The HORI Real Arcade Pro 4 in PC mode is currently recognized by xpad.c as
a 'Generic X-Box pad' and works out of the box. However, this generic name
does not match the actual device name, making it difficult for users to
distinguish this controller when multiple devices are connected.

Tested on physical hardware. The proposed change works perfectly as is.
The MAP_TRIGGERS_TO_BUTTONS parameter does not work here. Other arcade
sticks use an identical configuration, such as the 'Street Fighter IV
FightPad' and the 'Hori Real Arcade Pro.EX Premium VLX'.

Signed-off-by: Juan Parrado <jparrado.1817@gmail.com>
---
v3:
 - Updated commit subject and description details.
 - Fixed metadata and updated patch version history.
v2:
 - Fixed truncated code lines in xpad.c.
 
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782..2567ea3bd 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -255,6 +255,7 @@ static const struct xpad_device {
 	{ 0x0f0d, 0x0063, "Hori Real Arcade Pro Hayabusa (USA) Xbox One", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0078, "Hori Real Arcade Pro V Kai Xbox One", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
+	{ 0x0f0d, 0x008c, "Real Arcade Pro 4", 0, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x00c5, "Hori Fighting Commander ONE", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X", 0, XTYPE_XBOXONE },
-- 
2.56.0

