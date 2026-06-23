Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DB38B148
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235395; cv=none; b=RYhDm67bR84wMxXbccnCkcPGdjorR8hNqEoOBiLyvH+uEBYVGHQgCF9Yn2n5K0poY3hfuThgNkJC9VHuo9Him6ieAywJFrZVf8P0F8+qNmz9rssB6fa4yzviUla816sNQrtzAZMAD6h5m1NgXbs6B6NauSFi2e63LjR8SNUQLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235395; c=relaxed/simple;
	bh=vF1dahUSlsNFIjPZszBMIOAcuyuspp+s3t5+t6lmxRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYZNYBtOFtsuk3VR0thE6XcMbpv7FLAVst0P6SbKmHMXu5CFP+4ft6HbFeTF1gD27aAKcUuIASxkcSrt3HH7LUQrNt0YIPGSsYLWU2GmxjM7ZSE/p3ZjjXuanr2fbOVIX8NDuTYOBGcfAmqzDm4uKh916ZWUcyDdIFzA5kbDy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJlBJFVM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJlBJFVM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51a13ceb03bso129121cf.2
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235392; x=1782840192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETwTp6OWXn7LCvviENyWOJHFV4XtBF113dnnGMTCjCc=;
        b=DJlBJFVMVvQPbl3zuBfauoX8frCO253XgX4U8f8DG7VhJFf95v+vEWhvJEArPqAZk5
         u0xYKLY58rOXszK/deULAyhlkJC4qpyvFDSNRK/oQoDwjnq8uGJRhHg1RWREw6+rKw5s
         dYTRYZmt7cLzWAcw36GKXRBavZ9o1UPqiwu/exgRln4cmydWnb5ivX0h8Wp8+H9bSiwC
         Tm3Zx5NrmZ3J5mY6KXlmocDB8t0pj3y2YgUkXspm2997arkDpJjPyD/emwOftu82DHrO
         9+Dzclyux9w4P1kM9tB9dlKY4ZF/G0Swn3F1j5WL7s+/EeNDa2ILy4ExPIv0LWFrOe28
         OGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235392; x=1782840192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETwTp6OWXn7LCvviENyWOJHFV4XtBF113dnnGMTCjCc=;
        b=nyP1l9oABAWrnjaL4LmFBYHyQtwZkTB4wv5Z10hAvVfU8dQz4Keex/uHMeHq/RetSx
         EsT4SvH0jfnbpar3RxPvIzxgg9PlwI+3bhHaXs8pcqjy7jXsBo0CYH8EHfJsPfvJh7B8
         ebks9Hsi7KOWz54DHtG34P9gZhRJGFFnmpJVsh6OSBM69ziDpSxUNQcpPfO9MOiWKUb+
         K3cG5BIfPJK5N9+I/rovARQihugs0uzXgloit29ZdCbfOSBzlQGGEQwFgClADtjjSB9R
         hkHseDlGONubxzFSGTVC/u/2WlycDZoT8J0l2VQRmgnzSBFGlsL/HHK69LJ094bQgBS1
         A3kQ==
X-Gm-Message-State: AOJu0YxURh5jD1DZUzYgs2LrPi5/sOD5eibGasj8fl2poa1rkqhoMH5F
	FlC/s8CNRRX5Ufz0CkZMsvx3QOXa9r29kqEa0o236ijtJn05bUukLGsTlrO/tw==
X-Gm-Gg: AfdE7cl5BLuC2ftUin/y+28/lXvZRgL8UfgaDmwbJz/EdNMJb2vU63jIj7CYKmjjMhB
	6v91XWNUKGHU+y2eq9qOOkeaazHJiEmDHqjUp/Gl7ClAPWH3FFRb63AlVaC+wWetHCesVqRdcRb
	qb+JsLYIivrxpowa6x+MrjNuSLel/mj50S3WSqvHyGFLVXkVG19FdlOQgXXtf6l4BGiuzj6ejOR
	JcRJtZVKT3C3FyKmTADH/ENQabLv9u1Q7WMXWmoEs3kPj/L1KbIA8wSoeKG60cWXdJBw5ZPWfTL
	txQ8urXOXupakRNz+FUqAtgTZ1VjUHHMwXIU5x1Dj6v4rOwX2fdH5V/SDpJdgfQ3W5vOZHAXASP
	vy4HbJqreiN4swYec4wPLN9d+s2AWTZceS1JeyRLHj1nA9wYZex+5T9JzT9pdiXH85F+tDwnuf0
	MM/OHGcpdlGm37xqpCHg2zFBVG+98qTibn5g/ZZ/SdhEdylVPgUJUW9ruebbg=
X-Received: by 2002:a05:622a:45:b0:517:8e65:68e2 with SMTP id d75a77b69052e-51a55b00d30mr44947611cf.49.1782235391672;
        Tue, 23 Jun 2026 10:23:11 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:11 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 00/10] HID: steelseries: Refactor Arctis driver and add Arctis Nova 7 Gen2 support
Date: Tue, 23 Jun 2026 13:23:00 -0400
Message-ID: <20260623172310.272708-1-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks the Arctis headset support in hid-steelseries and
adds battery reporting for the Arctis Nova 7 Gen2 family.

The work splits the Arctis code out of hid-steelseries.c into its own
module, moves it onto a device_info framework so each model declares its
own capabilities and status callbacks, fixes a few battery reporting
issues, and adds an async status interface so headsets that push their
own updates do not need polling. The Arctis Nova 7 Gen2 family is the
first user of that interface.

This is a large scope cut from v3. v3 tried to add the full control
surface (sidetone, ChatMix, microphone, volume limiting, Bluetooth
settings) across 25+ models, with the audio controls exposed through
ALSA mixers. There is no clear precedent for an ALSA control surface
living in a HID driver, and I am not confident about where that code
belongs. Rather than hold up the rest behind that question, this version
keeps the refactor and the battery work and limits new hardware support
to the one headset I own and can test. The control surface can come back
later once its home is settled.

Tested on the Arctis Nova 7 (0x2202) and the Arctis Nova 7 2026 (0x22a1).
The Arctis 9 calibration values come from the HeadsetControl project and
public reverse engineering, not from direct measurement, as noted in
that patch.

Changes since v3:
- Drop the ALSA sound card infrastructure and all ALSA mixer controls
  (sidetone, ChatMix, mic mute, mic volume, volume limiter, Bluetooth
  call audio ducking). The right location for audio control in a HID
  driver needs more discussion first.
- Drop the sysfs control attributes (Bluetooth state, inactive time,
  Bluetooth auto-enable, mic mute LED) and the settings poll
  infrastructure that backed them.
- Drop the sysfs ABI documentation patch, since those attributes are
  gone.
- Limit new device support to the Arctis Nova 7 Gen2 family, the only
  hardware I can test.
- Keep the module split, the device_info refactor, the battery fixes,
  and the async status interface as the base for future work.

Changes since v2:
- Expand support to 25+ Arctis models with a capability based
  device_info system.
- Expose audio controls through ALSA mixers.
- Add async input handling for devices with known protocols.
- Fix several logical and protocol issues for the Arctis 7 and 9.
- General code cleanup and initialization logic improvements.

Changes since v1:
- Fix Documentation formatting issues.

Sriman Achanta (10):
  HID: steelseries: Fix ARCTIS_1_X device mislabeling
  HID: steelseries: Fix whitespace in srws1 report descriptor
  HID: steelseries: Split Arctis headset driver into separate module
  HID: steelseries: Inline and simplify SRWS1 wheel driver
  HID: steelseries: Refactor Arctis driver to use device_info framework
  HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
  HID: steelseries: Correct Arctis 9 battery calibration range
  HID: steelseries: Manage battery lifetime with refcounting
  HID: steelseries: Add async status interface support
  HID: steelseries: Add support for Arctis Nova 7 Gen2 family

 drivers/hid/Makefile                 |   2 +-
 drivers/hid/hid-ids.h                |  12 +-
 drivers/hid/hid-quirks.c             |  10 +-
 drivers/hid/hid-steelseries-arctis.c | 631 +++++++++++++++++++++++++++
 drivers/hid/hid-steelseries.c        | 550 ++++-------------------
 5 files changed, 732 insertions(+), 473 deletions(-)
 create mode 100644 drivers/hid/hid-steelseries-arctis.c


base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.54.0

