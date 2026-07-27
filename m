Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154730AACD;
	Mon, 27 Jul 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116118; cv=none; b=uj2sNUm0nZub/Xk4AyJlcUy7oXnfQcJA4Ov5GOPETJJ65MyA3TK/FLIl0qgVb5dD5VhX3W1JB6aedk6qXdOT2ffKsKF5w4ke1Ye/Z3HgFNfdpQQpwFrAjjbQa9o1dVYkWz3ovqZV8i1eWrqfzeO4DuDMlQZOFjJikOPQeOCP/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116118; c=relaxed/simple;
	bh=6wgz3U1vTv7QUpNIWMW4BBDJbGwisMU2kWMjt1irCH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyqpr3EnJmZ3H46Qya62Eh+UnTKwkBdsaLURXTbd9MX2TUgeTZ/cJsNk23ymghpMf7Vmd+Vad2gKoEEgRRwYxPMqDvOKY4IYm07fVkOLYO4FVmP7y0sTJRnLk/LuXWaPoKhtYHhKSl+UReluvN2pU26ZrjD9EwdrGdiK/KZu+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 640eb0f0895b11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a1bda195-bc3d-449e-a9c4-825f65fe64cb,IP:0,U
	RL:0,TC:0,Content:39,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:39
X-CID-META: VersionHash:e7bac3a,CLOUDID:ce842f1e407dde4d118e2785ce626026,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:4|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 640eb0f0895b11f1aa26b74ffac11d73-20260727
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1051808249; Mon, 27 Jul 2026 09:35:03 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH 0/2] HID: corsair: fix two use-after-free bugs on device removal
Date: Mon, 27 Jul 2026 09:34:58 +0800
Message-Id: <20260727013500.23435-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
References: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two use-after-free bugs in the Corsair HID driver
found during code review.  The previous single-patch submission only
addressed the first issue; the second was identified by Sashiko AI
review.

v2:
  - Split into 2 patches: event vs remove UAF, worker vs cleanup UAF
  - Rewrote commit messages in plain ASCII
  - Added drvdata->k90 = NULL as defensive measure (patch 1)
  - Fixed LED worker ordering in both cleanup functions (patch 2)

Chen Changcheng (2):
  HID: corsair: fix use-after-free by reordering remove sequence
  HID: corsair: cancel worker before unregistering LED to fix
    use-after-free

 drivers/hid/hid-corsair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

