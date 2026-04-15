Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6F3A1CF3
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776238337; cv=none; b=MPHZNnyyWTWChQD7dSJOR9FuqoDltcPkoSuZ1xCIHMexGtSm2PO6KQr4Uv/sKZHG/WvZjeomdYexMqjTceLrtsSX494YHb73rVc49ULqJ5+Lcq1aYwrJvJepBQM47B0DvK0gNbrjT940O8Ew0gEGif1O48zyML+ODLvhtYJmWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776238337; c=relaxed/simple;
	bh=cRkf3nPOxtAbD+loT9q7z3dbsEI0pEUWXp7AcsomaFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPHmUZeQS0G8WS8BAybleIvrNPPK05SVrW4lTycJl+cQsfRzs5AYHuG7yoAULBh71oXIfErNXtaOGsw7We4+G2he1fUpRHxutvAf3sOQ0mYhHjmzPFMiqt/Wtf1Wyjm9WPVzBO/hYLlQM1hr1Jj3pwESItm8ARZbE4lZ+6kMT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=rZEXkTOl; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="rZEXkTOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1776238328; bh=cRkf3nPOxtAbD+loT9q7z3dbsEI0pEUWXp7AcsomaFo=;
	h=From:To:Cc:Subject:Date:From;
	b=rZEXkTOl4FateG4tmQTZQcPEcG6AOMpOtfAQytYxOS32Dbkm/FLui5uY/kfk/WGk4
	 lIiC3xmmmJQBN2MZ90MSztQBAWB3/mFHaxbiMZqWiOzVBB/pgfueqrnS1KmerV1IOa
	 69Sikk1bQIu4HxDodkuGIxQRDvLrKmW9VTnzu6Pcome/juAbo9Ts4SblmJnwjnTdMv
	 I+FESnUZy29AipPZTLJ2G7wnwvor9IciXyPUjaPKFyUyRm8ucseCw2g38vm4qW24bi
	 ZYTRBnVUP/PEsVdm+t7ud/qwhxgIsVPrm10rX+kxMYcB24ZApHJXwRSfcAK7C/UoYS
	 XGEUwPyrAoRRw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0B750A028;
	Wed, 15 Apr 2026 00:32:07 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Wed, 15 Apr 2026 00:31:36 -0700
Message-ID: <20260415073142.1303505-1-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. This is a minor iteration on
v3 (which was erroneously submitted as v2 again), fixing an issue where we
checked for NULL instead of handling an ERR_PTR, as well as a few typo
fixes.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1507 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  353 ++++
 8 files changed, 1954 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.53.0

