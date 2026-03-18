Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED833123F
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773803743; cv=none; b=e4FxZkX/3xeXYVneuWEorCbBoVpNmQhrzyeiy7bgsd27f4FvPMQ2O+O4yQZmEZN4AeBHADcup3AVTlgyeyptjGYZw9QNA3kAFULfE0ZDH5XJm7IgUpISIs/kGcEr215HKa1tlObIn/XxBQcKle70nWc8j8XhW/AmZuSap6EbDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773803743; c=relaxed/simple;
	bh=nhac57JZ3iDevWLW7INyyeST/9iLCo3Ojzt1CzczXzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNaxLTVd88MRIKRACrkfOtK1b3wE6oA+ZBdmifeCpLRHRznF1FmwC5UwWeG5GEsEPxLW9ooXJwcpRD+exr8DtpJGyBHFuIuy8fqXVXEfcHlnmuqzYohK8TOV27AzfXhOp9MDQ/8d7c2HKya6G7/8gP4ZrirS8jBb1TC2PMmFHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=A9VMv3Q+; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="A9VMv3Q+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773803347; bh=nhac57JZ3iDevWLW7INyyeST/9iLCo3Ojzt1CzczXzc=;
	h=From:To:Cc:Subject:Date:From;
	b=A9VMv3Q+V40Aw13KgVE3mbNkIB8Kd9b1HF4GTLofyoL3UhHXCOj760rTKVI9fWXE0
	 xGZj4ghZI2dimIZlEf2thZtee7ZEPfXmgf89Nyw5be+gZiVrafWTTn2Nm7r5iHfvhU
	 NNz1NilexPXuqIwar8+wqVeUgnmcHhUd5qkP1Q6NLYVPQAcaAYuNne7Mos8PUaFBNd
	 FRdQ+4fwO++DeE9rDhxmPSQRwY/KBLa2J7wP9E1Y0p3YcAi1040HZisKNdoOfmNVkv
	 75Z+xhv97NkqHxjCs8pw8RUbyaGT9a/0iziHwHD3CoYQOLL8wV9s6Sl5w/Womds6Y8
	 NxsfWC3oXfbBw==
Received: from nebulosa.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id D8635A041;
	Tue, 17 Mar 2026 20:09:06 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Tue, 17 Mar 2026 20:08:44 -0700
Message-ID: <20260318030850.289712-1-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers. As with v1,
it does not support Bluetooth controllers and does not contain IMU or
battery support. However, several significant changes have been made:

First and foremost, the driver has been folded into hid-nintendo instead of
a separate hid-switch2 driver. This allowed reuse of some small bits of
hid-nintendo's existing support, but not a signiicant amount.

Secondly, the configuration interface API has been changed to make the
switch2_controller struct opaque. As the configuration interface is
effectively just a dumb sidechannel used for passing data that is the same
regardless of transit, there is no need for it to have any internal state
knowledge.

Thirdly, it adds support for "unified" format that had been left as a TODO
in the previous version. Though it does not directly enable said format,
it's good to have for future purposes.

It also addresses the other TODO regarding partial initialization,
guaranteeing a consistent state after setup, regardless of whether or not
an userspace process has claimed an then released control of the USB
interface.

Finally, it fixes a number of bugs, including some missing locks and race
conditions that could trigger a kernel panic if the USB configuration
interface was claimed or released from userspace.

For ease of reviewing, the series has been split into three patches, though
the bulk of the code is still in the first patch.

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
 drivers/input/joystick/nintendo-switch2-usb.c |  352 ++++
 8 files changed, 1953 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.53.0

