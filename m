Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A349DB8E;
	Mon, 21 Sep 2026 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996797; cv=none; b=ge1tc3FzRio/jEc3JPt5IGeJP+dfRKJs04P3Uw0vxNWcca1SxMKkhwquQkpvDH6eAxccFj9stGr40LYPItwkxOI1P7rxxTtvM32Ncsu4n55NxLr5gOqMY4jITbK5G0mP4DrMkgIoySbm5HoBcXiCdJ+W/aX6FciBKR6vYTzEwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996797; c=relaxed/simple;
	bh=/GwFm8YGuKNtWhy+5FLEEpJzllXHxg4Yt37OjV2G+mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/2lDdOVoRnfNkdogngmX+AuFk92XrM4y2SJkd0YvaXsc3B2tFa8Z0NghdvzmqPpAamZqA4O3MxC3AJHnFSilnVovG9YaMrK2IRHYb9Qa5owxJNp0TmvIN3JLwhg9QZmiLUsbAEOB8OkhjZ/1l18P6ElPYtYstgIYAI5ZdI0EtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d85befeb5bf11f19a56ed5b684f684d-20260921
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ff4e3418-4495-4aed-ab25-b067e9505520,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:13aff417612db476555169e270e198a6,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|16|50|99,E
	DM:5|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d85befeb5bf11f19a56ed5b684f684d-20260921
X-User: zhangheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1056557169; Mon, 21 Sep 2026 21:19:46 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: dmitry.torokhov@gmail.com,
	cryolitia.pukngae@linux.dev,
	kees+treewide@kernel.org,
	DongLin_Lyu@outlook.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>
Subject: [PATCH] Input: atkbd - rate-limit unknown key warnings
Date: Mon, 21 Sep 2026 21:19:34 +0800
Message-Id: <20260921131934.677541-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_warn() with dev_warn_ratelimited() for unmapped scancode
warnings, matching the existing rate-limited handling of spurious
ACK/NAK events in the same function. 

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221214
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 drivers/input/keyboard/atkbd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 93650c98206d..26523329040b 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -497,13 +497,11 @@ static void atkbd_receive_byte(struct ps2dev *ps2dev, u8 data)
 	case ATKBD_KEY_NULL:
 		break;
 	case ATKBD_KEY_UNKNOWN:
-		dev_warn(&serio->dev,
-			 "Unknown key %s (%s set %d, code %#x on %s).\n",
-			 atkbd->release ? "released" : "pressed",
-			 atkbd->translated ? "translated" : "raw",
-			 atkbd->set, code, serio->phys);
-		dev_warn(&serio->dev,
-			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
-			 code & 0x80 ? "e0" : "", code & 0x7f);
+		dev_warn_ratelimited(&serio->dev,
+				     "Unknown key %s (%s set %d, code %#x on %s); use 'setkeycodes %s%02x <keycode>' to make it known.\n",
+				     atkbd->release ? "released" : "pressed",
+				     atkbd->translated ? "translated" : "raw",
+				     atkbd->set, code, serio->phys,
+				     code & 0x80 ? "e0" : "", code & 0x7f);
 		input_sync(dev);
 		break;
-- 
2.25.1
