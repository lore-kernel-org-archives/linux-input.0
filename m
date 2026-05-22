Received: from sender-pp-o92.zoho.in (sender-pp-o92.zoho.in [103.117.158.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E54219F8;
	Fri, 22 May 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463369; cv=pass; b=tbSxjkejjwjUrIaX0dMi1+bLIcNPtjOA8gO+E80YeejMtgnSZd+LnOk8/n2cL4YevkewWiBPfrFfT4XkpEbCUz60hGCWLN9iD1meAp5up09k1Mulfg50ueutRWGvd7d03odin7V57ecPaeHmv1sE9bIEcizgm4eZPcgpL/KtLUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463369; c=relaxed/simple;
	bh=Ae1DzuzqXOTM3XWE7TjpPGK7lBcAxG6qyD/iCrP0QDM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=keO0q/U4kbPK+KUG56H/tcnRJUFQfQxgEp+BXzyfTOHnS7q416p2CB3CazoIvpeF6tyRZMwdl02FP+4nyeUV+kuwf7/pEBRndRrl6sFDTj2RZ6D4blt1NoeGSYUJqpJzzrVzZg2Z8VHncsicWqBOeGatV4qty+1ZefTrsluFobA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=rfYGo5Hp; arc=pass smtp.client-ip=103.117.158.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="rfYGo5Hp"
ARC-Seal: i=1; a=rsa-sha256; t=1779463352; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=ZkeBsv4y7FT5LnmGbeH4ewSCVpfOIpuOIxSMSmkZGiTEJJ+ESFTI5o8S3gTJWQLv/7CWri0IYdkCRubzG5bcAujoJZeJWCluu3hWXNA27uKeXFTURB9T1LYTxg2ExqXA5aZcSM2pua+/ZOYQ9zjNeMH8zCshwC6fUdoQQpp2FRM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779463352; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VEXYQVRqPIMklSqhaROOWgl1QvEKSI1VypPj/XL3TKA=; 
	b=dqQCYiZpkN1NO134QOxqGHJ86zV8SAtiKzbcWG1excRZX3P7dGtZQfAnT4zMWmi4ei3Z/Ytuv22AnfgzvM/+xi0s5QwcNxbwcDWfMYTScdn+W+0mcrFVp1eykEEzUBKMTJxnaT9wrK0+2Mr7VBAtfRxo/LtB9SfZxilAn8qvVCk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779463352;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VEXYQVRqPIMklSqhaROOWgl1QvEKSI1VypPj/XL3TKA=;
	b=rfYGo5HpNHmYDd+ZfsoOOyewGJ7FLVEjP/afXDf08Nk/TU+hOVaVzz0bf+RNv9s2
	E2LepXI0qooywYtQeM2tPPeZVUo5EaAtIhoF2qzvLmm8JQreM01Kzifsu2XTdX7hkzW
	q5TfN7Hm0G0rHrO9dFbxmoPeneYmBQA/9Y+dnlI8=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779463350998756.0405156758767; Fri, 22 May 2026 20:52:30 +0530 (IST)
Received: from  [157.35.75.45] by mail.zoho.in
	with HTTP;Fri, 22 May 2026 20:52:30 +0530 (IST)
Date: Fri, 22 May 2026 20:52:30 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "linux-input" <linux-input@vger.kernel.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
	"dmitrytorokhov" <dmitry.torokhov@gmail.com>,
	"ubuntu-kernel" <ubuntu-kernel@lists.ubuntu.com>,
	"hasan6l" <hasan6l@gmail.com>
Message-ID: <19e5047ead1.ce62bdb39017.6022546617731203250@zohomail.in>
In-Reply-To: 
Subject: [PATCH] Input: synaptics - add quirk for Daffodil DC253D touchpad
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From ee16efae3c4371d37467c49c0cae6af808e1b625 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Fri, 22 May 2026 20:48:25 +0530
Subject: [PATCH] Input: synaptics - add quirk for Daffodil DC253D touchpad

On the Daffodil DC253D laptop, the touchpad is incorrectly detected as
a clickpad, causing the right button to be missing. Add a DMI quirk
to clear the CLICKPAD bit for this device.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2153983
Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/input/mouse/synaptics.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 26071128f43a..4ca85fb4ab70 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -534,9 +534,16 @@ static int synaptics_invert_y(int y)
  * Apply quirk(s) if the hardware matches
  */
 static void synaptics_apply_quirks(struct psmouse *psmouse,
-				   struct synaptics_device_info *info)
+                                   struct synaptics_device_info *info)
 {
-	int i;
+        int i;
+
+        /* Daffodil DC253D has a physical right button */
+        if (dmi_match(DMI_SYS_VENDOR, "Daffodil Computers Ltd.") &&
+            dmi_match(DMI_PRODUCT_NAME, "DC253D")) {
+                info->ext_cap_0c &= ~BIT(20);  /* Clear CLICKPAD bit */
+                psmouse_info(psmouse, "Force right button on Daffodil DC253D\n");
+        }
 
 	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
 		if (!psmouse_matches_pnp_id(psmouse,
-- 
2.43.0


