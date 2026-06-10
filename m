Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF83403AED;
	Wed, 10 Jun 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092888; cv=none; b=uli5w8uKXzKU/gb2TA6A+ba6DqAUzvsULClfFPC8Wz2Gxa3RqMrWaZPsZDqPPygWOMLxd9bJCvV9+kuK8Nzb9U9AiYl8sA4I/g14YxBIX0JreGiAKpLwS6on1pqvbL4bx51G+718uOgUQpDg2cVPrf4Mlf3DyTSs78BSTBF0/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092888; c=relaxed/simple;
	bh=7AXB5xi8coVzhUgV8DKF98nwsDiSIQViMUEjy4NYNAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjiYSROb1rmMTPFnu3d7rDm1srvW4MbZODA6W6TEXVGEPsRZWF3DST9gsOHjTUOXJ9b6KeQ7zN1HL1vD9/s2/tK7Q7gqrsbW5tgTPfWi8goZDKylKH6Zmn/REiWQJS0xC0F8ffZTpTgzYiVqr0tDJiimGGbAWS2KpNzgUzRH5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1607efb864c411f1aa26b74ffac11d73-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9d00c963-aadb-4286-85a6-28f08fab3975,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:6427f32b8591aa898f190e26978f97b5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1607efb864c411f1aa26b74ffac11d73-20260610
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 109054828; Wed, 10 Jun 2026 20:01:17 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] HID: hid-steam: fix uninit-value access in steam_get_serial
Date: Wed, 10 Jun 2026 20:01:13 +0800
Message-Id: <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6a27d055.39669fcc.33b062.008d.GAE@google.com>
References: <6a27d055.39669fcc.33b062.008d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reply buffer in steam_get_serial() is allocated on the stack without
initialization. In cases where steam_recv_report() returns a short read or
an error, not all bytes of the buffer are written, leading to subsequent
access of uninitialized memory when checking reply[0], reply[1], reply[2].

Zero-initialize the reply array to prevent KMSAN uninit-value warnings.

Logs:
hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
hid-steam 0003:28DE:1102.0007: :
USB HID v7f.fd Device [HID 28de:1102] on usb-dummy_hcd.1-1/input0
=====================================================
BUG: KMSAN: uninit-value in steam_get_serial drivers/hid/hid-steam.c:457 [inline]
BUG: KMSAN: uninit-value in steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
 steam_get_serial drivers/hid/hid-steam.c:457 [inline]
 steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
 steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
 __hid_device_probe drivers/hid/hid-core.c:2822 [inline]
 hid_device_probe+0x60d/0xb90 drivers/hid/hid-core.c:2859
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d5/0xe40 drivers/base/dd.c:709
 ...

Local variable reply.i created at:
 steam_get_serial drivers/hid/hid-steam.c:448 [inline]
 steam_register+0x180/0x10e0 drivers/hid/hid-steam.c:965
 steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273

Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a27d055.39669fcc.33b062.008d.GAE@google.com/
Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/hid/hid-steam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 197126d6e081..f65ad1a21c01 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -445,7 +445,7 @@ static int steam_get_serial(struct steam_device *steam)
 	 */
 	int ret = 0;
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
-	u8 reply[3 + STEAM_SERIAL_LEN + 1];
+	u8 reply[3 + STEAM_SERIAL_LEN + 1] = { 0 };
 
 	mutex_lock(&steam->report_mutex);
 	ret = steam_send_report(steam, cmd, sizeof(cmd));
-- 
2.25.1

