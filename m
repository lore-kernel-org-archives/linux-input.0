Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB443ACEF7
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086549; cv=none; b=Y1EuFty3jxfZy/fCRshEHzqasjkt87dmP1eb9/tKwo5GaQFx6RQ9m3mHlT09qikxxzHSA5rwlDwCcbATlm2SLX+nP4y319sWI+wwPBTYPIwWFLkZvBIkiRef/4lHaBPJYaPsnse4url1CXqsyy/UvbacVrUd/4bgnqAoaFC7TLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086549; c=relaxed/simple;
	bh=AvrmOFuuC64gag4WWzywTgiA/iG+ttk39Nq6JaJh5b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGqYozpMgjjLCTVaERSWMW/deOZ92y3aoLmlkdhEclCpsgY9IQ+3D2i5RAnt8tQCx5bxUyylWA9gMnIlVdvDIinqLzNTKK8qDx568hVjSLGh7ER6XFunMpXP743wEleO3pkpBwMvdvU0ehizYugatz8xQye1jTLeiUW5fbhQvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=BLAox8BP; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="BLAox8BP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1784086522; bh=AvrmOFuuC64gag4WWzywTgiA/iG+ttk39Nq6JaJh5b4=;
	h=From:To:Cc:Subject:Date:From;
	b=BLAox8BPqDYvj9VO9HyH2CwLBVNcv2+mR6iSyzLm/S/OqAAlBMbUCNRsED0qR+Qjc
	 cxVZe+Y9MHID6elMQdIfz6YDXIK5oop0dClspjbYg3TMyXB6KQyeLzou2aABNlqMQA
	 dpNgJ5lov96v2LUHnWG0i9Kn7u0yGpP9vsh1exHoAKqTC5Ui4sKMnm9IKWxC+SKdfK
	 i63lCo4shVhvAkBn5m91fnANkA+JjpMQAYG6cPCFIgJDmpyismMVEjRLuQViQgY5jc
	 mcr8u/kkxVc0B8+/yyVxqtzmi/ep+EyxBWcL3qdvEoSIPTa8Smc/j38oiuq7Dbp3Gq
	 QtV2S2lYRnIIw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 25309A028;
	Tue, 14 Jul 2026 20:35:22 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v12 0/3] HID: nintendo: Add preliminary Switch 2 controller
Date: Tue, 14 Jul 2026 20:34:03 -0700
Message-ID: <20260715033409.3599913-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. This is a minor iteration on
v11, fixing some nitpicks. It should be fully ready now, pending review
from Dmitry and a HID tree maintainer.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1682 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  475 +++++
 8 files changed, 2224 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

