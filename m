Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620726;
	b=QNS4+OfaUr0xgbR7QCTqJOjKqiDv19m3D4ZczrOq7vWZj6PRMReDE4R4GakN6WGDhPGP
	 1QkcsZGImF4driL00BNK9xziGkLxbN87sHinLXhGJSXz3aGvHrJIELr/ZO1+wo0lgnkUc
	 QCZLSP2iA2X4/sedAYIDpRgV+MBX+myd0g4ChefWtf8XG+2CkmLj67bmdMzoXBywpoJIO
	 30UCLu4rlUuGqqTCYO20pBqu5V9gNXYax80gOZdMu7qmQEMThceg18Ezz5k0H1zkvQOwk
	 6Nglb/JaNcOueN9lPdtHMniSiNI4ckQ8PEJec9ksDzf/vfBF+MpAih+ziSjd64XsirQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620726;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=e6KWIfhgerzdwRMDCxahEdOj/gYinfeGOwNk1IKRoO4=;
	b=F9AGwL5eR02h+8RkqGJyzdeq420P8vDbiELZ4hQ2vexscFzVyl01qGUshu4s3Ej4Ydqn
	 TPgS32X1SwIz4yNIz5vPZ1llZOZQXoR8poN5ol48dOtWXStWROvAFfexVpSVQEEbFA+ai
	 X5Imlk1nbdtv/EG7x8yjIwYGTGEQnHW5Cmt9deiJIHGA134kEkVWaLAbDDU2oJVXeGDSv
	 n9MXWBAZV15D6nsha2Se776UvMQQJ4SrETTDrfn9Hp9ZRehhOq4/FRs3rmAo3Ve1BkAXs
	 nktofbUabGKvmKk1f/Gu/jL2CzEdub9OWjcORPk/w7Kzhig7zLH5KEd+CsxaEOOPxqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=Zu0IKwgY;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26634606A32C;
	Mon,  2 Nov 2026 11:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26634606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=Zu0IKwgY
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b234a;
	Mon, 2 Nov 2026 19:58:40 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
Subject: [PATCH 0/2] HID: bpf: close device teardown races
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c203c4a03a2kunmab045f0fe84dc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHRlMVhhIGR5MT0wZQxhIGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTU
	NVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Zu0IKwgYnkUm54iZ2dwNqRzbYWxJlr4onViNH1rWRA/NBHnfU69xQ+cG9ZwPlFFnndr8N7pceZeAXxmzmvLegE20Mtg9+iuShpk2fTWvFChDBu8xAEaG2TQroAjEC7+e5HKnjsusOS5/5/M0dT4nlhLkt8qzL6UFSKHGC/SVeUA=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=e6KWIfhgerzdwRMDCxahEdOj/gYinfeGOwNk1IKRoO4=;
	h=date:mime-version:subject:message-id:from;

HID-BPF can race device destruction in two paths.  A hardware request can
outlive transport-private state, and a struct_ops registration can resume
after destruction has cleaned the device's SRCU state.

Serialize HID-BPF hardware operations with the destruction transition, then
reject registrations that acquire prog_list_lock after that transition.

Yifan Zhang (2):
  HID: bpf: serialize hardware operations with device destruction
  HID: bpf: reject struct_ops registration during device destruction

 drivers/hid/bpf/hid_bpf_dispatch.c   | 36 +++++++++++++++++++---------
 drivers/hid/bpf/hid_bpf_struct_ops.c |  5 ++++
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.39.5 (Apple Git-154)
