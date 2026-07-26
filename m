Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D231F983
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072209; cv=none; b=AtoufCg0YjjqGJlxLsMkc9IsCiOwla0ZS5yCA5sHMvT6t19fBfxN/LlIGd+CTNDZkZZtm+d1HM7EfcTfA3GsicuIirWevq7RsRtxYozM0qMufQD3jpTDi9Zl3YwvVmqU8iV4Z+Em8PPPcfSTN1yzO0kpI3K+j3Uqb1My2xq27G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072209; c=relaxed/simple;
	bh=rwEk9DOaoOH/aePz8XHcDqDAJcyl6iNdVIQDLbimJ4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kv/MH/90URQDMru6ONXRMbOZaU1ylOFpjg0Z6BnhB1pOeBDJ48L5f8jcMfsP143Ca6aKGRYj2vmo6kHxzwsCIuSPSKtbgvFN8J0LL/nTq6RozuPKv7jy/DMcWBwOZgYlpHMn8fZPMo7oUrz7hBA8GBT04M+5a2MsepVhBZfaj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbrkLqbB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbrkLqbB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso20986335ad.0
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785072206; x=1785677006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fObd6HBzZug5ha7KKMXaZQiE1Nwuc1RsD0ttGJHVYJg=;
        b=TbrkLqbBtjpS3TegGMqkEKtiGJ5f57WM9jgJZjw7M6kXOqOZL5qn8HgeteA+kd1m3F
         3bnA/y+YTsCDnD4HjKGC83vu39NTX/F75SkWZFxTcczz4tkZLMsDY6R1uwou5qBk3rid
         XJRqnxbP3e6lga84oOwWTRZdAuFnXUnyN991UhJ34g7vADvxQP8Z1xPGr0o9RnO0CI6i
         /sRk4/fywgn8SjDtePWms04UhEfhUYn5f6XXwsGAa5Yv6UNJ0/2ytcIzXqME/cEDAty2
         Ap7C2kaIZBR62ZbTBY2oVk7ZePBLNUkXBOguHpMoySPDK+86ZfUVia0llXmfHgo6NtnQ
         Rm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785072206; x=1785677006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fObd6HBzZug5ha7KKMXaZQiE1Nwuc1RsD0ttGJHVYJg=;
        b=Siut9hdQC5JRieYM/l7R9TEc9wZRQDzc01fb6VbSnjotXNgPiqtYMH1v4h8sWcHHbN
         wIcITg+/wcWq/b0Gi5rbWE5RD2yEa5mymnYzc6V+1DEIsEla8s92oX5zaltOOROR9gfI
         I6MiS7LZViVNHJdXOps+kAX0eGqkI5yYG2Mf2+D+hseWOdTocPJ1vX0WzK+3iH2kjBRO
         cuYpY9mcPLUk+pYP71UVQ3HdfHODiLmjwQs8YDIV0SksgAht9gBZENBkOB4OEucTaHYY
         lrjIbMYjJZYeEjzWkZGSAOdsl22XzNhkEMpsjzuXEFY9y8bzx2RbuSrotN+bK1rbbxgM
         +FbQ==
X-Gm-Message-State: AOJu0YzAsUmFvjcKLcUpJLJ1UGp2/l2QlqTJttdxfgQpOMw40R3Oiq5d
	jAkGlciXD3SyUD3LFT5ljtxY4g5K7C49oyYuC1bC4ty+I3F7jDh51ddkiOcy89yt
X-Gm-Gg: AR+sD10sLKeD5EurQZG+Zl8mdyO+kAHQZwq2+gE+HZlw2PtZ9mjm993RfZ4O7ogFlEr
	1bUnoXGl73U06Ir8PmxuxKBixeUR91mdukkpFGNkYhDp4lFPZAsSKNVe1pCYflH/3dRjd3NYKMZ
	sjQ2FpoOWYG2j+Ea9ugep2CR17XHr9lO6cYNMLIdyKQje4RwS0jVwuqI/jobuVjcxDan7Ck6uMw
	v/OhPi7g+cSlOYD22nAFJ6JUwgpo46skM/tMym723WPc1p60BoNSXCHJH+710MAlfuVmD2ybHLs
	g6nsOAby4hdrRuioNyA54q6iPZK/hGX3R2DZ08r+NbZnxzkjORp7eici8AVcAUugR8osbUsEEcH
	h4wVJghz/EZ+5jqCZJZg93cmKVSdcFzCe0uO8n38m/l/GFRcsGjLN+j+Z9j2Mo+OpZdaBLr74O9
	rgSlL2fE2+IagE8w==
X-Received: by 2002:a17:902:f709:b0:2cf:b23a:3e68 with SMTP id d9443c01a7336-2cfd72a4d0bmr70134335ad.25.1785072206402;
        Sun, 26 Jul 2026 06:23:26 -0700 (PDT)
Received: from Linux.bbrouter ([115.96.217.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm20784436eec.11.2026.07.26.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:23:25 -0700 (PDT)
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	nikhilsolanke5@gmail.com,
	Ishaan Dandekar <ishaan.dandekar@gmail.com>
Subject: [PATCH 0/3] Fix initialization and routing for Generic Clone X-Input Gamepads
Date: Sun, 26 Jul 2026 18:50:37 +0530
Message-Id: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a two-stage failure preventing certain generic X-Input clone controllers (specifically 0283:0001) from functioning  correctly in Linux. The primary motivation for this series is to restore full device functionality, specifically haptic feedback (rumble), which is entirely lost when the device falls back to its limited Android mode.

Phase 1: The Hardware Panic (USB Core layer)
When the controller is plugged in, the USB core requests its configuration using a 9-byte request. The controller's firmware fails, disconnects, and shape-shifts into a fallback Android mode, completely losing its X-Input capabilities.
Patch 1 (by Nikhil Solanke) builds the underlying core logic to allow a 255-byte config request (mimicking Windows behavior).
Patch 2 (my contribution) adds this specific controller's hardware ID to Nikhil's new quirk list, preventing the crash and locking it in X-Input mode.

Phase 2: The Software Blind Spot (Input/xpad layer)
Because Phase 1 succeeds, the controller stays in X-Input mode and presents the hardware ID 0283:0001. However, the xpad driver lacked this ID in its internal device tables. Because it wasn't recognized as an official Xbox controller, the kernel handed it to hid-generic, which only initialized the keyboard interface, resulting in ignored gamepad inputs and total loss of rumble.
Patch 3 explicitly adds 0283:0001 to the xpad routing filters so it initializes as a proper gamepad with full haptic support.

I initially attempted to send just the quirk patch, but realized the device remained non-functional as a gamepad without the xpad routing fix. This series unites both fixes to ensure the hardware is actually usable out of the box.

(Note: My previous single-patch submission was corrupted by my email client's formatting; this series replaces it and is being submitted via git send-email).

Ishaan Dandekar (2):
  usb: quirks: Add ShanWan gamepad to quirk list
  Input: xpad - add support for generic clone X-Input gamepads

Nikhil Solanke (1):
  usbcore: Add quirk for 255-bytes initial config read

 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/input/joystick/xpad.c                 |  2 +
 drivers/usb/core/config.c                     | 39 +++++++++++++++----
 drivers/usb/core/quirks.c                     |  7 ++++
 include/linux/usb/quirks.h                    |  3 ++
 5 files changed, 54 insertions(+), 7 deletions(-)

-- 
2.34.1

