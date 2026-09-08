Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE91DDFE;
	Tue,  8 Sep 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831537; cv=none; b=B9inH2M6Fwg52/sLQh+E3PFRSNuiyzwPGCajYM7QQdciq4S2FsXWpM8R60HJN67owc6dsEPXsaEKM9UGm1Ay7DkNGwhH3e32nusSG8y5yUagyGc++7Pb5/YBg9uIZGrQ9Sk10hnXg5smhvZ0DG6LrrHEBSOcrmW1zXEQz7pHJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831537; c=relaxed/simple;
	bh=ZwuL+NpKptaC3NHkf0cJJv6UAswEEY5MEGKQ3VLIozQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrnAzPKr+0CkxcIMjZFj016WbyZYwmHDoLTELgme+COPQdzd7tdBKHyp4fpQe7ZbpmNfln2eUJN9VgYNzYsy1DXlb1KhtfifNSFwSPiZwnwXoKXRu9957SKFtRGNXIrqftDJGVmFxgX329uFGW+EZaESEwM/mvCT7UJyI+NK4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=u5u5ZIb4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u5u5ZIb4"
X-UUID: 09a826c2ab2611f1b1788b6acf885367-20260908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ttyj7YvlZDm9hKVv/iwpJrgcMVPyuqSO8ZB2OYik/Po=;
	b=u5u5ZIb4EVT351s81iQ2ArWaepX5UqZXyItvhfD+mhQAkts7ajrXgf9quUfV6u0/5hFsslvB3fMkpCSlZMv7oXkyJuyRSVmDI2WruRQ8jOwSaB0JsPlzoTPbxiSaNi/+m0a/p0EAUiCdtjDxSJuwQqCcMG+i7iOBwy9JlzAr9F4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:de8f7363-1cfb-40b3-ae62-29fe105472a0,IP:0,U
	RL:0,TC:0,Content:44,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:44
X-CID-META: VersionHash:7db8b62,CLOUDID:a0e0430f-7fc4-4c92-9e95-c95c5d3eebab,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:4|15|50|99,E
	DM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09a826c2ab2611f1b1788b6acf885367-20260908
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <justin.yeh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1828760962; Tue, 08 Sep 2026 09:38:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 8 Sep 2026 09:38:47 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 8 Sep 2026 09:38:47 +0800
From: Justin Yeh <justin.yeh@mediatek.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Douglas Anderson
	<dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Justin
 Yeh <justin.yeh@mediatek.com>
Subject: [PATCH v2] HID: i2c-hid: Unfollow the panel on shutdown
Date: Tue, 8 Sep 2026 09:38:40 +0800
Message-ID: <20260908013843.368364-1-justin.yeh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

i2c_hid_core_shutdown() sends SET_POWER(SLEEP) even for panel followers,
but nothing in device_shutdown() guarantees whether the panel, and hence
our own power, is still on by the time we get there.

Do what i2c_hid_core_remove() does and just unfollow the panel.
drm_panel_remove_follower() calls panel_unpreparing() only while the
panel is still prepared, which powers us down properly; if it is already
unprepared no transfer is attempted at all. On MT8196 the panel is
unprepared long before us, so this also drops the ~2s i2c bus timeout
from every reboot.

Fixes: 96a37bfd232a ("HID: i2c-hid: Support being a panel follower")
Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Justin Yeh <justin.yeh@mediatek.com>
---
Changes in v2:
- Unfollow the panel instead of just skipping SET_POWER, so we no longer
  depend on the panel having been unprepared before us (Doug).
- Link to v1: https://lore.kernel.org/all/20260904035009.4114363-1-justin.yeh@mediatek.com/
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0ff07fdab442..c7e46004f513 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1355,7 +1355,16 @@ void i2c_hid_core_shutdown(struct i2c_client *client)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
+	/*
+	 * Like in i2c_hid_core_remove(): if we're a follower, the act of
+	 * unfollowing will cause us to be powered down. Otherwise we need to
+	 * manually do it.
+	 */
+	if (ihid->is_panel_follower)
+		drm_panel_remove_follower(&ihid->panel_follower);
+	else
+		i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
+
 	free_irq(client->irq, ihid);
 
 	i2c_hid_core_shutdown_tail(ihid);
-- 
2.45.2

