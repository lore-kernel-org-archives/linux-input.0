Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894163128CC
	for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029689; cv=none; b=Hmj3PmAJD1xf9bVLG+lrIwT4QGTdQQDfCmF38H3MFpz1UurV30iWeu7KyGnApGWBHXE1G37uXloIrom9m+fEPnUQBXnS4TJ+he2tXZAcnZr61IDrjOiqKMFt/h5nzo0izT/tVwo1Ur+giQoRzCdZW4XG3w+qAvyKGUN2zFEx+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029689; c=relaxed/simple;
	bh=AQrTEGW6sfD5ciR2bScsYfxiVHmSFMd8GRvYzOJarhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6rAoKZR4leF2xdDvVDHjPxbm+txTAfY7yMj+mr02JCCnbeBZBZgXBXi6qHpmFQTuuhEekUEJDcWUQ2tHKwYiQBQfHd/CkABX+BWbtwGuXOsElZl2kXcDe3drPBwVnM4ybnzUxfpB0YusN0IAYlwUndlkZdBtqPUuHdDlOEPdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAui7PPy; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAui7PPy"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so6769395eec.1
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776029688; x=1776634488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0vO1HvyTYpK+q2M2tlyUiDamAY+vmW0ihlj4iawHpg=;
        b=BAui7PPymn+xKSelNqqeOQe3YP8M4+EfsB078JhTVddvpSk5MinrSf6dNVijj5I/fv
         /Rlg7Ql/YEiwBaRZchhT15vF5oHvI0RUUkH7mKvsjLzFg2ARUVztAZZ0Eqv3dBYByFRU
         IHI6DdTSC7FKmSnf/OXjfhs5THFnLkRgBdcHz2PVy8jkFLzHAZ5t2tfUwtDS/hzMg9cy
         h01lout5Lw3yTQJOk9E5Qrfp41E6O/1f4tDmUj5wKV0bubNxdtz9tHPpb6em/FqXd9G2
         F4W+cPUmOetA7MDlSjs/1KCZgCqXqk5tWWDwedFDh2Vh6GJKIObaa3Hha5thYIEunbh3
         RnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776029688; x=1776634488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0vO1HvyTYpK+q2M2tlyUiDamAY+vmW0ihlj4iawHpg=;
        b=rKDV/jrDRoOONMy8ogRHQdVkDOLMIveVG5OGGOr7xljrZcc4n1sH2ACDnpd4FGFwLS
         GZXutkXa6uaTaFeLXoiCNK648JNSfitRmGPrQG6CD3tU8y6gamzjqo1RguA9PvL3oLm0
         PVHXSUek3hmFNzEiJp5GQmfCxjbWzD0W7I5tNVZMfAYrZH7DK6lsjomFuFZQkCvBelxR
         A5acUmREQ97Ly0HQSAeeWMh3lQ22JcP2SeTYFO4YrDjSlEznBkXAdUPjec+UJsVT6Ifs
         uaRLuBUKIYjZpHjPVqnVzUdEOwRSh+8kUnN6cqZjVM8aop3eGS+MeRnU7tyWiLchbJWr
         i9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdz8TxDkw0Ab0oldqgmWQxCvbqB4VhWwE/e7Acl0Any4XCAPd4z7s44IO16e50f6uhY/VZLyGwDfbkxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPQWsQPNNYtu5eizjR5qvEdSu6Xz+gnhJ7TzssAhRaHguziyJ
	jeEu/m9hdMpCeELlboOyj5AgPNWTfSEy91OBfFVZygXeffz6RHoT3E+I
X-Gm-Gg: AeBDietgjyI/dq4Bamwd/F0N4zSBopRzaUT1xbE3FsAmkj23zbOU+iw/v6zqCxpUEjB
	zk5zec2LQhlNOKRqoIoAOW3bMn5fkBr+mdjbjBNQSuuOlMDcfAz+FTDl/VqhmgUy7oKayCK7ykC
	FNhwfYxAZZe7uo3033VBmcDuGiDAn1wCXwPvXTiSCr7omrBSEacZ95vyaIyQz+zHF+ApwoRgmvI
	5O7SD0Fh2hEl5T8+hbzNtmJSjWsbpAj6PptuNLgOtn8RZ8O4uV+FfGgNKJfNgMCl9kD3uvf/xdl
	7yExx1hBhjR+xIkV4v8PUfT8m+3GORlfvJCFm1C3ISH/hUxGOm8SBIB9czUHFOIV4gWYRrdPkMZ
	9XCB87hDqI66XDEsXA39Ghx9pd/1hIaansfPGIZik9h7XgV5gLehsEGAWV4Ktus37tsbjwjv8lt
	VxGidExx1ydphzl05DnH7IhCUQPnT0tJDMEuySCNG3uaRm4By9xmJ11IG08LX5Ih/u21dvInLQQ
	md2
X-Received: by 2002:a05:7022:790:b0:12a:b932:81d3 with SMTP id a92af1059eb24-12c34eeb76fmr5593844c88.26.1776029687711;
        Sun, 12 Apr 2026 14:34:47 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b5b9dsm10631736c88.7.2026.04.12.14.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:34:47 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add OneXPlayer Configuration HID Driver
Date: Sun, 12 Apr 2026 21:34:39 +0000
Message-ID: <20260412213444.2231505-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds an HID driver for OneXPlayer HID configuration devices. There are
currently 2 generations of OneXPlayer HID protocol. The first (OneXPlayer
F1 series) only provides an RGB control interface over HID. The Second
(X1 mini series, G1 series, AOKZOE A1X) also includes a hardware level
button mapping interface, vibration intensity settings, and the ability
to switch output between xinput and a debug mode that can be used to debug
the button mapping. Some devices (G1 Series, APEX) use a hybrid of Gen1
RGB control and Gen 2 controller settings. To ensure there is no conflicts
when the driver is loaded, we skip creating the RGB interface for Gen 2
devices if there is a DMI match.

I'll also add a note that Gen 1 devices also have an interface for
setting the key map and debug mode, but that is done entirely over a
serial TTY device so it is not able to be added to this driver. There
are also some "Gen 0" devices (OneXPlayer 2 Series) also use it, but
the TTY interface also handles the RGB control so no support is
provided by this driver for those interfaces.

Signed-off-by: Derel J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (5):
  HID: hid-oxp: Add OneXPlayer configuration driver
  HID: hid-oxp: Add Second Generation RGB Control
  HID: hid-oxp: Add Second Generation Gamepad Mode Switch
  HID: hid-oxp: Add Button Mapping Interface
  HID: hid-oxp: Add Vibration Intensity Attributes

 MAINTAINERS           |    6 +
 drivers/hid/Kconfig   |   13 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    6 +
 drivers/hid/hid-oxp.c | 1575 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1601 insertions(+)
 create mode 100644 drivers/hid/hid-oxp.c

-- 
2.53.0

