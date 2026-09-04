Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB094CCDFB;
	Fri,  4 Sep 2026 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493824; cv=none; b=VrluebKvP7Y8nlNFJe4U5ha5qdKGGo6dqfLMs/5fqcCEggCnZzgNlf7fMUiXVX6E0wQx7UBGNYVa/2loamLuNg96qq4g4l6YztP8IjZOWmoLQXwlcliWkX7TTecXt6zCpJQHTSG1iYORzAGwaZJhRmDDMD2MB1Vw+YnY7AwCjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493824; c=relaxed/simple;
	bh=pcpvL4zZrnXQA5afU7ffPQcFlJ/g/ZaHMgUWuUvxeUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQe0g+q73hgz4pHAj3vT5bxotk92LFGoYWv+PSB/2X3x0+1ESRZXEVU37iHBYDNSlmwc2UduxMRVjU7ShllOegyTk1QnhJzVZTDsZmBkWw4ND1W00Ksf9lIn2NZFVudd+1+dyvZ1H0cIWzdB8pqYSoIfB22C7fEQA5a/xM/zFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sXfGs63r; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sXfGs63r"
X-UUID: bc57f5eca81311f1b1788b6acf885367-20260904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=f/lMlDVWYpAH/dp1lGoT+o/qCqrGW19Qk0/3sL3d8SE=;
	b=sXfGs63rhiyd38+4YXy151g4JwYCD3nz24eU3sx5LrKaB/4AEaenBR3XQ89/anWKxiHzdvyHou4jFTbKtmkXPlHKYu240ZZ++f5N32iGSOATFVKeERq1EquS/byCkdnwK6vnmSQ76hQpOyKJ4Ef1+C8kI8MmCzj9d2bt2QEL1vw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:511129ed-8a3e-439e-aad6-53d61c50aae5,IP:0,U
	RL:0,TC:0,Content:47,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:47
X-CID-META: VersionHash:7db8b62,CLOUDID:0bdd6c96-8382-4d0c-b42c-b0965a0d23b4,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:4|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc57f5eca81311f1b1788b6acf885367-20260904
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <justin.yeh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1474300989; Fri, 04 Sep 2026 11:50:14 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 4 Sep 2026 11:50:12 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 4 Sep 2026 11:50:12 +0800
From: Justin Yeh <justin.yeh@mediatek.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Douglas Anderson
	<dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Justin
 Yeh <justin.yeh@mediatek.com>
Subject: [PATCH] HID: i2c-hid: Skip SET_POWER on shutdown for panel followers
Date: Fri, 4 Sep 2026 11:50:02 +0800
Message-ID: <20260904035009.4114363-1-justin.yeh@mediatek.com>
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

When an i2c-hid device is a panel follower, drm_atomic_helper_shutdown()
unprepares the panel before device_shutdown() gets around to the i2c
client. The panel_unpreparing() callback already calls
i2c_hid_core_suspend() with force_poweroff set, which sends
SET_POWER(SLEEP) and then drops the device's regulators.

So by the time i2c_hid_core_shutdown() runs, the controller is unpowered
and can no longer complete a transfer. On MT8196 the SET_POWER(SLEEP)
issued there burns the full i2c-mt65xx bus timeout before failing,
adding two seconds to every reboot.

Skip the redundant SET_POWER for panel followers, matching how
i2c_hid_core_pm_suspend() and friends already bail out for them.
free_irq() and the shutdown_tail() hook are unaffected.

Fixes: 96a37bfd232a ("HID: i2c-hid: Support being a panel follower")
Signed-off-by: Justin Yeh <justin.yeh@mediatek.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0ff07fdab442..2e787c17256d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1355,7 +1355,9 @@ void i2c_hid_core_shutdown(struct i2c_client *client)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
+	if (!ihid->is_panel_follower)
+		i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
+
 	free_irq(client->irq, ihid);
 
 	i2c_hid_core_shutdown_tail(ihid);
-- 
2.45.2

