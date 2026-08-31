Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24637B025;
	Mon, 31 Aug 2026 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161595; cv=none; b=sMVBXeSvtQthjy8WFJSEQ82esRZpkBRorTgoFpy+pWT7xZiqryZfapw5ltphcZrS1M/EkJJsEbWtKzO2gOw60CHv30Txzmvy8DDtGHsQpjJ1QZwdM4OXZMOFXO+kjJepnUVEeUPskTrfXd99NUWCgoZpn9qumrZDiAfs365hRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161595; c=relaxed/simple;
	bh=SdkWQMLjnwcTgkXuc+oA2UTtBRmU7q4cAHIOn5ESgPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxRpSWm2Rd7TSrNUrBQvWYJWm3x41rE+GUhT0MUMRsfFcmfeam2d/KNY9JSe8D12pQT2LY459Ii9lvC3qiwwdDJ5Ch9LfbUMiA3yPqHpGRsus8/hQNMYdH7YtJUy6BhEW6yhDZCqbPMLs79sHD8Xf5CfyOwraKDgYNayJq7uFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35c05af4a50e11f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a2526e71-c759-4c87-b335-91a9221d9f42,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b5a2f58e55721b4b0a0f53f257589e8d,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35c05af4a50e11f19a56ed5b684f684d-20260831
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1790824634; Mon, 31 Aug 2026 15:33:07 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: jeffinphilip14@gmail.com
Cc: bentiss@kernel.org,
	ccc194101@163.com,
	chenchangcheng@kylinos.cn,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: corsair: fix two use-after-free bugs on device removal
Date: Mon, 31 Aug 2026 15:33:04 +0800
Message-Id: <20260831073304.70146-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831055005.18420-1-jeffinphilip14@gmail.com>
References: <20260831055005.18420-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jeffin,

Thanks for pointing this out.

The first two patches of the series have already been merged into
v7.3, while the follow-up fix (making k90_brightness_set() a no-op
once removed is set) has not been merged yet.  Since the original
thread is about the two merged patches, I think it is cleaner to start
a new thread for the remaining fix rather than appending it as a fixup
to this one.

I will submit the patch as a separate submission shortly, with both
syzbot reports tagged so syzbot can verify the fix.

Thanks again for the report.
Chen Changcheng
