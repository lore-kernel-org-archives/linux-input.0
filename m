Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D133AD8B
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021870; cv=none; b=Yy9aASO6u5QtmrOWfKHhNuP5hdWWureiNXC4xGk8ymL9bm+pQlBtYdcczC7WvKdgeLzsJO1YIXsYNkND8/W6JhwhGH+Ch9WLhgPTY81PgpspOowdcy2KSrIAg50et43JdB+CvVDB3hMWMNFUb/vXyQfdU88P+N2eeghWU4c+OZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021870; c=relaxed/simple;
	bh=WMRZuSLNkMYvarqhnRsxONvyGTX9zmFRHIo8fK4Mcws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtmbGxeMUuFcCYrYfTQzuYUfw0a8POYLh+BApg12pACEQxF66dJha7v+HOuzfcRtF5xGDxXArM8xJ7cIwtbfOHbP0BLxT9/SENM4Z8XbepIkTTY+Uu+oSAFBxyuehaAE7hvdhovqkozSvjNWMLAOfGZslNT5xkDyYDTYE1bpjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noOCC9TT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noOCC9TT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso70896345e9.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021865; x=1789626665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yit7H/tRXuShodzrH2KswWmmIcKYW0pMr8GV43v0zBw=;
        b=noOCC9TTPqDwrbLXGDGmiu5UffuLQzQD45IqNp+/0q+a40TDnhKrpHrERf5CpRk9J1
         Y3qyHJ7d16R6BDYTU9iZnjVdnAfzWr1eGnoC7IE8m3mAP/tAoqWlFXCLbqUKMi+WZr18
         RjoLjlv7eCTW9DiJ069tUteKMhzlWYrTArq6AXyji2M9SczA19V2ANM3eEF8FGIMFqMJ
         iait6QKzlN4lrKDO0MOJNNHx2JvUqKebzFsqyNLl0ksaUCH8wI7YT3YbwFzDt8Cm7Kl5
         u6RSjJTDYQ91bjgcs+3cHl0vdKF/WlmtXZKmBSrfvi1sX4BPSvfAl0L0hZ9XTTl3D5yl
         PX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021865; x=1789626665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yit7H/tRXuShodzrH2KswWmmIcKYW0pMr8GV43v0zBw=;
        b=MVFjRmM76hHlnvbxvfR7s3wlEvFE1a/iyxavv4x2P2QvTbqrE5noBxBoOoUn+7naMY
         Rw0jKlUci4eS1ihOcL3EoLW5fBClDLSDnBAUH8RE3qZNBS2UwmnCYbBfjocfrMm6nmyB
         qKTT/HMu79dVXGvjmtvN/IsI8XgTOd6rUSi2UjiSugTiqNp1p2D+jMPaWsXAog974oQy
         ttTOc7q4WAU63oFmVixZmevZuqT6fzOA4ADivVs0f0enkk4Hfo9WXGvUVVD5Y0C2jtQU
         qHqpLKaKODwiaTTCFAEu1yy+qILhm1ccib8WM6JGuHtE4JvKJPpYahjjp6oqAf2UigpE
         GDJQ==
X-Gm-Message-State: AFuF++lpUPxlUCTY9NM7JLFca8hKiad0G+bFueqfXKkyls1hsnqz3IoN
	qP4L/8SrRG5swbnG3zxuUB6WVt42ob/6zmZbEuzjAltbA0JT9AYnnbmN5L380fNxw7hT2g==
X-Gm-Gg: AYBFou1/EMM+9Zqocc6tbad/ugtKRkh55lUj2m0JmKVnFzGUn5CmBcxQv20A2Lsw/V2
	9S7d/FaTt1AVh+q78s2QgcB+6n5v5Ov9A+76jrPg+gZiSzQpjiEJrY1tnraWDtl0JfsZ6IBPxW1
	PvZofmqUEwHsDqpjIWqU+4yfyj90Ho1xKkHebGN70NFay3vnb9NRpJNt4TT9sAC5q9bYTaEac4t
	3OTAigE0OyIUUfYmUwgJHW8SZItbXSTHKyFgNrwHDqvzLWSTmtJnXMeJuf/nyICDwDLRMKXywpJ
	Q/vNAiZHlpzPtCzGBsoJeixiLtAfxsYWzwRMC90APnZRnzgO++KOjRZntT9CWZGHHH2c0JmmKI2
	bUtXgvL6nDw/SgcPLS1WbtxaHoi2xCsrR+OXBxXgfok/yvnpZxQ3RsqhKyZ21Ch2xppuZlFvYVr
	UpEGTAFNfWbYzBLiVeVuDLfLv1Occpl7zlLz8NOd7Mrg7hfPU2QewU9XkfRY8zLWu0gzEvoJ5F5
	Nw7UY3WvQhOZ5BtY6xbWqwxSlMmp/BNInkJhon5a8e8KDKxV08LFoU=
X-Received: by 2002:a05:600c:6305:b0:49d:2803:22fe with SMTP id 5b1f17b1804b1-49d28032d49mr18957815e9.32.1789021864481;
        Wed, 09 Sep 2026 23:31:04 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26bfdb4asm47441825e9.11.2026.09.09.23.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:31:02 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HID: quiet the keyboard on the Lenovo Yoga Slim 7x Gen 11
Date: Thu, 10 Sep 2026 08:30:49 +0200
Message-ID: <20260910063051.4556-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes for the ITE keyboard controller (048d:83db) on the
Lenovo Yoga Slim 7x Gen 11, a Snapdragon X2 Elite (Glymur) laptop.

Patch 1 stops i2c-hid waiting a full second for a reset acknowledgement
this controller never sends, on every probe and every resume.

Patch 2 drops the Wireless Radio Controls collection the same
controller declares but never reports through.  The airplane mode key
is wired to the embedded controller instead, so userspace currently
sees two KEY_RFKILL sources of which only one ever fires.

The two are independent in effect but not in ordering: patch 2 uses the
device ID that patch 1 adds to hid-ids.h.

Changes in v2:
- Send both patches as an ordered series.  v1 was patch 2 alone, which
  does not build on its own -- it references
  I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD, and the #define
  for it lives in patch 1.  The kernel test robot reported this twice:
    https://lore.kernel.org/oe-kbuild-all/202609092332.pk1AmDaL-lkp@intel.com/
    https://lore.kernel.org/oe-kbuild-all/202609100719.bu2saXPQ-lkp@intel.com/
  No code changed; only the split and the ordering.
- Link to v1: https://lore.kernel.org/all/20260908091907.5653-1-okerixx@gmail.com/

Oleg Keri (2):
  HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard
  HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11

 drivers/hid/hid-ids.h              |  1 +
 drivers/hid/hid-lenovo.c           | 14 ++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-core.c |  2 ++
 3 files changed, 17 insertions(+)

-- 
2.55.0


base-commit: df2908090cda368b01ff43709f51890076c56157
