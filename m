Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AC4F4CF5;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839642; cv=none; b=HbyVh21CGKRDeaRVZZppJ/cVzhfCKrToyReqppUiXwMfMt/bqPMEM8I53C7iBgvMv2hJ3S8miJw4SW5QjL6E/tNeppgqLI41WXdjYDm5YJuZajBgWkktfTWu5MoPKY9QcGTkIJdC/z+8SLXvmDKmSmFHSnVHv8wCtiTdpkvajUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839642; c=relaxed/simple;
	bh=nJPy7UDjWDIiUcSUvFAmlraZpWAPqkdIxP1kCUdLka8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uBNPy1OnSFunSMbqw6F+P06withkj4m4Vx6v18xb+BUerzf7ar8j+6hh0DhT5Mk+i/9Yjq8jaOvl8QRvV5SHtcwAtsmB8IcV0GORMJrU/UVRFJsWiAK0hPmxtXusvXJhn8909r1HSnthi5j4mfc2fUH8EBohDSpWiau10+namPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsZdoJtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsZdoJtP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37C85C2BCFC;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791839642;
	bh=nJPy7UDjWDIiUcSUvFAmlraZpWAPqkdIxP1kCUdLka8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LsZdoJtPEjPMffXDcnqz73sBGjC5jxTSbodpii4j3K4+K2XWx/SgAkXEhWqxIe4Md
	 4T655nWdPHQtuCaL1c6mp25cCgDzsf2APCVXawcj9ly5W6RoEtcpYuVJkYFwhA8ylS
	 ULfu/fNprXqjW/DFZjR6S/GY+5Cq+j2Vxg83MFDgP56D01mV2xXlMpriB3WWz1wqF+
	 y5SV5rFLxuzCTgLZtdPkg32WH3x6Jq/gJsF1jFlgQbgK7QyoAfyFmIX6nr+UBJbmV5
	 FV1zIFwqDeCQOkiDLxdGbeEYqGf6IOElJh9t5zwxhnew9jTuyKgd4JDKrVoH8Uv8q/
	 sHAKN+L4plvrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C53CA9EC5;
	Mon, 12 Oct 2026 21:14:01 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Subject: [PATCH v2 0/5] HID: add battery driver for the UNCTRL RAGE
 Wireless Mouse
Date: Tue, 13 Oct 2026 02:43:55 +0530
Message-Id: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7Zi2oE1ceQ/DYloHWyM/aQtKC
 He34AFcvuT73lsgcvAc4VIsEHjy0fddBnUowDrqHoz+nhmUUGcpZImmwrGzKbywlWgoJQ4zVtQ
 YaqS2ggnydQjc+M+uvdU/jqN5sk2ba1s4H1Mf5r07yW33JzFJFLlzEkqURkutr8ZH96ZIjo62b
 6Fe1/ULid5JQc8AAAA=
X-Change-ID: 20261013-b4-unctrl-m1-battery-4afbaf17c0ea
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791839640; l=1677;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=nJPy7UDjWDIiUcSUvFAmlraZpWAPqkdIxP1kCUdLka8=;
 b=crBZF87C5xtacr5g3Ez3+6yXk5QBDpuM92eqTsSq9hP/ukcARoPm0N0FKvs3/Z0xNBScr/pSu
 n/m3SIEtlL0CpdJPCxnkZEbYZR+FW4F40WU9Cwu5JxN++h+9y8DazZk
X-Developer-Key: i=contact@bishwasaha.com; a=ed25519;
 pk=bW8B6BzX1VU4IIcYagrb5nNRxBho+rTXaQZ8fLx8CoU=
X-Endpoint-Received: by B4 Relay for contact@bishwasaha.com/20261012 with
 auth_id=1168
X-Original-From: Bishwa Bhusan Saha <contact@bishwasaha.com>
Reply-To: contact@bishwasaha.com

This patchset adds battery reporting for the UNCTRL RAGE Wireless Mouse.
Parts of the driver are inspired by the Kysona HID driver
(drivers/hid/hid-kysona.c).

It was tested on an UNCTRL RAGE Wireless Mouse.

Signed-off-by: Bishwa Bhusan Saha <contact@bishwasaha.com>
---
Changes in v2:
- restructure the battery handover to fix the races found in review
- register the replacement supply before the previous owner is torn down,
  so a failed registration cannot leave the mouse batteryless
- deliver the probe-time query reply with hid_device_io_start()
- schedule the polling on the freezable workqueue, no CPU wake during
  suspend
- Link to v1: https://patch.msgid.link/20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Bishwa Bhusan Saha (5):
      HID: add IDs for UNCTRL RAGE Mouse
      HID: UNCTRL: add basic battery reporting for UNCTRL RAGE Mouse
      HID: UNCTRL: add periodic battery reporting using a workqueue
      HID: UNCTRL: keep a single battery when a mouse has multiple connections
      HID: UNCTRL: only report to userspace on battery changes

 drivers/hid/Kconfig         |   8 +
 drivers/hid/Makefile        |   1 +
 drivers/hid/hid-ids.h       |   2 +
 drivers/hid/hid-unctrl-m1.c | 436 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 447 insertions(+)
---
base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
change-id: 20261013-b4-unctrl-m1-battery-4afbaf17c0ea

Best regards,
--  
Bishwa Bhusan Saha <contact@bishwasaha.com>


