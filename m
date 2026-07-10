Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F131E515;
	Fri, 10 Jul 2026 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651186; cv=none; b=NFW6iyCtOfLlq+dpyXoVQYRGU/DxJGNrSjLNCVJXn+a+GrqTdruDNEAqe6rP0GjuuxvZR+Rc/C9odIvyCKAFch4zOX7LnU4kg/pr6l8IQrRh4np9oBQvLyItvXYAVIcYGOB+fCRuFelkjyLDsQ2VUOkSuvGqySyXjJe5nQI1/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651186; c=relaxed/simple;
	bh=fL+uuz17xkV6Q1lvpO/afliiEk2DN7WS60Cbkuwf4PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5oDNSbi1OqfHSr7sju9M35aEngs2MSj/o91qVcDTdO+tMruT+HFCS0gTwiR15qTmYsRukd3Hq71JdLkwodv5sUQtIHwoB4EKAIZYLpNJSaknn44z8apb35r/trK2+rsSrf6MAKoshGiFjF4JIfAl5vDULOxdEHjmLim+IyolYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 990c53d07c0811f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8f767a4c-4f78-4775-9a20-a98b5b99e39a,IP:0,U
	RL:0,TC:0,Content:4,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:4
X-CID-META: VersionHash:e7bac3a,CLOUDID:32e818542654732f380e29eede3a6d9f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|83|102|136|865|898,TC:nil,Content:4|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 990c53d07c0811f1aa26b74ffac11d73-20260710
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 146119765; Fri, 10 Jul 2026 10:39:39 +0800
From: Ai Chao <aichao@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	dianders@chromium.org,
	treapking@chromium.org,
	kenkinming2002@gmail.com,
	raoxu@uniontech.com,
	superm1@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] HID: i2c-hid: Fixes "(null)" device name error logs in i2c_hid_parse
Date: Fri, 10 Jul 2026 10:39:36 +0800
Message-Id: <20260710023936.3960010-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Doug

"Ai" is my surname, and "Chao" is my given name. My name is Ai Chao, which translates to "Super AI".

> > Before: hid (null): reading report descriptor failed
> > After:  i2c_hid i2c-TPD0001:00: reading report descriptor failed
> >
> > Signed-off-by: Ai Chao <aichao@kylinos.cn>
> > ---
> > change for v2
> > - Used Fixes tag.

> Could have fooled me. ;-)

syslog:
kernel: [    3.815131][ 1] [  T319] i2c_designware HYGO0010:00: timeout in disabling adapter
kernel: [   15.790171][ 1] [  T319] i2c_designware HYGO0010:00: timeout waiting for bus ready
kernel: [   15.998769][ 1] [  T319] i2c reading report descriptor failed retry:49
kernel: [   16.038176][ 1] [  T319] i2c_designware HYGO0010:00: timeout waiting for bus ready
kernel: [   16.246771][ 1] [  T319] i2c reading report descriptor failed retry:50
kernel: [   16.246775][ 1] [  T319] hid (null): reading report descriptor failed
kernel: [   16.246778][ 1] [  T319] i2c_hid i2c-TPD0001:00: can't add hid device: -5
kernel: [   16.246954][ 1] [  T319] i2c_hid: probe of i2c-TPD0001:00 failed with error -5


Thanks,
Ai Chao


