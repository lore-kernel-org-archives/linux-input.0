Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA84BB263;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839642; cv=none; b=jjbfWVNy7bI4wEAsMAjgei571049cbmqCHhjfqjcArEvYkD5hlpEQ+HlOGniaCNhaOhGU5U6TktTcIIgy7abZmySCHRXBFj3/zHf6smIvD/y0a9bbshnv056qyI/chq6dwzWSbydWCaTwd2xMPELSI9y95sQ0lBRZLro6bON/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839642; c=relaxed/simple;
	bh=CtrOBHkVief6iwoUyjUbnXd3F5fpTmL3sErRAFLRZhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mt2iTHd2ZUTO9k/Y88WZPzfwU1rsgWvwbzzaceEWyu4Ebl6zE6eg7OGSlrmRfyA4JIk10OJb9Kmqw2O/9PKQ/ITEaXnt+mT7saqlnPyi6mVau44AayXHSFO3+bWSVHzaIByGkpk2RjKSY1gBEdqezzzKUTNC9sqVGgTbqITwDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORPlnTiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORPlnTiX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33B82C2BCF4;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791839642;
	bh=CtrOBHkVief6iwoUyjUbnXd3F5fpTmL3sErRAFLRZhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ORPlnTiXiUKunZ6S/u4FUjnlspyclv4TruQWdngJh0ESJA/MvgYgZYCHebd9H+aCG
	 IiNGqj3CFrdjUGv+/M9YYTzO9XyFFVnE91VRajS1qBfEb/i+b3X7MKGwq+NCBp3L5l
	 FzVZyZpH/oajsmTKO5rhftq5aikH4E9ldpPXthAPT2Z0PvnjkALPDjYmp6JbVkfo4S
	 UtnnsNeBlFDkZAR0xk+5mDWTMrvx8G7SEYUvQVE7jb3SN9xEV7Xw3b5/lqRjInl9Rx
	 fdafAZ3IstL6Jo002vb4e1+HYnP5nOHp8fmSMiEvHAx/bPKUZrrE7Z6VYMoItUZ62f
	 V/AH7uE5fWkwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A89CA9ED0;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 02:43:56 +0530
Subject: [PATCH v2 1/5] HID: add IDs for UNCTRL RAGE Mouse
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v2-1-bd6752021753@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791839640; l=749;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=fIXuct51biCVxZ2lNfnwp7ct6qZ/yUIRAhnNtUxASx0=;
 b=uvnvLJ5/qXD787kWb4Kms/CVCYwo1szY3L43L1lLDGIKUKC8gGBZDhfRUM1DJ+P2CkWqaO9m4
 Bl2ZsJMv8xDA5BAUyRmLAKmlcNW/rNZAW88tdJZNxMVakq83wpjYveU
X-Developer-Key: i=contact@bishwasaha.com; a=ed25519;
 pk=bW8B6BzX1VU4IIcYagrb5nNRxBho+rTXaQZ8fLx8CoU=
X-Endpoint-Received: by B4 Relay for contact@bishwasaha.com/20261012 with
 auth_id=1168
X-Original-From: Bishwa Bhusan Saha <contact@bishwasaha.com>
Reply-To: contact@bishwasaha.com

From: Bishwa Bhusan Saha <contact@bishwasaha.com>

Add the product IDs for both wired and wireless (dongle) mode of
UNCTRL RAGE mouse (also known as UNCTRL M1).

Signed-off-by: Bishwa Bhusan Saha <contact@bishwasaha.com>
---
 drivers/hid/hid-ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a9537b7bb..fb4c25c71 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1008,6 +1008,8 @@
 #define USB_DEVICE_ID_MADCATZ_RAT5	0x1705
 #define USB_DEVICE_ID_MADCATZ_RAT9	0x1709
 #define USB_DEVICE_ID_MADCATZ_MMO7  0x1713
+#define USB_DEVICE_ID_UNCTRL_M1_WIRED	0xA09F
+#define USB_DEVICE_ID_UNCTRL_M1_DONGLE	0xA0AF
 
 #define USB_VENDOR_ID_MCC		0x09db
 #define USB_DEVICE_ID_MCC_PMD1024LS	0x0076

-- 
2.56.0


