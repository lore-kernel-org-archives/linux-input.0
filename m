Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A034E80D8;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836134; cv=none; b=Gp2nmW4FEVUfU2ke9PyIe4rMwT97yUHwG9Bkc5S/7RWp4XpCK6JkxxPNmEp+ZuxccJnh8luPf6YxaOf+2s/KJqpVo8BwT4Wg1c8R5RterBBCUcJfnFYizKAitriSTCdUr3mCPzCX25EeRyEXGoe/XNNkW+KQTD6xNwiQcfVkYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836134; c=relaxed/simple;
	bh=ZQd8UAjXxdtjHCZDOWEnDScNlUHYQJBvBegfhdRjMc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jgBtljlM1PnFhZyAVGMLW0uwj7pfQj/dUUpS6u3Kxiw0B39UgCNas302GphDy8jsagCxK1GcJ4797pWzzi6QeO2Ray5V17J7WaGCisuH0fob/QTeWxYvxMxTCjnahO/+T5EwI4tjrlrwcZNK4dp0sdGnnc+gUjbDMWZQEliAQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhKmuEuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhKmuEuX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D699AC2BCC7;
	Mon, 12 Oct 2026 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791836133;
	bh=ZQd8UAjXxdtjHCZDOWEnDScNlUHYQJBvBegfhdRjMc0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HhKmuEuXgP7rdLmkLsTrIUR3WLlAbSVzMZSGkggXoJr89EArFKrQjmI2uq+agiwjI
	 +pcyvvo/0pcUVqB+VAXglkNXNa3CMx/MutF07zJ8dd3jBwBOYLYU4OhSczNibfKCQh
	 rWHZOT1cR8LoPce5V4iqX5oy6WLpZSQw5Dap12UJejgqhOo1HBaYMBVU0QKx8pArez
	 +TH5+n04hJxhATJ/tcu76eLdH8Vbby/0iVsfgidjf3NkBDAqNnCLSyDo8UF12Mmb7o
	 t8Xn9WAFVETDCCMMFOtppD4TpnwGuGtoSa2Xr/W74d/bhXqyAu/z9FulaQ4O0L+Rrx
	 t4BmQijiRNH6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF33CA9EC5;
	Mon, 12 Oct 2026 20:15:33 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Subject: [PATCH 0/5] HID: add battery driver for the UNCTRL RAGE Wireless
 Mouse
Date: Tue, 13 Oct 2026 01:45:22 +0530
Message-Id: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORto5tjAVxEPaZe6DK2SdqKMv
 fuqHr/D/6+QxVQynJoVTF6a9ZEq6NBAmDhdBXWshta1PTk6ou9wSaHYDe+EnksR+2DH0XOkITh
 hqOnTJOr7tz1f/s6LnyWU7wu2bQch9LbKeAAAAA==
X-Change-ID: 20261013-b4-unctrl-m1-battery-4afbaf17c0ea
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791836132; l=1047;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=ZQd8UAjXxdtjHCZDOWEnDScNlUHYQJBvBegfhdRjMc0=;
 b=b/JBuK54J2z3qKaxtebHMhp51n8aSRuTwwDPzszk9cMJZ8BFDRguCWR1fp5RtOzjDrO4ebk+D
 HXh7V3mDxmqC29iisNP3uELJSzBaD//wzOV2nJAwWhq6NEaSEZFLMI2
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
Bishwa Bhusan Saha (5):
      HID: add IDs for UNCTRL RAGE Mouse
      HID: UNCTRL: add basic battery reporting for UNCTRL RAGE Mouse
      HID: UNCTRL: add periodic battery reporting using a workqueue
      HID: UNCTRL: keep a single battery when a mouse has multiple connections
      HID: UNCTRL: only report to userspace on battery changes

 drivers/hid/Kconfig         |   8 +
 drivers/hid/Makefile        |   1 +
 drivers/hid/hid-ids.h       |   2 +
 drivers/hid/hid-unctrl-m1.c | 426 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 437 insertions(+)
---
base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
change-id: 20261013-b4-unctrl-m1-battery-4afbaf17c0ea

Best regards,
--  
Bishwa Bhusan Saha <contact@bishwasaha.com>


