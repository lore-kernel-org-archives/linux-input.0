Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107783;
	b=Gh9yQ4gtqnJDjRZDesMmswsuFBwfn5+ziAHWGwUeAQwD3tB2VFar/TJCTtMW6tB0q2QL
	 IrY0/sjISMz5nLXKVxf+frhvdIDwmwriAwOxIXIlycHHGUDpvOpa7Ld6sxGzj5PbTV1Nk
	 4iIgyarK8uACNbXKKs96FueiyJdi+z1NDg0reMzlr794MXlf23iOaAVRvnXQxgD7cHejq
	 robqW68/O/+fqSVMrO7iOGvmxkA+kCI6KJsYJspBY7UnmTvQpLv29QHY5BcNGXobIQbH9
	 kerShHghFFddBdDbhQqCJ7OxrrpAEwnvkA8oV+cl9L346G569nt1mu9z506oAKh61hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107783;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hrd9duCwjg51APCx6mLYkbGJAbALaO2MUuY4uwoHNaY=;
	b=Y5cdHDEWoRjmLziP7ieFMZr3Qan9fXgmLt2tDT0/q40LMqZoEpkAsSg3GFI7r6wtGsV0
	 Ew22W4Eul8AeOt0GWtrYuYNO9hSchBEqtgcrzSq4hV47waHDy+1fIqfqnbHEXDMdSBRPW
	 xyVlzHnuWfQug0ZyyTVSvgi6GGO6fonhGCuxlwgEkfbzZWIljZv4gJy2bs0TL2yYookee
	 KW2tlq3YeCnjNX15bNIcdNZMsCnZmxu+4MWe3NzA+KTYJ6omq6aOUvflFpPmNQyfumtnZ
	 Y5LmVTm2crGxS5WLGFWQ/KQWRKEporcoHFxPt0ZoFUBKapk5K25JoEfaiTqu6LVRJ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=I4XAnq14;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC155606A329;
	Tue, 27 Oct 2026 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC155606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=I4XAnq14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=hrd9duCwjg
	51APCx6mLYkbGJAbALaO2MUuY4uwoHNaY=; b=I4XAnq14QPbKEDhvmRBYE27aX/
	laNKwq874MxTdraySZA2MKycMxZNmG98TTttKcvCHvxcvmU4gblv/v+Ls0+SPRef
	hAQkWvTgrLFCRKDJps9XX/xn5MALCVicWnZjCWUidyiTQ3iyFpAjOx5gwP89OCYp
	L7cIHADI2EWyQ4Vi4=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHhDg5p+BqGGxRAA--.1917S2;
	Tue, 27 Oct 2026 21:29:29 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Input: aw86927 - add AW86937 support and fix the AW8693X layout
Date: Tue, 27 Oct 2026 21:29:24 +0800
Message-ID: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAHhDg5p+BqGGxRAA--.1917S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1UZFyrCF1UGFW8ury7trb_yoW8GrW7pa
	y5Grn0yFn8Jw47KwsIyr1DZF98Zr4xWFsxCr9rWry7tw13Ww1rtrn3Ka40vFyqkrn3WF18
	KFWUJF1DuanrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5k9NDUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAApso

This series adds the AW86937 variant and fixes three register-level
problems in the AW8693X family (AW86937/AW86938), all found while
bringing up a device with two of these actuators.

Patch 1 is an independent fix: AW86938_PLAYCFG1_BST_7000MV selects 9 V,
not the 7 V its name claims.  Patches 2-3 wire up the AW86937; patches
4-5 make the already supported AW86938 work correctly (bit positions,
two-step stop) and power the part down across suspend/shutdown.

Testing: the device at hand (Lenovo Legion Y700 Gen4, SM8750) carries
parts from the AW86927/AW86938 family.  AW86937 support is based on the
vendor driver and the register description; there is no AW86937 board
here, so patches 2-3 are compile-tested only.  Patches 1, 4 and 5 were
exercised on the AW86938 in that device: rumble playback, stop, suspend
and shutdown.

Based on linux-next (2026-10-27).

Qianhui Xu (5):
  Input: aw86927 - fix the 7 V boost reference for AW86938
  dt-bindings: input: awinic,aw86927: document the AW86937 variant
  Input: aw86927 - add support for Awinic AW86937
  Input: aw86927 - handle the AW8693X play and boost register layout
  Input: aw86927 - stop playback over suspend and on shutdown

 .../bindings/input/awinic,aw86927.yaml        |   1 +
 drivers/input/misc/aw86927.c                  | 148 +++++++++++++++---
 2 files changed, 126 insertions(+), 23 deletions(-)

-- 
2.53.0

