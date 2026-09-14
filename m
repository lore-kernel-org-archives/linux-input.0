Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6A22A7F6;
	Mon, 14 Sep 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367656; cv=none; b=gsyYTlmw/vc4wO6ZFuhGaHbvA77F3yLDINrd2fJN9SwailXR8hzrkkYZHmnEeKQz6HS4VeCfG7KXJICGt/MUnKhSnxDxuYics6UIWfu6cle7wXRqMfZ327LZscfr3JCJBDgj96fNT20TXHu4i0ATxLopAFec2t4Lwzy5ly9eL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367656; c=relaxed/simple;
	bh=HFzPgGZxe13VFMJ0+Ee4wJ7NqQlN3fJ36QAeqsCQFpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDgF22WKT+UhjJb6CBJW7AvRuX7ujiZpCu77HbMOIVzyyYGozFKmpHaiY7vjUVoJMHpk/gNrvzrx2UXV50gsJ9u5Kk+ZMSxqf2X0WBfhTU82kQDRYcADvmgQmeymSPhDy0Kw8EdIqdHZsb+gjfWbBG2LZnKFYVjmo5veXKmxQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 47af634cb00611f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b0295b6e-f0ac-4bc5-a1cc-a7d8e61abcb3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:b3a36cd2ad367b1c8ef8eb07ad8f17d8,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|136|850|865|898,TC:nil,Content:0|15|5
	0|99,EDM:5|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 47af634cb00611f19a56ed5b684f684d-20260914
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1394324754; Mon, 14 Sep 2026 14:34:04 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	chenchangcheng@kylinos.cn,
	jeffinphilip14@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: corsair: do not re-schedule LED worker after it has been cancelled
Date: Mon, 14 Sep 2026 14:34:01 +0800
Message-Id: <20260914063401.92686-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8s5r192r-rqp0-nq7n-n317-r7r503239474@xreary.bet>
References: <8s5r192r-rqp0-nq7n-n317-r7r503239474@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jeffin,
Thanks again for the pointer.  Danish Khateeb has submitted a patch
that is code-identical to the fix I had prepared, using
disable_work_sync() to replace cancel_work_sync() in all teardown
paths. I have reviewed this patch:

	https://lore.kernel.org/all/20260904161531.160118-1-danishkhateeb03@gmail.com/


--
Chen Changcheng
