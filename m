Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069836C9CF;
	Fri, 13 Mar 2026 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387646; cv=none; b=bSBXodXwG7xRH+LYSOf5Pooz7cgzy2cY54XvV5FbSkPddeTiyrCeF/8Ov5EyKRG6bWT8qAQyymodMKp2qVbgolj7a3iyWw6Gg3B1YjE+Zh35ZTtqtQonKB0O4RounNtayZLtT2ghxoJSWtqkwKcFRNUZP1pgrumJhoOZEcG2cFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387646; c=relaxed/simple;
	bh=H1CFBsaIkyQfbdCnL2m+JWCX5uIWvfvwcJttxfEL+KE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rKoGZaOrlobRTIQtQ0YuToMT4TQaAe6GDJQtbKLNmpTMR19rgrog+NT9/xJch3alCbfWv/1dZ34WsNw/Ec7p+EV7LlPXi6GsehKUo9AxhW9uGjYHP8R+elmDTvhl1gOq3ytqGN7aZ9aArEAHROazFb/Bv7ekmgdHxmOd1VgAZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrP0UA21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrP0UA21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D598EC19421;
	Fri, 13 Mar 2026 07:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387645;
	bh=H1CFBsaIkyQfbdCnL2m+JWCX5uIWvfvwcJttxfEL+KE=;
	h=From:Subject:Date:To:Cc:From;
	b=rrP0UA21dBzqdAgMZ5X+Yv5bjTeD3KU/+k6dHoEGoFe1TLKXJGSbtQdqXDccoRaqH
	 +3PgbfDnH0byMbhnqXEWE4EScTopuAu91ARjVJALCVheJuqX7bKCXNWPPyCOZQNLyx
	 2/8tTFxf+lI2akysZJ/gInW72wOHYcYnM6rKysvPqF1B35scDoADb+Q++w5C9XHOBm
	 vV+DURrKLyBHo2BCUqG5IpZvoCJ/vE5a4N1NEt/9sm9ssWe/axsF1tzn0/lbfIv8jZ
	 cWb2CSIVG8pPrysQ1uulUkEhlhnIDb8w0xsvqMqwHcoPcdsgqh46XgaxsXz+zqmN5r
	 d/UlFyqgJzzhg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/4] HID: bpf fixes for 7.0/7.1
Date: Fri, 13 Mar 2026 08:40:23 +0100
Message-Id: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LywqAIBBA0V+RWTcwavT6lWjRY6zZmChUEP570
 vJwuS8kjsIJBvVC5EuSnL5AVwrWY/Y7o2zFYMg0ZLXFWwIuwaGThxMax21fE1HXEpQnRP5DWcY
 p5w/t5nzxXwAAAA==
X-Change-ID: 20260313-wip-bpf-fixes-2fe794000870
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773387643; l=1556;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=H1CFBsaIkyQfbdCnL2m+JWCX5uIWvfvwcJttxfEL+KE=;
 b=5f+QtsqWE3dR9iDB/Cd7v4XC3J7htx6r2N3VgHwDFa1eP7OngFXN7cRi0+l7GsrxnnAJrr0pl
 MVlrZqRx3upDhhSIjjS6knzkpLv6gJzrUa++gny5q1u5yYVOhljdtxd
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Hi,

This is a series that targets a few HID-BPF issues I discovered or I've
been reported:
- first 2 patches should go to for-7.0/upstream-fixes:
  - 1/4 fixes a compilation issue when HID is not enabled
  - 2/4 is a nasty bug which allows a HID-BPF to crash the running
    kernel, so not critical (you need special permissions to load the
    HID-BPF program), but not great as you don't expect tinkering with
    HID-BPF would crash
- last 2 patches are more 7.1 material: basically the LEDs on the
  keyboards are bypassing HID-BPF, and then that made me realize that
  the fallback calls in case of an unnumbered report is not correct (and
  likely unnoticed because I don't think I've seen unnumbered reports on
  anything else than USB devices)

  Cheers,
  Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (4):
      selftests/hid: fix compilation when bpf_wq and hid_device are not exported
      HID: bpf: prevent buffer overflow in hid_hw_request
      HID: fix LEDs when report is unnumbered
      HID: do not bypass HID-BPF when setting LEDs

 drivers/hid/bpf/hid_bpf_dispatch.c                  |  2 ++
 drivers/hid/hid-input.c                             | 16 +++++++++-------
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 12 ++++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)
---
base-commit: 48976c0eba2ff3a3b893c35853bdf27369b16655
change-id: 20260313-wip-bpf-fixes-2fe794000870

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

