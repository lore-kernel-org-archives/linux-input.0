Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94437D121
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804177; cv=pass; b=df71IoKSn2JufCYyYN703SewkKavnx11wLpopY2wrsQSWMGNy/yj7Oj/+6EVCslTqmVzPkBjYUWhB2IT0ROp0n1RQHtLQES0LU2GVWVnr1MDeU+lWjbaEZoXdretzA+2mYlRtcSijEadJUohVopyh/e6w/YtClBi2kFzMh5UtNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804177; c=relaxed/simple;
	bh=7ESylAJMGnOGq8uN6t98ZTfVb6YRyZ5WSuZVidpLRhA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OgURYh+5L/bqqOAPnaubH3vwV+Srl+hyv7gmg8EqHcoCG7qeXGjkXkmO3jMTE4Ub51EY1XKz8H0NPfzyXN20/+gM6bwnwyQlgdYcaex0oY99coKxEeOjg47gFRfVpIbfvbxrPju+VAuZ05cmsV0kf3zqEvDi5fFD4Mb6QdfrPGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lufia.org; spf=pass smtp.mailfrom=lufia.org; dkim=pass (2048-bit key) header.d=lufia-org.20251104.gappssmtp.com header.i=@lufia-org.20251104.gappssmtp.com header.b=Tzqj/D7P; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lufia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lufia.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20251104.gappssmtp.com header.i=@lufia-org.20251104.gappssmtp.com header.b="Tzqj/D7P"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b015b2d792so481512e87.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 03:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784804169; cv=none;
        d=google.com; s=arc-20260327;
        b=BocnIETexGeEOWxxNt292n7y1gMew5afHmGKykKIfgB5uKRtU0HUxx3zvWoxuRcv3j
         7hHEFqYVPRt5j+QgiC7JgVGxUBGmNxu2LCha/9yTLJCi9zbwznHgLyHjJxNny5NNwche
         VBVgnsqi4eCr0vWhPyJzx7AvL41iajEYUjK8CrYJNMQA+dF+B25tRwOMYwTY2CkYdYX+
         nagjaC8RHUGPuTuZ/mVfoxf8ZShJmNxaX6EuT9WBCDV+d0ooSmdbUfk4r5seak0bSKZz
         tjXnYsLrfbaWqLoJ1j5yirSMVhDTBFOXcgcx/nGsCDUromfBWFgrKosdtp+RA+xJxAUo
         K+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C59NPkqXUrbnCZ8VXt3TFXDT6EMSpEqk8jhlfw5gTv8=;
        fh=aU9qPfDfLJEZlDqh1q6n6WY/02+PfIDt4/JLaGomBu8=;
        b=kGRsnUwAMtkha0tYzZ9lNq5nnHuS0xZEbjgDyFrWKJPhKRoiJlfRIpGgNpUArizFJE
         7W3Mj7x+xr1I8iamFShBcSvhNo7fawoLKJ0admEeqkFiJEwsLW5j14bLKRnVUBikPCNg
         u1m2njLeLSUtd9/X1zg0eNPF3IUlZG2UM/xjWe/I92vEIDGjtLGgQ9lK3fTr1ZPKfM2j
         WZQ7kB51rt5aJy2gGoxI6ykZ1yUHO6hXLUMOzke0hwYCtKMXgBWXjQh/t5iRwqus0BSG
         WA5zMkuE6q4+V8HgtNhXDf+7XA138NY+6CDhePTPkHUqbif+q1iClx93YwWVuSUJoltj
         aMQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20251104.gappssmtp.com; s=20251104; t=1784804169; x=1785408969; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C59NPkqXUrbnCZ8VXt3TFXDT6EMSpEqk8jhlfw5gTv8=;
        b=Tzqj/D7P9ndF5qFOzkF5sDKpNkp6Ik3LuWBOEtj59ioi0bRVkPcKmlpCx9qmYQET6F
         CagoFERZwarPzTZHRe4xLqGNXroXDwLszyA6+CY05DBqOzf/vZtavxkhWpRFj2JFWJU7
         ZVs3vgFaEJoKynQQP5tJITt1LbrxBhJ6tqAU0Db4h2w2ogRVnzFyPN0YL0mqSTEHSUaw
         4Cy2A1opgPSY7bQIfrFhVJYc2up2Eh/DMc7dVLg4aJrBjihs3wBIZDxkDWLjSuBavSN2
         3si+myLpFh10jXsSILAZPJfchuXET9QRL0pky1xC+vweKZOJx5YMrdAQHhl1LmFpWsrU
         2zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804169; x=1785408969;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C59NPkqXUrbnCZ8VXt3TFXDT6EMSpEqk8jhlfw5gTv8=;
        b=AYmaIVkzVxbcIoeket7aOZcMYDdBCsY06oFpYiaQrQzrdKjZFrsXMh2QLkw5ah8k/S
         MezDf+A5Crs1yQJmeAwoCngzwSlYtE9wW0sLiSeZ1TYxEOAidWVlh/iK1f3r/NBMEH5l
         nMqW7AXdXTH4Qfc05s6nkXRiUqF0Q++uUioNt1cRZFMurAw94MRxkpGSilrGC/Qv027Y
         Lobw3nS3vR03nibqThYg/l0A2LiJ2dp/xkfWt4Icz+6zgS9ZzSPFQVKU7UtiCArbTw6J
         x1u6bgOCOHCP+nm05cA8jS9M6sFJ58r3V015kTNDeTKN3fz+YaIma/sUnxI0Y2ZL/BCu
         Y4Mw==
X-Gm-Message-State: AOJu0YyeTm23C6W5s9sWTK0xNBMlEQ2bk7zl4Ea4+bz5dqHstcIyx5g2
	CgsSa4Ey+7FiFACkeuqjBeSXM14mrB46HIejxdVrm382vEk5nbZ/tazH5HfgQLqMRT9JQg7d4bd
	F1oN+XbK4E1l2aVWlQoigGjormIhjL9oiSi2SzOFX6A==
X-Gm-Gg: AR+sD11/oDZLPzfyRPiIALJORquw4UhAwbcbADK3NBmChgbbdRElnV2TsSp9aD4PNLX
	9ktrOPDog4+gQouTCc3kI2xGwf0hfkgUBiGnpHgippGqbvhIw2eOPFC2PIen7jVOdaK++6soEmF
	m5a3hJDfPHx6VxUmlMg0bHh4FRt8ZtVpQif38Mf9EprmzY2r3XZJKclEWoZnMK+70FWUe1xXHqK
	StRZxW0+cJ1iNE2vBnNAPUfZav2TPe1PuPpSiT9eprfoIi6Jb/axiLdxDsE
X-Received: by 2002:a05:6512:61d5:10b0:5ae:b75e:454d with SMTP id
 2adb3069b0e04-5b2b2f728e8mr409087e87.45.1784804168580; Thu, 23 Jul 2026
 03:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyohei Kadota <lufia@lufia.org>
Date: Thu, 23 Jul 2026 19:55:57 +0900
X-Gm-Features: AUfX_mxc1WBiuokUzNxPKmDxj0emBFUuBj_sgHyznt2-SoB6-lGFaLsw2Dviqwo
Message-ID: <CAFMepckDUuOHiDDVVhUYc-UqJMeCqrWSfCuxbJ2x2sGgdDD4nw@mail.gmail.com>
Subject: [PATCH] Input: xpad - add support for ZENAIM LEVERLESS
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the VID/PID for the ZENAIM LEVERLESS controller to xpad_device and
the VID to xpad_table.

Signed-off-by: KADOTA, Kyohei <lufia@lufia.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..2da0b7f1722a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -394,6 +394,7 @@ static const struct xpad_device {
     { 0x3285, 0x0646, "Nacon Pro Compact", 0, XTYPE_XBOXONE },
     { 0x3285, 0x0662, "Nacon Revolution5 Pro", 0, XTYPE_XBOX360 },
     { 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
+    { 0x3507, 0x000b, "ZENAIM LEVERLESS", 0, XTYPE_XBOX360 },
     { 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
     { 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
     { 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
@@ -557,6 +558,7 @@ static const struct usb_device_id xpad_table[] = {
     XPAD_XBOX360_VENDOR(0x31e3),        /* Wooting Keyboards */
     XPAD_XBOX360_VENDOR(0x3285),        /* Nacon GC-100 */
     XPAD_XBOXONE_VENDOR(0x3285),        /* Nacon Evol-X */
+    XPAD_XBOX360_VENDOR(0x3507),        /* ZENAIM Controllers */
     XPAD_XBOX360_VENDOR(0x3537),        /* GameSir Controllers */
     XPAD_XBOXONE_VENDOR(0x3537),        /* GameSir Controllers */
     XPAD_XBOX360_VENDOR(0x3651),        /* CRKD Controllers */

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
-- 
2.55.0
