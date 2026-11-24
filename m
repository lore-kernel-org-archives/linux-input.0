Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485034;
	b=HlNr0M2eFvhpXYK1PxdaTj0S41nze7I2bVKaMhJEvSPf29VpigTpm/HBZRK8BPESYl0x
	 hk8aKS/Jz6sN1StjV4gcad0LkdGXiVYaCZdQwJW0wIx/gyE64cJ7cTiL+uLJqWtKcKEfr
	 gwi0oHrSRnRWvweuT36Ju+tzOvfF/T6QO1wB5D0ojMW43gd5yQBgWGoPmpnA+bTAh8I9a
	 vMYbQ9068dCeUlHVvGZtURyUFQmZwDdkd55UfStDC4TREgkJOl92A2g12YYBCO8lMIcwu
	 Z+25HWx5+m+GPGaP1UJ/fw3jBcwQK9/rfIVAN8Krb/xcBdbdrypb+qGpMy/C+y46wOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485034;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=LXBEQtWGhdWAuU2BEEBSTd2cQCOR0LawNYuwlntiTEM=;
	b=cMeEMzR+0yOQTKqDoSDLtwt22LRZWyqIT5Nb0EqhStfKkKWSlFT+ovEQgIGXsDk4/xxE
	 ureCYWCXMPKkrxvPsgr/jO7uC97kqV0FxBvqUQiNAfJ/tj/vhXdFXoHjtJ4uuiwLAmUkr
	 LrS+/nGnGQXQ2WzTV6KfBIYey3pmfKxH0Is4KjfCuDQHZzgcdsTOmHa+ST67tR/T4/SRJ
	 svcKcD0ahQv+otLPHTJ/uNrjbR0y6xHuQfr08ekY3iPVrQD42h8MQMNjNv/xkoMVb6AdC
	 NGf5GH8EOwFCrFhvttTUj3o54JIiwNiFBYuRpI+4WYHy6z0x3eVpDxIXegNHOXZj3lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=luU0AmVM;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A180606A322;
	Tue, 24 Nov 2026 01:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A180606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=luU0AmVM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=LXBEQtWGhd
	WAuU2BEEBSTd2cQCOR0LawNYuwlntiTEM=; b=luU0AmVMHAw4vxsg8yR77yfzo5
	8SsnLaVGjJT0fGZBAi/EGfldLG9Amr3Qbyo3LE+Uy73Ro8fPfBpvMVYPirfI7JJ7
	BtFpkNo1BJBB+oCmexmS7bLARNaDWRQlVhODbvD64qDETLo9E9iwjxhRt3aa9QiX
	RzJtRI3nwo/x+dAQQ=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHPDFk7QRrHDHvAA--.1941S2;
	Tue, 24 Nov 2026 09:50:28 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Input: aw86927 - add AW86937 support and fix the AW8693X layout
Date: Tue, 24 Nov 2026 09:50:22 +0800
Message-ID: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDHPDFk7QRrHDHvAA--.1941S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4DKFy5Jw47GF47Gw18Grg_yoW5KF4rpF
	Z0ga45JFZ8trWI9a1Ikr1UuFyq9r4fGrW3JrykKry7Zay5W3W8trZak3WFvr1jkws3WF15
	tFyjqwn5uFsIyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWU
	twCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07bn_MfUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQAvsX

*** AI-assistance disclosure ***
This cover letter and the six patches below were prepared with the help
of an LLM coding assistant.  The author reviewed every line, ran every
gate quoted in this letter himself, and takes full responsibility for
the content.

This series adds support for the Awinic AW86937 LRA haptic IC on top of
the existing AW86927/AW86938 driver, fixes two register definitions that
are wrong on the AW8693x parts, and stops playback over suspend/shutdown.

Patch 1 fixes the 7 V boost reference value that the AW86938 support
introduced (0x11 programs 9 V, not 7 V).  Patch 2 widens the AW86938
boost mode mask: the field is two bits wide at 6:5, so the existing
one-bit mask leaves bit 6 untouched when the driver selects bypass.
Patch 3 documents the awinic,aw86937 compatible as another member of the
AW86927 fallback group; detection stays on the chip ID, so no new
of_device_id entry is added.  Patch 4 adds the chip ID and init path.
Patch 5 handles the AW8693x register layout differences (auto-boost bit,
two-bit boost mode, VBAT mode and the two-step stop handshake).  Patch 6
stops playback, drains the work item and parks the part in reset over
suspend and shutdown, and registers the reset action with the device so
that unbind and probe failure unwind leave the chip asserted.

What changed in v2
==================

Only the two review points from the previous posting (2026-10-27) are
taken; patch 1, 4 and 5 are unchanged, 2, 3 and 6 differ exactly as
follows:

  - patch 2 (new in v2): the boost mode mask is now GENMASK(6, 5)
    instead of GENMASK(5, 5), so the two-bit boost mode field is
    programmed as a whole.
  - patch 6: aw86927_reset() is registered with
    devm_add_action_or_reset() right after the reset GPIO has been
    acquired, so unbind and a probe failure after that point leave the
    part asserted.
  - patch 3: carries Krzysztof's Acked-by from the previous posting; the
    binding change itself is unchanged.

The AW86937 has no hardware in hand: the register data comes from the
vendor driver and the part datasheet, and the commit message does not
claim otherwise.

Qianhui Xu (6):
  Input: aw86927 - fix the 7 V boost reference for AW86938
  Input: aw86927 - widen the AW86938 boost mode mask
  dt-bindings: input: awinic,aw86927: document the AW86937 variant
  Input: aw86927 - add support for Awinic AW86937
  Input: aw86927 - handle the AW8693X play and boost register layout
  Input: aw86927 - stop playback over suspend and on shutdown

 .../bindings/input/awinic,aw86927.yaml        |   1 +
 drivers/input/misc/aw86927.c                  | 154 +++++++++++++++---
 2 files changed, 131 insertions(+), 24 deletions(-)

Changes since v2: only 6/6 changed, to address Sashiko's review of v2 (2026-11-17).

 - "race in aw86927_close() and unbind queues play_work after stop" [High]:
   the devres action now drains the work item before asserting reset.  An
   inhibited device skips input_close_device() on unbind and the memless
   effect timer can queue the work again, so the worker must not reach the
   regmap after the device is gone.  aw86927_shutdown() calls the same
   helper instead of draining the work itself.
 - "commit message and comment mismatch on suspend/shutdown" [Low]: the
   message now says that suspend parks the chip in standby without
   asserting reset and that shutdown asserts reset without a separate stop,
   which is what the code has been doing since v2.

Gate for this version: W=1 compile of drivers/input/misc/aw86927.o on
v7.4-rc3 (aebb727447), 0 warnings / 0 errors; checkpatch --strict 0E/0W/0C
on all six patches.

-- 
2.53.0

