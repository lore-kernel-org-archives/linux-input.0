Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707B2F7F15;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814201; cv=none; b=UD0JEFGGDigJW8n/kteQJRLSB/iZa+Rozdnn6AvUWS19WHG191uIt8idr5dKmeIfKyuF2IdnKtE5hyF8Y6+uwqA2CMIQXdLbGDQ+vGb8KhvxHy2hMNxSzCi8B+lfIGSwEJduIDEb1m5f1oHv7fanyhtAfQoJkubJikWVjY278bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814201; c=relaxed/simple;
	bh=Dz56lHO8he1vv9orP1xWMaqbnHaRAuLjNpCvMw/oeR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ptW2MHZDZ2q3vKJI1gew1F4X/LQ7i2twj7vbABIFvti7Qk/JWwCpaursvImtb2xAepmlJ0CAr5rl9jjm5mWtvjg/R0QlK8FgFh2YQI5y69bQzoY3qgWNCLGv1VHmdGrG92/rCm3cLjXwoBTa0M4VW/dyI5ISywUCG3A7lFIZ5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdLfkEpj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdLfkEpj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 425C1C2BCB9;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814201;
	bh=Dz56lHO8he1vv9orP1xWMaqbnHaRAuLjNpCvMw/oeR0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fdLfkEpjVqnbY9FxFDItQ5vjzGlFQCK4SiTL1Scd5riBHwut7UBy+B2xhf2tCdfOt
	 Mkb9N+hjNf6CL0tBrbXjPQm0ft8Gso7VbP6xxjFj7EM8hRlTb0bksCF30IHxXwfsaU
	 OX/lHoiVEo3n4t4gNeUEg3W0hG4h2S1Y9i6yNs95xQu5/MtWsbLm7P7ljzf5r1Exj0
	 O8paWLjt1iuKheB4M+wByJGlxKzM3u+zIpmZjBNE1UnJ70JRHneD4Vpbfn96NeLZ0e
	 CDI1rPBOUt2BgOPfRWbbYQCPbaIU2VoReAuCghkINXQKMtXxuqEEufR/C0FKeb5tfA
	 c2b7AYuNhVNaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3CDC982DA;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH v6 00/14] HID: iio: Introduce devm_ APIs for HID sensors
Date: Sat, 19 Sep 2026 16:06:23 +0530
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdlrmoC/42OTQ6DIBCFr2JYdxr8I9hV79G4oDDoNEUMqGljv
 HtRL9DVvC95ed+sLGIgjOyWrSzgQpH8kEBcMqZ7NXQIZBKzgheCC15CIUGNAYg8BDTzYNQwgQr
 d7DCFpYYJ3QgVVg2ikaJUlqWtMaClz+F5tCfH+flCPe3je6OnOPnwPR5Z6r13OiUXfzrT5WBz2
 xQ6N7Lk9t45Re+r9o6127b9AOVA8wjsAAAA
X-Change-ID: 20260603-28-apr-iio-redundant-argument-v5-temp-4e49eed863af
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=5636;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=Dz56lHO8he1vv9orP1xWMaqbnHaRAuLjNpCvMw/oeR0=;
 b=Hwm6WS3aJO+JiF5ZNf4/y8CcFyKoAwS5naAdP6HrzsnobPjAQt7bHvzAx0McnR/w75y+ahfW0
 cHbR30bQaudCa//Bh3wqPxRCIL9+MIfIDyxJn1ZLiQ/Lu023639RK4G
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

Following feedback from reviewers and Srinivas, v4 series was split
into two additional sub-series to perform cleanup and preparatory work
before adding devm support:
- HID: iio: warning clean up and prefer kernel coding style
  https://lore.kernel.org/all/20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com/
- HID: iio: basic clean up for usage_id
  https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com/

Both series have been merged into IIO tree. This series introduces
device-managed APIs and converts HID IIO sensor drivers to use the new
devm-managed resources.

checkpatch reports a "suspect code indent" warning on the DEFINE_FREE()
declaration, but this appears to be a false positive caused by the macro
expansion. The code builds cleanly.

Changes in v6:
- Following input from Andy rectify kernel-doc for return
- With input from Jonathan used devres framework implemetation with
  cleanup helpder to reduce complexity and resource allocation.
- Link to v5: https://patch.msgid.link/20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com
Changes in v5:
- With input from Jonathan, convert all HID IIO drivers to use
  fully devm instead of partial or specific API; this is potential
  goal and validation on that will reduce multiple validation cycle.
- Rebase changes on latest iio/testing tree and resolve merge conflict
- Resolve mail client issue as v4 series was splitted into sub-series
- Link to v5: https://lore.kernel.org/all/20260524192059.1193716-1-sanjayembedded@gmail.com/
Changes in v4:
- Extend the series to cover remaining HID IIO drivers with devm API usage
- Reorder patches to place cleanup and warning fix at beginning and,
  devm-related changes toward the end based on feedback from David
- v3 series -> https://lore.kernel.org/all/20260509101040.791404-1-sanjayembedded@gmail.com/
Changes in v3:
- Added cleanup and prepratory changes before adding devm_ API
  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
- Address andy's review comment on commit message and coding style
- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
Changes in v2:
- Following input from Jonathan and Andy, squash initial patch v1
  series in single change as individual change should not break anything
- Add devm API support and two driver using the same
- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/

Testing:
  - Compiled with W=1 for each patch in series
PS:
- Sashiko reported an issue in a different driver and noted that it is not
  introduced by this series. I have taken this feedback into account and
  will address the actual issue in a separate series focus on that driver.
- Following input from Jonathan, will prepare followup series for
  HID IIO drivers to consistency support for logs in probe() path

---
Sanjay Chitroda (14):
      iio: hid-sensors: remove unused iio_dev argument
      iio: hid-sensors: introduce device managed API
      HID: hid-sensor-hub: introduce device managed API
      iio: gyro: hid-sensor-gyro-3d: convert probe and teardown to devm-managed resources
      iio: accel: hid-sensor-accel-3d: convert probe and teardown to devm-managed resources
      iio: humidity: hid-sensor-humidity: convert probe and teardown to devm-managed resources
      iio: light: hid-sensor-prox: convert probe and teardown to devm-managed resources
      iio: light: hid-sensor-als: convert probe and teardown to devm-managed resources
      iio: magnetometer: hid-sensor-magn-3d: convert probe and teardown to devm-managed resources
      iio: orientation: hid-sensor-incl-3d: convert probe and teardown to devm-managed resources
      iio: orientation: hid-sensor-rotation: convert probe and teardown to devm-managed resources
      iio: position: hid-sensor-custom-intel-hinge: convert probe and teardown to devm-managed resources
      iio: pressure: hid-sensor-press: convert probe and teardown to devm-managed resources
      iio: temperature: hid-sensor-temperature: convert probe and teardown to devm-managed resources

 drivers/hid/hid-sensor-hub.c                       | 35 ++++++++++++++++++
 drivers/iio/accel/hid-sensor-accel-3d.c            | 40 +++++----------------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 21 +++++++++--
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |  5 +--
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 41 +++++----------------
 drivers/iio/humidity/hid-sensor-humidity.c         | 38 +++++---------------
 drivers/iio/light/hid-sensor-als.c                 | 39 +++++---------------
 drivers/iio/light/hid-sensor-prox.c                | 40 +++++----------------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 41 +++++----------------
 drivers/iio/orientation/hid-sensor-incl-3d.c       | 42 +++++-----------------
 drivers/iio/orientation/hid-sensor-rotation.c      | 40 +++++----------------
 .../iio/position/hid-sensor-custom-intel-hinge.c   | 38 ++++----------------
 drivers/iio/pressure/hid-sensor-press.c            | 41 +++++----------------
 drivers/iio/temperature/hid-sensor-temperature.c   | 39 +++++---------------
 include/linux/hid-sensor-hub.h                     | 26 ++++++++++++++
 15 files changed, 175 insertions(+), 351 deletions(-)
---
base-commit: 9c464e7473f762cee4c031a09da04f65a1c65d49
change-id: 20260603-28-apr-iio-redundant-argument-v5-temp-4e49eed863af

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


