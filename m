Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F3374756;
	Mon,  6 Apr 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484211; cv=none; b=CkEB3cNuJB8QMxDmjm25h1nSE7s1hPInw4taq5XkpGiixw3WO0c6hby/SHrYer/EtJ4iFg6YnsrHKX3jPHuPjCUiiy6s0mnWgpua6fLdNv5NRIXe7mwwwvDIrMagAkfcYyas6NWj4Fjfqm7wLfSG1sS0Vnk+utCCMuDt1J06lYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484211; c=relaxed/simple;
	bh=iJ33kI0/6fr4kvyJyEP1PpPSDu+74fr25QsMmwz1ecU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KD+g6NYpN5bVrUbWJE9Z3JDRm1gOeUwo3H8zIFh2oYEeFQMaiW4e+Srk5Spy/hiowsP5wjAqe+0CyGWS4t6E0do4bw5pyiV3nWmFT8D3vDykHXAWdWKOyy35ZSigA2PkG0yMwYgP25olAX3JFPjf3GYoSCGzmcNqV2ZPWGgAa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tDB9DMN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tDB9DMN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3858C4CEF7;
	Mon,  6 Apr 2026 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775484211;
	bh=iJ33kI0/6fr4kvyJyEP1PpPSDu+74fr25QsMmwz1ecU=;
	h=From:To:Cc:Subject:Date:From;
	b=tDB9DMN6RLX0r2LpP7JV6Qk/j8CzYxBY7Wjcb8/sKCTt1Hp53kSbDST1kinGGHFOV
	 4WsW/odtwpfUOPWofWhQcKzkY5jJRLAZrFRGjPjwzQdKwHsOv6ua3FKxF/dwObv8N/
	 gxdVQLeK5GsctyedndXCdVOPU4dEz3i4lpVKA4rc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>
Subject: [PATCH] HID: alps: fix NULL pointer dereference in alps_raw_event()
Date: Mon,  6 Apr 2026 16:03:25 +0200
Message-ID: <2026040624-overjoyed-impart-6fa4@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=iJ33kI0/6fr4kvyJyEP1PpPSDu+74fr25QsMmwz1ecU=; b=owGbwMvMwCRo6H6F97bub03G02pJDJmX9+pm7NyeV1RvXbfo+hYvbRW/mln6VtPnXjlsoMMYZ T3X4aVfRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkvTfD/LQ/YQzpaSusY+oV Dvko71861zCih2F+snZMdqfm1Bdbu5LVfr6qXpJY1xUEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Commit ecfa6f34492c ("HID: Add HID_CLAIMED_INPUT guards in raw_event
callbacks missing them") attempted to fix up the HID drivers that had
missed the previous fix that was done in 2ff5baa9b527 ("HID: appleir:
Fix potential NULL dereference at raw event handle"), but the alps
driver was missed.

Fix this up by properly checking in the hid-alps driver that it had been
claimed correctly before attempting to process the raw event.

Fixes: 73196ebe134d ("HID: alps: add support for Alps T4 Touchpad device")
Cc: stable <stable@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-alps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 21e55f3d0d1b..67179e3fe39b 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -437,6 +437,9 @@ static int alps_raw_event(struct hid_device *hdev,
 	int ret = 0;
 	struct alps_dev *hdata = hid_get_drvdata(hdev);
 
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !hdata->input)
+		return 0;
+
 	switch (hdev->product) {
 	case HID_PRODUCT_ID_T4_BTNLESS:
 		ret = t4_raw_event(hdata, data, size);
-- 
2.53.0

