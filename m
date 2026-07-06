Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F33911B8;
	Mon,  6 Jul 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364407; cv=none; b=YFBgWGXgdDS2yXyPgdT48U9okuObS1gu3+g6T+HPC320DEyZO7yUTwKFoRPSZquqtsZOwVfeVHRK0MDnWzgKK9q0qJY9P7nrq5Wln+rStAbMMPCKnsriZxb+3JrEyHlAcFfMBns6HAUrkxgP1Xf5t6nn1j2IM/GJdsR04QhrRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364407; c=relaxed/simple;
	bh=ettpJxnb6azjELpGMnVt8XxE9lKyWlE5LuIQyE/jaDM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=axCwi1M3DToiO9iMycmX52AfKcFO+7pgp/b4Jx0BB0gpEjTzv8jWZRg2s4PKwN4wLF0WrdjrkBzouTdiVTGdDNVYCLvcJinfrhLCwcMQC1tqC8vNeUmRSq5IAhexUUqatlYrCqLFDSm1u1hbtF3flYoV6RLEJZwyq2yeTGH1qfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N19adXgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N19adXgx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8987BC2BCB8;
	Mon,  6 Jul 2026 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783364406;
	bh=ettpJxnb6azjELpGMnVt8XxE9lKyWlE5LuIQyE/jaDM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N19adXgxStSETkPCUiw306p9SLv8/KzudEuliw48xHdCLpFuxfPr28nePmfkIzXzn
	 +xNBST/f2Bm0ieTU0ioKAqpRdHq1kgUwqHfiwJ9acqPehvhGP1NAp1+XATY4vvbIpN
	 moNXb6xDwWqorWdQ2UC5FRyrOBu2vkuAH0gOWJWtHmWtPqwHACiyVO6n7pawFNY9qe
	 4LbcrEmyq5eialdsFzosqnswsTzf+MJGoSXxydpNUmlqGdxR6jK7SOFAf/qym6YRHM
	 LlLgm/ivx0JPTFYckV8DssBr616/+7z8kF7fMgCPssfSeWAEYKg9ylOcleQ4g7Zq4/
	 OahjBKROgG44Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E9C43458;
	Mon,  6 Jul 2026 19:00:06 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] HID: iio: warning clean up and prefer kernel coding
 style
Date: Tue, 07 Jul 2026 00:29:42 +0530
Message-Id: <20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB/7S2oC/3WNQQ6CMBREr0K69ptahKor72FYtOUXPoHWtEA0h
 LtbYG0ym5fMzFtYxEAY2SNbWMCZInmXID9lzLTKNQhUJ2aCi5KXlwJSuslBSzUQeVA9NW5AN8K
 11FpJIe8ac5bm74CWPvv1qzo4TrpDM25/W6OlOPrw3d2z2HqHRnLxXzML4KBv0vKLLdBq82wGR
 f3Z+IFV67r+AO3GJ2jSAAAA
X-Change-ID: 20260615-15-jun-hid-iio-alignment-46bba7279be3
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783364398; l=3058;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=ettpJxnb6azjELpGMnVt8XxE9lKyWlE5LuIQyE/jaDM=;
 b=HHBJPGszaPcPmceyqV0+SHMXDbnNHpQzCJ3mycV++zp+2uZSt/98u0ivvDRpBNOTRZdRnMzsK
 mtH+cA49LLBBlm/H6SQyy7KKg7rZOSYR5jiZ1rKUz71FnQpg0DDPSGD
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

While updating alignment and line wrapping, function parameters are
grouped more logically and common callback signatures are formatted
consistently across HID sensor IIO drivers.

Testing:
  - Compiled with W=1 for each patch in the series

---
Changes in v3:
- Rebase series on top of iio/testing where parital v2 series is added.
- Rectify commit message and resolve inconsistency highlighted by
  Jonathan.
- Link to v2: https://patch.msgid.link/20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com

Changes in v2:
- Following input from Joshua and Maxwell squash all related changes
  in single change as this is code churn.
- Following input from Andy (re-)split function argument/parameter
  logically.
- Added review tag of Maxwell to implicit NULL check change while
  drop for parenthesis alignemnt to have a fresh review.
- Link to v1: https://lore.kernel.org/20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com

To: Jiri Kosina <jikos@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Sanjay Chitroda (2):
      iio: hid-sensors: align function parenthesis for readability
      iio: hid-sensors: Use implicit NULL pointer checks

 drivers/iio/accel/hid-sensor-accel-3d.c            | 48 ++++++-------
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 80 +++++++++++-----------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  4 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |  2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 35 ++++------
 drivers/iio/humidity/hid-sensor-humidity.c         | 33 ++++-----
 drivers/iio/light/hid-sensor-als.c                 | 32 ++++-----
 drivers/iio/light/hid-sensor-prox.c                | 29 ++++----
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 53 +++++++-------
 drivers/iio/orientation/hid-sensor-incl-3d.c       | 33 ++++-----
 drivers/iio/orientation/hid-sensor-rotation.c      | 26 +++----
 .../iio/position/hid-sensor-custom-intel-hinge.c   | 13 ++--
 drivers/iio/pressure/hid-sensor-press.c            | 35 ++++------
 drivers/iio/temperature/hid-sensor-temperature.c   | 30 ++++----
 14 files changed, 208 insertions(+), 245 deletions(-)
---
base-commit: 4c0ecdbdc0d87570f74e656e21d56bae1ab6a8f1
change-id: 20260615-15-jun-hid-iio-alignment-46bba7279be3

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


