Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E2433AD;
	Tue, 28 Jul 2026 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244499; cv=none; b=ZXuOWtDxWIb5+v82/TxCSIFGA8eLXzpDLzOHfey1+LLeGzh9yi0UD09A9sphi42dFrbNBW203sZftRKUZSI3oV8KJEkY1+XI/nfRl8Jjxwydm1Rn6ghM3SWFhdxnFPUZT1cNezeWYNiw2z8gsnb+70GBTKilKhDfFEpEk5ecHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244499; c=relaxed/simple;
	bh=/xlDQgJ2tjAgiyY/v+iAPldCGbouYeg9iBQLenkfTnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3dJT8k4kYjNLlC03TQLL3knfzTWCUjUg3fTRVlve3KGFH+Fcmh+wfIvttPi3y4ukNuThhjwT0EuNt9hN7HtuMncHSpBki92lVSrBPOsmPFFVW76bMUPMU1GjxT4dqZreTx9IyyJiS/phDmfum2qPfHJlMxSSmk0Rr5cgbGliqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4fd8c2a28a8611f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0b3a12e1-16e8-4a57-a279-6268e913479d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8c967f86c9ebb29009fd88e156e65d5e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4fd8c2a28a8611f1aa26b74ffac11d73-20260728
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 705825285; Tue, 28 Jul 2026 21:14:49 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: hamish.martin@alliedtelesis.co.nz,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH v2 0/3] DO-NOT-MERGE: HID: mcp2221: stop device IO before hid_hw_stop and fix UAF/OOB-read
Date: Tue, 28 Jul 2026 21:14:39 +0800
Message-Id: <20260728131442.834604-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series revisits the "stop device IO before hid_hw_stop" v1
submission and, while reviewing it, fixes two pre-existing security
issues in the same driver.

Patch 1 is v2 of the original single-patch submission. v1 added an
unconditional hid_device_io_stop() to the devm cleanup callback, which
prints a spurious "io already stopped" warning on normal device
removal: hid_device_remove() clears io_started before the devres group
is released, so the callback always sees io_started == false. v2 guards
the call with io_started so it only runs on the probe-failure path that
actually needs to balance hid_device_io_start().

Patches 2 and 3 are independent, pre-existing bugs (both dating back to
the driver's introduction in 67a95c21463d) that the Sashiko AI review
flagged while reviewing v1. They are self-contained, each carries its
own Fixes: tag for -stable, and neither depends on patch 1 or on each
other:

  * Patch 2 - mcp->rxbuf is left dangling after an I2C/SMBus transfer
    completes or times out; a delayed or spurious report can then write
    device data into the freed buffer (write use-after-free).
  * Patch 3 - mcp2221_raw_event() never validates the report size and
    trusts data[3] as the copy length, so a malicious short report can
    leak uninitialized kernel memory back through the I2C read path.

The original v1 submission is available at:
https://lore.kernel.org/r/20260728061919.310367-1-yijiangshan@kylinos.cn

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Jiangshan Yi (3):
  HID: mcp2221: stop device IO before hid_hw_stop
  HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
  HID: mcp2221: validate report size in mcp2221_raw_event()

 drivers/hid/hid-mcp2221.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--
2.25.1

