Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C6302149;
	Tue, 28 Jul 2026 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207498; cv=none; b=ercegz8Sik9UHXaRtezygHVBEpWKMytk8VwIDe0jwoSksVBZFZBxiN0TmvK6wzSq0AFjaTV/5fNUCVoUXYxo/yM5pwVKRsVGif2O28JYRNI4BQst1GCMpYvrust29Eimms6pIuYp/c7UE6Y0ZnwpUdPOTRuI+LpoUejNdYnxvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207498; c=relaxed/simple;
	bh=nIFBgqUX57hUslYEB5muKT+HiwYCrUNUPj5hvoxxF2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXnI+PNlwI67E9Vt8yLuM/0QdGf3G8eaiJG0WpBE0LjkTNlarvSwMh3J5Tel+GfEatKW3nIev+OAkkfXH1dCTJzsc95EMH4S5iZ5PVgB5BBwPtCgmOLScQmHOl78KkRxhfpFkEHAgIZm0amywIAiE+0hz0/LJgYIRUZiLQ3revY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2babb8868a3011f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c4edd0b0-ca24-4091-8074-7564976c40cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:481a2208b4d45ae7ed27b28525271e96,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2babb8868a3011f1aa26b74ffac11d73-20260728
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1050453980; Tue, 28 Jul 2026 10:58:12 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: bonbons@linux-vserver.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	even.xu@intel.com,
	xinpeng.sun@intel.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccc194101@163.com,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH 4/4] HID: intel-ish-hid: Use secs_to_jiffies() instead of msecs_to_jiffies(sec * MSEC_PER_SEC)
Date: Tue, 28 Jul 2026 10:57:50 +0800
Message-Id: <20260728025750.48249-5-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
References: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the standard secs_to_jiffies() helper instead of open-coding
the conversion from seconds via msecs_to_jiffies(). This is more
efficient and improves code readability.

Detected by Coccinelle:
./intel-ish-hid/ishtp/ishtp-dev.h:272:25-28: WARNING opportunity for secs_to_jiffies()

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index 4b0596eadf1c..9457c30b1507 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -269,7 +269,7 @@ struct ishtp_device {
 
 static inline unsigned long ishtp_secs_to_jiffies(unsigned long sec)
 {
-	return msecs_to_jiffies(sec * MSEC_PER_SEC);
+	return secs_to_jiffies(sec);
 }
 
 /*
-- 
2.25.1

