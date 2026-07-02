Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA330E82D;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009084; cv=none; b=iaYGPJxPU3KGMKVs1Qi6jKHuHq8cysqOhQHCLKE8k5NuYZd5T42PVCY2FAac8LDt+gWmzBoaziGOs+gEhtsu5mOk0gF0YF5GTnTB7QECKvs0RznxV7obNRD2Bhl8QfVGhVB8xW+m0n/185K12/fLT/LS6eZ7Mn1drzclwwluyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009084; c=relaxed/simple;
	bh=H84tp6VY6Sam5ASd9ZGje9vIpeCKL1iSSCeKb73Z8gI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rJqZuMmSDJT+wM5AtCP3m3PTe0zCPp/PGTUBpDx2vUdftM5mpZ2cVcqJGIjtqmQUOxl0zC2uo4v5Yxdy3CQdlhZdNwy+2i1VwaKmvvvRjioDGlT4fFISzVhFDTn82ZYn/cuLoQ8MSppnFmr2DMMlNK05tnv+YDW1dOpJX7coOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3GAsfKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3GAsfKy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2150DC19425;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783009084;
	bh=H84tp6VY6Sam5ASd9ZGje9vIpeCKL1iSSCeKb73Z8gI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=s3GAsfKy6pmlkDNxNWQuWo3qEGiOmaprYkTY45KWuTlJITf7t7XscLg/gyvG1+qht
	 5jI56WMjXj2giENvzI12lUGTGBObshNyGEZZ3hTtpiAOwsLaDhUjvuejM0t4x9H9wz
	 ns+IHeKNdZM7BiuhtBnMim285Pp07nfNZo+93FMVyh+7j7PR+aQF0zWKdJEvw5pG69
	 8UjW1lCh23iMqK3KXwSpOv8GVa0S9EAQId1mi8Gi9MfqpR5Tp2J9DFFI2JMncBa+yl
	 w4Jx1sUYkhfzbsLXgI5SXkF0jyjcl91qUMhCLuBg8DiEGoAnhPhovRq+e+Ti3jROr1
	 RP7oo3CbLYitA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2284C43458;
	Thu,  2 Jul 2026 16:18:03 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH v2 0/6] HID: iio: warning clean up and prefer kernel coding
 style
Date: Thu, 02 Jul 2026 21:47:57 +0530
Message-Id: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADWPRmoC/yXMwQqDMBCE4VeRPXfBRhtpX6V4SHSrI+1aEhVBf
 HdTC3P5DvNvFCVAIj2yjYIsiBg1wVwyanqnnTDaZDK5sbm93jhtmJV7tAyM7N7o9CM6cWm9d5W
 p7l4KSvdvkBfWM/2s/46zH6SZfj3a9wO6eN4PfAAAAA==
X-Change-ID: 20260615-15-jun-hid-iio-alignment-46bba7279be3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>, Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783009082; l=3144;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=H84tp6VY6Sam5ASd9ZGje9vIpeCKL1iSSCeKb73Z8gI=;
 b=wqIOthKGsiN2FGrNz3Q8Wa0ak//xtQXTL+FMLmzUnGXhvwxvFDN7GEcvPjwKZOyi1qlll0Pgr
 dDOFyxpjheQBywREcauC0R+MIzPgt3bZj5oW2LcWW2W7g94jgU80XO9
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

Hi all,

This series updates HID sensor IIO drivers to address checkpatch
warnings, improves readability and compliance with kernel coding style.

The changes are:
  - replacing explicit NULL comparisons with implicit pointer checks;
  - adjusting indentation and alignment;
  - reformatting multi-line function declarations for improved
    readability and consistency.
  - use common device for devres framework;

While updating alignment and line wrapping, function parameters are
grouped more logically and common callback signatures are formatted
consistently across HID sensor IIO drivers.

Testing:
  - Compiled with W=1 for each patch in the series

---
   Changes in v2:
   - Following input from Joshua and Maxwell squash all related changes
     in single change as this is code churn.
   - Following input from Andy (re-)split function argument/parameter
     logically.
   - Added review tag of Maxwell to implicit NULL check change while
     drop for parenthesis alignemnt to have a fresh review.
   - Link to v1: https://lore.kernel.org/all/20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org

---
Sanjay Chitroda (6):
      iio: hid-sensors: add/remove blank line
      iio: hid-sensors: align function parenthesis for readability
      iio: hid-sensors: Use implicit NULL pointer checks
      iio: humidity: hid-sensor-humidity: use common device for devres
      iio: position: hid-sensor-custom-intel-hinge: use common device for devres
      iio: temperature: hid-sensor-temperature: use common device for devres

 drivers/iio/accel/hid-sensor-accel-3d.c            | 48 ++++++------
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 89 +++++++++++-----------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  5 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |  2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 54 ++++++-------
 drivers/iio/humidity/hid-sensor-humidity.c         | 49 ++++++------
 drivers/iio/light/hid-sensor-als.c                 | 32 ++++----
 drivers/iio/light/hid-sensor-prox.c                | 29 +++----
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 76 +++++++++---------
 drivers/iio/orientation/hid-sensor-incl-3d.c       | 33 ++++----
 drivers/iio/orientation/hid-sensor-rotation.c      | 26 +++----
 .../iio/position/hid-sensor-custom-intel-hinge.c   | 15 ++--
 drivers/iio/pressure/hid-sensor-press.c            | 35 ++++-----
 drivers/iio/temperature/hid-sensor-temperature.c   | 42 +++++-----
 14 files changed, 252 insertions(+), 283 deletions(-)
---
base-commit: 16f3a4a21cab16dc9242a2e0749b026e1f2c5706
change-id: 20260615-15-jun-hid-iio-alignment-46bba7279be3

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


