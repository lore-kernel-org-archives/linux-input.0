Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59803AE198;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540426; cv=none; b=RJqww3NM6DqzUIS9pwb5GRATiem5OfxAPqe8NpDU4nAvaX8TRvm3tSZ+7KjtMtY3OBAl52hsvoqmDpgEGoCHJC3cfYJaH6qvwH0iFFR9dL9hnY/5a7ZjEY1YIpx4INUAmKCLpBwA2k/Lv4rzmbRyTHISofIpfsCoBE0qYdDB/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540426; c=relaxed/simple;
	bh=4kUvBf5if1nv9lCc3XUy9wkiVtwtLor6LCOjrtnhe6A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YRqYx1Kp+/ZxgzBgr6J051bQ4uMLmBTQtCaydRzD6Dom5InwGar2RwDXyy/65a/JEBfkKQJFo7j9s6KSRewTazezz6DyRPtK48f4XB6AMBNgEp6PZHIgfZw+6hPh2lQqiwfQuo2HbLUSIHW+yLhhnML5GlCwSJB/34mhYDK10ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU2tuYzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU2tuYzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 795D6C2BCB8;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784540425;
	bh=4kUvBf5if1nv9lCc3XUy9wkiVtwtLor6LCOjrtnhe6A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fU2tuYzQesRoEYwZY90nswPpIwdrN5ol7g6thMvlvzmVZhdQhIJCAqSVqGJIfdQCr
	 jDaxzszcHzIORdjKx6l65V78zcKbQ/60K1rjkTWQL6KOh1IdgU2NLd1zGT56AHXvIY
	 mjrL4S2N95Bw3EkxpCbxkTy+GgrsOD9xtt81TQ6pJcHbE9ow6HWxlbvFZ8Lk9Kpg7y
	 c3PpFpMrn2xR0mSO+9kcEhZaRU1m8Q43uAhjFu1eQ49s3KS9otQsOHBI0JLMdy3MnX
	 YvhrrvSxbOxzrPdI5GBYYLo5VdTpvsVrsoZ63NitXu4rXZfL+CE8iAd5RQwDu0bFz2
	 2IP48Cllg4YzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5477FC44521;
	Mon, 20 Jul 2026 09:40:25 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH 00/10] HID: iio: use local struct device
Date: Mon, 20 Jul 2026 15:10:12 +0530
Message-Id: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzsXWoC/yXMQQqDMBBA0avIrDsQIzWlV5Eu4mSsU8RIJoog3
 t20Xb7F/wcoJ2GFZ3VA4k1U4lxQ3yqg0c9vRgnFYI1tjbMGRwkoEnGK5CfUnFbKGEpJjHVo/GC
 da+8PD+WwJB5k/92719+69h+m/F3CeV53QnWnfwAAAA==
X-Change-ID: 20260720-hid-iio-local-struct-device-1d3af277658a
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784540423; l=1897;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=4kUvBf5if1nv9lCc3XUy9wkiVtwtLor6LCOjrtnhe6A=;
 b=uI65hJeL5pfBPSyjC0Ga+0XuXNfEHKdMLNm+96nFUUs6pvYwp6QxFycRINUWrLYkJOTvY4yqC
 RkuOxHpLJJ6B/0ZWYzxDDki3gTYIopSCzH1kK6ow0JRv5+V1Z31FYuH
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

Hi all,

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Prepratory series to convert all HID IIO driver to devm.

Testing:
  - Compiled with W=1 for each patch in series

---
Sanjay Chitroda (10):
      iio: humidity: hid-sensor-humidity: use local struct device
      iio: gyro: hid-sensor-gyro-3d: use local struct device
      iio: accel: hid-sensor-accel-3d: use local struct device
      iio: light: hid-sensor-als: use local struct device
      iio: light: hid-sensor-prox: use local struct device
      iio: magnetometer: hid-sensor-magn-3d: use local struct device
      iio: orientation: hid-sensor-incl-3d: use local struct device
      iio: orientation: hid-sensor-rotation: use local struct device
      iio: position: hid-sensor-custom-intel-hinge: use local struct device
      iio: pressure: hid-sensor-press: use local struct device

 drivers/iio/accel/hid-sensor-accel-3d.c            | 22 +++++------
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 19 +++++-----
 drivers/iio/humidity/hid-sensor-humidity.c         |  7 ++--
 drivers/iio/light/hid-sensor-als.c                 | 15 ++++----
 drivers/iio/light/hid-sensor-prox.c                | 15 ++++----
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 43 ++++++++++------------
 drivers/iio/orientation/hid-sensor-incl-3d.c       | 20 +++++-----
 drivers/iio/orientation/hid-sensor-rotation.c      | 24 ++++++------
 .../iio/position/hid-sensor-custom-intel-hinge.c   | 17 +++++----
 drivers/iio/pressure/hid-sensor-press.c            | 19 +++++-----
 10 files changed, 100 insertions(+), 101 deletions(-)
---
base-commit: 36c12dbda81c284d72f3c64689461647497b643b
change-id: 20260720-hid-iio-local-struct-device-1d3af277658a

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


