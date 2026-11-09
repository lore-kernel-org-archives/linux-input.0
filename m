Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220654;
	b=xO+gDg1+QZ4Um1yxy5MwiPf2SbLZ8oqnOKmOuXTLgaCYMnB0kvvWNA/pppdjR8KeFjn1
	 oRGSBVZ6wzaPVLU4kPfmC7AhsQyHYZGUdQX5jKNRC4fGQnTOq1mTLcIe++mifdFw43lkk
	 gtCgk2eTDLGVzV2qkOPQ4Ji0E4GuqpEyqp3KxxsqJd6GdHW6E0JI61xV4CDLRP/jLNACV
	 PJ3L0vhXJaBSDTr8+wTIOsPNbgd/hp0U/TLHwhaUth6v+i0X2z5DVZ9YBieyAHrNW9mEW
	 0FaeSVbvbBFaR+oZALr/tNvPArMxwf8IUxyQLDREx3knEF4VXDLU9aPKxL3l0URFNFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kz/dmeKzKbQwwHowV+QWdMXJ5KBnbt4jspAkyZkZbJ0=;
	b=dDhXrTvHy2SrY9dLcyoNbPZw4Rhr3sGmornLwmZSDrapGZIOVPEjxR4Bk2LtY4YvtOwv
	 l6fiN0N43G6fu/ovfTsMeyCGPAJTPrjuhrm2bx0x/RaNyPzU2/tyCdQZKHzE/dNwVmebV
	 qxtRzQYd9AyR7feZNmQryqjGQvSQYl8efyDrlr5JTvDgD+qkS9k58Hwi9RB4caYQmDbpg
	 XgC38j5JzR/qy5NVeRuCQl4GMmimMkl7SjqP/KBtbx7Q/RI9Sw+ZZY4fTiaS4DsWG1Gv2
	 mzEVMtX6QyEt2FiSyUR6jmGEz4JKfZwHig6uTZBtO8ikgVdW5qCk4686jtcQX1CZxvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y8qzmv2T;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3C606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y8qzmv2T
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso4411715e9.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 02:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220652; x=1794825452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kz/dmeKzKbQwwHowV+QWdMXJ5KBnbt4jspAkyZkZbJ0=;
        b=y8qzmv2TlBC2ZTn7I7/O/VIkfIHXG6tvirFKNI0SyS16acPzQw0xyb+5XzuKL8G8zc
         NrFBOAUUNYbOnh6BLyP8mrUHu9fN7EI7u4g79O6Bd1Nb5hAwrzrZamuFcfI78D0hORY1
         HQtoHzBcallBLITxVwajD2qbKg/1jKiCPwYGLcw2usuUZO+m27HfgAXwhwBIsi3MI1bR
         RsAQKhW3OjCMmjQBPY+UC2iYZSTMXattm3ZKpnXaRengfpHBntsL/pExGhqGN0wU/SLH
         jDXIdati8+Ys7gnjiymWD+LsJmqldy4Nm9jXywXFn+YimAR1lHWB2KSXe6/Cgg8+P3fN
         rauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220652; x=1794825452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kz/dmeKzKbQwwHowV+QWdMXJ5KBnbt4jspAkyZkZbJ0=;
        b=TneTZsA7OytC35cxVuFDBpyoZx03wLc43DtqQTOG5tpb2N84u0tz7sa72wsPiHoYkO
         9d3h/v+QlSOeUM0L5tYeWJpToIRIIb0AikRK3Bat3eZDLD2W96k9PfiJ9lBYS+zPPEqj
         xytiQnhoLd2lvA8jD00pEGfMdSaZxjcxKWNcNESeM90QqpzbD1qr56tkhgHPintMZfck
         lVNkJXLsZ9IAe7iJB0ZPZCHfgUxIfs6xdz0bebtf5h7zh1MSTp7CZF37X8WU1/G2hgJn
         C3X8M9SiPYd99Nm9VhU3Uc/waLrrPsK6GoJuEnu5YvjYddcVgpyC9fWnYGnayKvZwXkq
         j9Xg==
X-Gm-Message-State: APuU4Z81YXHvpYME28ucBbx+sEcgHtCLnpEDb4CWTFzHIMx3wgmC4caS
	b0baslzrNxcIhEBBSRrWe8+p3GGzK4cnI8wYJPIzYvyJI1JL0yTjXQeOGnMRoNIk
X-Gm-Gg: AYBFou0zB9QbXd7g+CKeMbJ7+DHq3pLw8h5jzbKCny51JclU724rC2Ua7S1Dex71mmx
	UQj1Ac8R6/XdtiXQ1039ql9XPaGoU6m4UqZA4z/xEz/4N3sdWfXM1k52Vfhlth3m378+IQWY0SW
	J0PiYHAZqLC1AlHxlU3y5lTT1RV2AmipvpL/TBjtpjuXPm5qjHAc92bVpKU7mQAlNJv8GioGYiq
	0qXiGAGbS+1PUKyjTRd3sznR2nR9T4AZTniemO1qBsrZf+04jgfjh7Wp7co7B1oWFzpKc/ipHOw
	nNPMahVVwgEbu3ZwjY2xTiVIwEqOiM8LRHXIREuFluu2idu8CNwAp1Ccn60Y6BaJLHnb1NA92GM
	oETIWRC8cDEo2riN5VqAkI6cIlcodKOrhZ5Cf8L8vZtzuvtA0X1nXYLoFZgus+8mv6ORmA2wNRm
	SRMPvdT6qmTimlY0H7hn6MDizUbBqbmhhicggDILARzWCKl0g9dAJli83V8bmzAnKoT/caSPTW/
	Q5LZVmGb52/fMx8VPf0OyRGLO9NaB4xVVyKIGSODQkWtDz7nsey4F5MPmKz5AJ7BGbKd87xaYYK
	WV57uNnK6Mgd3fkFQaoNUny3Sr1h0WJPzuVVCfBWBNZyostwQIb6tImwOPM3G8xZby9PzNRR6Q=
	=
X-Received: by 2002:a05:600c:8b24:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4b963c82388mr57769565e9.31.1794220651842;
        Mon, 09 Nov 2026 02:37:31 -0800 (PST)
Received: from acer-gaming (121.red-88-28-14.dynamicip.rima-tde.net. [88.28.14.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bbd2sm131229405e9.1.2026.11.09.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:37:31 -0800 (PST)
From: Juan Parrado <jparrado.1817@gmail.com>
X-Google-Original-From: Juan Parrado <jparrado1817@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Juan Parrado <jparrado1817@gmail.com>
Subject: [PATCH v2] [PATCH v2] xpad.c: Add support to Hori Real Arcade Pro 4
Date: Mon,  9 Nov 2026 11:37:15 +0100
Message-ID: <20261109103715.11017-1-jparrado1817@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAFkAFXq-avEh2KP5vdpzK1cxvg9X+5nwc12-5m3NG47Kg7HWcA@mail.gmail.com>
References: <CAFkAFXq-avEh2KP5vdpzK1cxvg9X+5nwc12-5m3NG47Kg7HWcA@mail.gmail.com>
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

Add specific support to Hori Real Arcade Pro 4.

v2 fixed format

Signed-off-by: Juan Parrado <jparrado1817@gmail.com>
---
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

