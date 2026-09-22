Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B12EBB84;
	Tue, 22 Sep 2026 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043151; cv=none; b=NOQ1xIeibwSdkESc8e/or6lhKfQoM5waZtoVv8AUMC2Dfn4tpEaOlcuNQbSOhUruHzWGxhNjWHXsKG4LUT1ztn7ojLGd+7Qwin2/lmtSVGwK3ibeftCog+ysFgE7BX+JiTqSYRTQzIiVoxzubMGBgrl1ZdNr60OvQBiL0BUE0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043151; c=relaxed/simple;
	bh=eHWoKfRxmGPXzreu8zc8rpYeDSzg3YxtbwsTrNAtjJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTSwH1/mTFSd9o6BBI1NebTp7/ENWsjNXvNEjpgYia902pGAO4Qq4xPj+GofxPoZwxq4sQPfozLK+xvTfvRCHRKmjvfUcxovXni28JDnDePko/s6e09I5q0VUVyBtrswgXSuXMXgGlhWA4B0zjoatixMiKTw7R9bAHecpIQQZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 09ec904ab62b11f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:426d5a97-d32a-476e-bda3-5fb3af8e30b9,IP:0,U
	RL:0,TC:0,Content:20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:2456a60152ecaafebc3660989d2c3875,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|136|865|898,TC:nil,Content:4|15|16|50
	|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09ec904ab62b11f19a56ed5b684f684d-20260922
X-User: zhangheng@kylinos.cn
Received: from [172.25.120.77] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1664866593; Tue, 22 Sep 2026 10:12:19 +0800
Message-ID: <3aa95d2e-9398-482a-8bd5-876ef1e2ce89@kylinos.cn>
Date: Tue, 22 Sep 2026 10:12:15 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - rate-limit unknown key warnings
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: cryolitia.pukngae@linux.dev, kees+treewide@kernel.org,
 DongLin_Lyu@outlook.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260921131934.677541-1-zhangheng@kylinos.cn>
 <arFZdtgmZXcK9k1V@google.com>
Content-Language: en-US
From: Zhang Heng <zhangheng@kylinos.cn>
In-Reply-To: <arFZdtgmZXcK9k1V@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for your reply. This fix should be handled in userspace. It’s 
just that for ordinary users, they see a lot of warning messages after 
pressing keys, so perhaps it would be better to limit the output. I also 
agree with you that this patch is not necessary—after all, the benefit 
of this patch is indeed limited. If the patch is not merged, I’m fine 
with that.
