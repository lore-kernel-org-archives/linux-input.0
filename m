Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01F25F7B9;
	Thu, 19 Feb 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511655; cv=none; b=oLhc61T/tXjew8RWD3DWIU9Lx8T+6mPHPTmIKo1hbWnnHCAUQwQ5PSEiS9HnYTjp/hTJ3RmHNr65LVs4BmoCYvGtfnZ4+b5raezjCe3XpU+2eJua8F3hkdVeHiX2LcPrmDEOcj+s/k7a8HNKjQkNKFeTRMiR7As34iJCnWzCPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511655; c=relaxed/simple;
	bh=Y1Gw0i7tZuubG+bD676bdowu/XQAZCncGPdCf1OK6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXkV+rREZWK887cVzLXVcr3P0z7dhVDsc4p0j/ZL4DngQuCN99vW74+pCneVy9BHSxxbhNneejNlsqO/eNN2Lce7/jvXuyKne0xHREzwcuoF9dcLNq0cckpUu+DAj7m051Ef6f6QSXQ/AuZ7k0BTGePCENlVMu4u7mzs+Brhg+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KJDMOtcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJDMOtcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411C6C4CEF7;
	Thu, 19 Feb 2026 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771511654;
	bh=Y1Gw0i7tZuubG+bD676bdowu/XQAZCncGPdCf1OK6gE=;
	h=From:To:Cc:Subject:Date:From;
	b=KJDMOtcDMRamYiGgsHunnQjUkNXAv8I8afhgJjh9BmtMETKC+jLSXVQERPBId8cK1
	 Zxu1ToPQ1dWG2GooSSM+PigBsMZ7YOUYAUKOmJmqWuj/ewOW4+GSOVz5bj7aZbhKfH
	 2ON5Gbeo8jfs4m8WGvdFvKL+GJ1/0VQqjuZTuJzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	stable <stable@kernel.org>
Subject: [PATCH] HID: Add HID_CLAIMED_INPUT guards in raw_event callbacks missing them
Date: Thu, 19 Feb 2026 15:33:54 +0100
Message-ID: <2026021953-entitle-panoramic-0927@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Y1Gw0i7tZuubG+bD676bdowu/XQAZCncGPdCf1OK6gE=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnT5QMls/0P3TM4x3he5enU49+q/vmX7Ksx/ygr9fHny deXNKaWdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEHiUwLGhZeu1agEZthLZE kGn61V695RdKYhjmxye9Z1pjUxduzFob+VyD9b5qZ0soAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In commit 2ff5baa9b527 ("HID: appleir: Fix potential NULL dereference at
raw event handle"), we handle the fact that raw event callbacks
can happen even for a HID device that has not been "claimed" causing a
crash if a broken device were attempted to be connected to the system.

Fix up the remaining in-tree HID drivers that forgot to add this same
check to resolve the same issue.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This issue was found by running a tool to compare a past kernel CVE to
try to find any potential places in the existing codebase that was
missed with the original fix.

 drivers/hid/hid-cmedia.c          | 2 +-
 drivers/hid/hid-creative-sb0540.c | 2 +-
 drivers/hid/hid-zydacron.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cmedia.c b/drivers/hid/hid-cmedia.c
index 528d7f361215..8bf5649b0c79 100644
--- a/drivers/hid/hid-cmedia.c
+++ b/drivers/hid/hid-cmedia.c
@@ -99,7 +99,7 @@ static int cmhid_raw_event(struct hid_device *hid, struct hid_report *report,
 {
 	struct cmhid *cm = hid_get_drvdata(hid);
 
-	if (len != CM6533_JD_RAWEV_LEN)
+	if (len != CM6533_JD_RAWEV_LEN || !(hid->claimed & HID_CLAIMED_INPUT))
 		goto out;
 	if (memcmp(data+CM6533_JD_SFX_OFFSET, ji_sfx, sizeof(ji_sfx)))
 		goto out;
diff --git a/drivers/hid/hid-creative-sb0540.c b/drivers/hid/hid-creative-sb0540.c
index b4c8e7a5d3e0..dfd6add353d1 100644
--- a/drivers/hid/hid-creative-sb0540.c
+++ b/drivers/hid/hid-creative-sb0540.c
@@ -153,7 +153,7 @@ static int creative_sb0540_raw_event(struct hid_device *hid,
 	u64 code, main_code;
 	int key;
 
-	if (len != 6)
+	if (len != 6 || !(hid->claimed & HID_CLAIMED_INPUT))
 		return 0;
 
 	/* From daemons/hw_hiddev.c sb0540_rec() in lirc */
diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 3bdb26f45592..1aae80f848f5 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -114,7 +114,7 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 	unsigned key;
 	unsigned short index;
 
-	if (report->id == data[0]) {
+	if (report->id == data[0] && (hdev->claimed & HID_CLAIMED_INPUT)) {
 
 		/* break keys */
 		for (index = 0; index < 4; index++) {
-- 
2.53.0

