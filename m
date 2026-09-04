Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678823EAAA
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543916; cv=none; b=nxplH9q7hpAbvsEF9FiOsxwpX5zX5hCyClR4e5AtRXY2U8gWObEs/crhGy3OvTNvkU6cD45R8Myb344BX/XA/2WRxGLZJdyoeBOK3Q/569EeTwazgo3ztf+qSUkOF8IZUgcDoS+3S4ItJqflDt++eKqrlvB0SOm/4lT3N9np9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543916; c=relaxed/simple;
	bh=5xeMxtX1fCh8OGl3ui+hhjKrfVCy12n88MgVgMcIa2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZGfPhCENrW4BwsrdZxxiT3uyDWrqU39cM1GMnwn5RfXdaHZr7Blh9OhVAC7Fw2CNPPMEMZpn5knOQW7qwdy887IiB7+A0ynZHS72yl9N7ixOrPos7sKHr0zPPzWMD6t+k6RvAkAhMpsrEM8uHHkEvixgyJsIQqXcVMHPfyPXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmE0vyVY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmE0vyVY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b4b037a2c1so1171391e87.2
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788543913; x=1789148713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUYDwrBykVcOFXxIJuB5joV8Yatru/7oqjgD9YEMvFo=;
        b=PmE0vyVYyDsjh535BUj5s+uxbhla4+kQkFzqB0ORSzwk+GEVMGmGlDCC/8gW2NcIDN
         jE2pwhQtAKLIt2F9e5+rNaIvjtAO0XYaGKRrhGYpsSpVxqpCMWvQ8Iny4iNg5gttuMGc
         4FzrcF3ssQ4ooJxEml5SmvrtfVC3ZfHHYXABTHtjGqPYpeR5qOVkDl/oaOY9W+KE8x8H
         elxs5MLq2j+vA0nU/8tCCTaCuTih6mUVokK+H/ZMUf26Q5l8vohKh4fg3bBdiv6BMF8u
         VWkVNKOqT3UnViRsQ+DS1fRzO4z2qRLTj9AmeQdD/Tbsv/KyKu7Nq/SKJrOKbM4qhBb6
         fdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788543913; x=1789148713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QUYDwrBykVcOFXxIJuB5joV8Yatru/7oqjgD9YEMvFo=;
        b=XotPh6JO8Rl46asSFwf9Br3QlffZ4LAbp3SBtUrlZ526QfCZg4+hE+OrDD5azTIxve
         7iUtzPbJAK5GW4FXncwqHDWMf+I57wh5fcXazIC9fIXYT2Qxb/YIwLIO7Ra5uvlI7zRj
         algyKQ10oMinlP1Y2lKvRTjd61OoGOXLW5HJTzCD2xwqErtC1Hb4rdUejqMUyxbfZiOC
         TSwQiIFLMJx6hyfn5pccH+uz3c5JeShqd/3lb1FirHG/pXqtWVJlVdU5aGxZ7P3LeIqu
         dnMWbEy0YxegkEyxAmYcoAPI9XjfaQQgoyfZ+URopkgYV00FaqFd2X4wdMxqQ8jkpzTV
         fKrw==
X-Forwarded-Encrypted: i=1; AKwUvBziVaMIZFP5hbQ81cDY3Xg31/CrHZb6apboSJOv0cUi1Ar1fGckrIZHCaCj+tcU2O5oVYVxVgQiRA103A==@vger.kernel.org
X-Gm-Message-State: AFuF++nuKg9Bkl36zI875pOAof5qlM6NEYxFGSCHD+sGInbzHgwue0VL
	72dlwnZ82WdEWbKPPT7mESA+2wwhKz/XgEjyqIwxJ7pBtlccwMzgFhP/
X-Gm-Gg: AYBFou0grlE9iJJOUPsxfcB/gscT0NwTgUg53hqJbVK4tACt4fW+4Eg2q5FRBQTvzpz
	+urtyV0SoWHVwTV0s7Q/Ehk+iKc9sgsMkEGGnQOoV2/rbFWT8nuzOC6keAy8tZ4ZPoiPnrGfj4n
	1Nt/k1otasKMJ4nFDi7VUVcOA2Bjs1r64hjRJSeAykn3AaXPtMKxPv35U1H4OfTPv43IDUNPMfv
	iS+BzJefMZixFvBKkRxAYtGLz6VjrGOFIEwkDdKMEkdbzGra4oUbO4k4YH4NKvlYyXc1f4rW1gg
	vdw99nloway/Wwwp9BeJfAh2AgiDzepO+cuAFiW5Rp2TGJ4ubP/O6GNyxhNKVSDR4GT8WQQr9IU
	C7ok9JppYRx0GQN/eBBicexyzF2F280Byd6THyarv6Nvi9XHhj9/fbIEUabnW7CW+8o7IgrzBIi
	DLVlTAgw+GxuEXMCuOYrw1xVzqvkr8dPwk6iYSFBbLYgT4Sk1aaVXBUFYsciAyV4hLDKPS008eb
	RVh3l21cmb3D9yNt2isGTqgCHSGSOZ7uLGMTT/5vtXfGOkqxveOGP9arjSnv61TMe/Lejpocdg6
	yis8qik=
X-Received: by 2002:a05:6512:3ca7:b0:5b6:1a7c:37 with SMTP id 2adb3069b0e04-5b61a7c0261mr894499e87.58.1788543912418;
        Fri, 04 Sep 2026 10:45:12 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b616700006sm644118e87.57.2026.09.04.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:45:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 2/2] ALSA: usb-audio: bind the Topping M62's vendor controls
Date: Fri,  4 Sep 2026 22:45:07 +0500
Message-ID: <20260904174507.3952588-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904171646.5301B1F00A3D@smtp.kernel.org>
References: <20260904171646.5301B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If usb_audio_probe() fails on a secondary interface, devres is
> synchronously unwound and topping_master_teardown() runs while the
> orphaned mixer is still in chip->mixer_list.

That mixer does not exist, because this device has no secondary
probes. snd_usb_create_streams() claims the streaming interfaces with
usb_driver_claim_interface(), which binds them without calling probe,
so usb_audio_probe() runs exactly once, on interface 0. The hardware
agrees: /sys/kernel/debug/device_component lists one aggregate per
card, both on :1.0, with :1.1 and :1.2 absent.

The other half is not there either. If that one probe fails,
chip->num_interfaces is zero, so usb_audio_probe() calls
snd_card_free(), which takes the mixer down through private_free() --
and that removes the devres action and destroys the context before the
driver core unwinds anything. There is nothing for the teardown to
race.

The same premise sits under the findings I acted on in v4, v5 and v6,
and I took it on trust instead of checking it. Those changes stay,
because each is right on its own terms:

  - topping_master_unbind() no longer looks its context up, which is
    correct regardless: devres_release_all() moves every node off the
    device before it calls a single release, so the lookup could never
    have worked from an unwind, and the component does not need the
    card from us anyway;

  - the teardown is a devres action registered after
    component_match_add(), so it unwinds before the match array that
    component_unbind_all() walks -- the ordering is now expressed
    rather than assumed;

  - topping_master_bind() returns -EPROBE_DEFER rather than warning
    when the context is missing, which a WARN had no business doing
    for a state the framework can reach.

But none of them fixes a defect this device can reach, and I would
rather say so here than leave the impression that the driver was
crashing. A v7 cover letter will say the same.

Mikhail
