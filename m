Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67944371D15;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836134; cv=none; b=gUbPJz2TxCE3ngbGcloniZbwZbaAIiigNGr3MgVRkx2e7+0SivtIlgusRVmizFFso/Wxr1qdR3b8dbhZ8XvTKE8AFIRh3wtjyAValUo8W2yjKDhY5k4HhfhUfYbfPSazSdKg923capOT8u4Ya3nQJdGc8+3v/5UoqEBvzVbtNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836134; c=relaxed/simple;
	bh=CtrOBHkVief6iwoUyjUbnXd3F5fpTmL3sErRAFLRZhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECClpsKTiIeKI7BzcdNWAY+UM0lX4saKMpo8OSJpgwjTZdUYWN+1xq1VrvJlnEflYKHD9F93BsLXMbBLrRBPnuPbc9nmX7LaGCrb92v7qHkXfAblTIfugN6idtZFH9TpayqvW+BEdV/hYAYLmIeA6Jd4LdUfj+7X8B232G3KDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCzL184L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCzL184L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8F84C2BCFC;
	Mon, 12 Oct 2026 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791836134;
	bh=CtrOBHkVief6iwoUyjUbnXd3F5fpTmL3sErRAFLRZhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YCzL184LxnoY+2/w+J3y/bZimw4xVeiKA2S5rfaWqzRd3xNu32gwQpNUw5qpwGCqD
	 w0G2lv0KMWs21VIl+6wOXPbJledpRpX36tps6DDRbHkX0r9ulRQbqerUcbZgESSk14
	 HxesNKrNyVO5lcD8TISG50VB4d8d1B9QxE++LSMv43Zzitk0/54tep/b0YRwqaOak3
	 sk8grftIllQId33yyr3WX1DfaoH06p+8wFdXtKXifTRTZt05+I4pEt1A5wxGVW5LZD
	 nt6yY6gdbt+ltpKCV3hvo6iRuuSFWbYyL2ZFSIJkN3fyULmxKSlX2sEqP6QZcHuYJU
	 lktJdgEJukobQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503ECA9ED0;
	Mon, 12 Oct 2026 20:15:33 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 01:45:23 +0530
Subject: [PATCH 1/5] HID: add IDs for UNCTRL RAGE Mouse
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v1-1-4a50203b7177@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791836132; l=749;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=fIXuct51biCVxZ2lNfnwp7ct6qZ/yUIRAhnNtUxASx0=;
 b=DR12+yzzMS+n+/FH7MxUmLaiIvcd8nM6TNe7wy7b8xFyaOMicVJCTEfM/NYUdR0rS6Jf/Ot0r
 dFVtf4egmN2A2ZEg1UBI12+stCwDrbbF6aiPj4zk58w4WDAV/ziGRDO
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


