Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7E381EA4
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066514; cv=none; b=bL3IRRNa0WAjoAeW2msxx102iI4R6miH5dmfamlG6GrknnLjSm8Cw+GmiOp3On43JQmEVb1sM4EjTGmYPtd2GSz1wed8cKhTi58u6XO/UwA5A8lDkmgp8tqKVy//C7AyzFfZxhCBDcjLMjmHcaBnGWNozosjnYd2e+1NcnCKCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066514; c=relaxed/simple;
	bh=Mk1UEW/0OyJaZjPAehnfBWZnUbujy4bagICuF5X2fMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akurpTlcMrDcAYhgSO12R23z2hEPqpzKYugJOYEWRYESrdpnSDuy5pMZe/6P2K0y0Z4symVSOWmlLccVPJ2xUx4NRWNd+KtAc74MWQ82FlNSQam2mUnh+rls3xfPGf+BaBOxJW9ZpSLpHNPc3MpDdm7Y7HI9FrCoMkNS7YMfucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=g2uLrF7l; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="g2uLrF7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786066501; bh=Mk1UEW/0OyJaZjPAehnfBWZnUbujy4bagICuF5X2fMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2uLrF7liEIl7yYfzCu4+Uyyx8kYnP8BElt8/j3VAm0rYXkKC6CDI2Z3b8aTAzOFd
	 yicF1v1VcvNbaDavGcNZ/68uDQov5dowhXFxPbZYZt1CsPsKLVAQFEhuXSgML3wEaI
	 SDMP56O55aU9XqD+C9+ulMwZjg3TNLrT9cxrx4nMUAnxPWPM1N6urSku5LyWEOVSLa
	 qOQLx8Fu7DC3EuTJmlvdGGKqxLlhmQVBAfrTs1/2lxXIb1jgvwurXBtRh//M/5VMkq
	 thEu+klZ3bMZ3kSqkNMGrp4yBDYCj6cVt8kzHTR6l7jrDDN54AGrJQIc463YYjAL7G
	 prIOq6ZY48YCA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 38B4D132033;
	Thu, 06 Aug 2026 18:35:01 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 4/6] HID: steam: Don't set feature reports when disconnecting
Date: Thu,  6 Aug 2026 18:33:28 -0700
Message-ID: <20260807013334.2109386-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807013334.2109386-1-vi@endrift.com>
References: <20260807013334.2109386-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an input device is closed, we set a feature report to reset lizard
mode and IMU mode. However, if the input device is closed because it was
removed, then we will necessarily error out when sending this, resulting in
logged errors. Since an error here is expected, we should just fail
silently.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8d3ef523682b..d95296b28f92 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -490,9 +490,13 @@ static int steam_recv_report_id(struct steam_device *steam,
 	}
 
 	kfree(buf);
-	if (ret < 0)
+	/*
+	 * Don't log if the failure is -ENODEV, as this
+	 * can happen normally on disconnect.
+	 */
+	if (ret < 0 && ret != -ENODEV)
 		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
-	else
+	else if (ret > 0)
 		hid_dbg(steam->hdev, "Received report %*ph\n", size, data);
 	if (ret < 0)
 		return ret;
@@ -570,7 +574,11 @@ static int steam_send_report_id(struct steam_device *steam,
 	} while (--retries);
 
 	kfree(buf);
-	if (ret < 0)
+	/*
+	 * Don't log if the failure is -ENODEV, as this
+	 * can happen normally on disconnect.
+	 */
+	if (ret < 0 && ret != -ENODEV)
 		hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
 				ret, size, cmd);
 	return ret;
-- 
2.54.0

