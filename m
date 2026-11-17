Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892875;
	b=4Y4ti/PV1HTG1hR6oPlZfRLccLmgMrpcwM7rXsRff/HVKv/izZhC+tPmRDiLz+y90cmw
	 IzO1j/E4xLWMPY7Dxvk6QfHb9IXqLJ4P7IjpUqhn+F2zw30kcsER3m4qQdjHhZMtRTK/t
	 KJfIpFwVNj4omXKly+ehXyoEcUAcKjK8vHnJpcXX+fxV/iKFjG+LeZXHDDdg32E72UAv2
	 F4Wf/k8WGv3IWDMIRPFDmsmT0QHxbfeyt/Ike14ZBNRXbvA/kcVbL4V6ZUaXIkLPzVS3Q
	 wGl3xsgzH77jWxeJc819WWfiaW1FLnNWz6RwyOlxLX55xCj2z1yci1AhfCKdzd1inWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892875;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8Dfb4pQsPUCX8NnnmhW4+LuoT5yQiqsKf8y5R9RJ2ck=;
	b=3O9yPWvkSd0NqQaWmQYAFAruEluR/eE7zb1Mm8aUXTQDa78ujHHw6m/LlLhwN7xBHThK
	 sJd6YdBUH4ADJ75JwVnoNMoTDvenaw+88sb8zbPjGBjJf9IDFAbp5uyhZzOt7/ZKDZgDt
	 eHH2hT2p6wzX+FnlzRaSNqxgaRv7/WWE0IrAxoJ6bFPjGvpwfUtt0x1avKwSGhTJXTyeW
	 nsuPYGUTY4SYUbMH+661AMI9umW36LgYqqArt6BVA9TgWdeA7KSPw6hO2oE6eyS/0BwHs
	 IknbqIm2CiiDLtjwqLbn0ch+EjDMfJoCJtTCNyO4QkqWrW4EWP9JPPUJv1wfOr0ohKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=csNXS7G4;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24707606A323;
	Tue, 17 Nov 2026 05:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24707606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=csNXS7G4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=8Dfb4pQsPU
	CX8NnnmhW4+LuoT5yQiqsKf8y5R9RJ2ck=; b=csNXS7G4rRPx24uGUgKzir4Ww2
	3ADjfBN8HtuMVaWcCWpFk0hgcGYAreG/V/5TZNYlo0ISeGaZJg278124CwgLxj6Z
	r7EIuvuJFHh8q6Mx8dxCgga4l8bnEstZNx76zWJ6DRfL4EBblI2P+M221Gd+gA9t
	XE4my6e1CfOOnBTl8=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S2;
	Tue, 17 Nov 2026 13:21:12 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 0/6] Input: aw86927 - add AW86937 support and fix the AW8693X layout
Date: Tue, 17 Nov 2026 13:21:06 +0800
Message-ID: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4DKFy5Jw47GF47Gw18Grg_yoW5Gw48pF
	Z8Was3JFZ8JrWI9a1xAr1UuFyqvr4Sqr43GrykKryxA3y3W3W8tr4vk3WrZryjkw4fuF1r
	tF1UXwn7ursrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	c2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU59ID3UUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwAPsw

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

-- 
2.53.0

