Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495849;
	b=ymXxklySVkJ+rnNKnOfnuCU+YAlrZze5Kirb/ttoqohgUj49oqw4NDbq2NR278YEEO17
	 ffiiXWZ5UPL6WQ+mtpgxNwFdIDm6iWh3U2ukNblVpanM97Rf3hfKTIuUyo889WeDZxyib
	 6N4wvoJyg0T5Gj6VnrAOFYJ5Qarl294U0PekaolEh3Bzs8d6AybvLgwolhPAk7hMTq/mM
	 vyuhLl0w51vijSSVYcOnk0RkTmOfGkLue+c/HzJlhkzidEYzUbxeLdJWYPVrCKBtQKFkL
	 GhC9IOqRkoW/OPGanqAGbTuOYuF6ZyocxMAjAkSbJi5sTzIZOMEc9LKGPG6yQhG9GFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495849;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8AD9JPaBV+HRt3GPHbOk/d60mnF1iR5lZyY5cYdZzTI=;
	b=b5T3WzE8NO6CQwtjdYI+x57Vbq3K5aXI+rnPkm74kpHteJuvi6d05K63fQLyMX4W5hF3
	 040lzSxa1JJ1215k5cdB3rn6RsLR+jQbMZOcBzbDt26jq94Cg+QaLNJggDtI8jFn15wJG
	 Il4lMsig1AcgB1ABPASnLyQaaQeiNwPHUFDesjRJ06pdx88o0r42LRgDvAVqejVPLZ5zh
	 6KB7DJ3DqGI463IujpjO24/I1T6lrC7jsDqhj2AukYEhg+TNw7smn5RHYJCFqyKU2Cf4V
	 swGS7fuB1Iec4ksAlzTHz+cs5vIzIl1+Kh1Y8CahDqa6piG3T/Pp6hNe31kALVgB+5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b="pH/yHJA0";
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6455606A321;
	Tue, 24 Nov 2026 04:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6455606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=pH/yHJA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=8AD9JPaBV+
	HRt3GPHbOk/d60mnF1iR5lZyY5cYdZzTI=; b=pH/yHJA0QG67/ud4AjJfV6U2/7
	f6BvQe21jywB19ltbihUV17yKDLug4K3u+AeAS6JTXEPmi/LO+Wx6c2glvEa0t58
	6zkH6+974AWBa6gxgwIrSuOUHzjKTlWv/GE0SLTgP2y0Rnbm1/a77NyJ0r1Y/6VH
	oDqbPNvy7mkJ+T8qo=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S2;
	Tue, 24 Nov 2026 12:50:40 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] Input: aw86927 - add AW86937 support and fix the AW8693X layout
Date: Tue, 24 Nov 2026 12:50:34 +0800
Message-ID: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kJryrJrW7ur1fXr1UJrb_yoWrWF1fpF
	Z8Ka43tFWDJrWIkw4Ikw40vFyFvws3JFW5ArykGr1UA3W3G3WrtrZ3Kw1YvFyUKrs2k3W7
	tFy0qws3ursrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	c2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU5AR63UUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AAksn

*** AI-assistance disclosure ***
This cover letter and the six patches below were prepared with the help
of an LLM coding assistant.  The author reviewed every line, ran every
gate quoted in this letter himself, and takes full responsibility for
the content.

This series adds support for the Awinic AW86937 LRA haptic IC on top of
the existing AW86927/AW86938 driver, fixes two register definitions that
are wrong on the AW8693x parts, and stops playback over suspend, close
and shutdown.

Patch 1 fixes the 7 V boost reference value that the AW86938 support
introduced (0x11 programs 9 V, not 7 V).  Patch 2 widens the AW86938
boost mode mask: the field is two bits wide at 6:5, so the existing
one-bit mask leaves bit 6 untouched when the driver selects bypass.
Patch 3 documents the awinic,aw86937 compatible as another member of the
AW86927 fallback group; detection stays on the chip ID, so no new
of_device_id entry is added.  Patch 4 adds the chip ID and init path.
Patch 5 handles the AW8693x register layout differences (auto-boost bit,
two-bit boost mode, VBAT mode and the two-step stop handshake).  Patch 6
parks the part in standby on suspend, refuses new effects while the
device is closed or suspended, asserts reset on shutdown, and drains the
work item from a devres action so that unbind and probe failure unwind
stop playback too.

What changed in v4
==================

Only 6/6 changed.  All four points of Sashiko's v3 review (2026-11-24
02:03Z) are addressed:

  - [High] "commit message without Signed-off-by": the trailer is back.
    The patch is generated as part of the series again, so it also keeps
    the usual 76-column wrapping that was mangled in v3.
  - [Medium] "uninitialized work_struct in aw86927_reset()": INIT_WORK()
    now runs before devm_add_action_or_reset(), so the devres action can
    no longer reach disable_work_sync() with play_work.func == NULL.
  - [Medium] "race in aw86927_close() allows the timer to restart
    playback": close() clears a new "enabled" flag under the input event
    lock before the work item is drained, and aw86927_haptics_play()
    ignores effects while that flag (or "suspended") is clear.  A memless
    effect timer that fires around close() therefore cannot queue
    play_work again after the driver stopped the chip; a new ->open()
    callback sets the flag again.
  - [Low] comment and commit message wording now describe standby rather
    than power-down/reset, and "Changes since v3" sits below the
    separator.

Patches 4/6 and 5/6 now carry the Tested-by tag that Joonhoe Kim sent for
the corresponding v2 patches: the code in them is unchanged since v2 (the
hunks only shift because the series is rebased onto v7.4-rc3), and he
tested it on a Lenovo Y700 Gen 5 (TB323FU) with two AW86937, including an
s2idle round trip.  Patch 6 has changed both in v3 and in v4, so his tag
for the old version is deliberately not carried there; a re-test of v4
6/6 would be welcome.

The AW86937 has no hardware in hand: the register data comes from the
vendor driver and the part datasheet, and the commit message does not
claim otherwise.

Gates for this version: the six patches apply cleanly to v7.4-rc3
(aebb727447); checkpatch.pl --strict reports 0 errors and 0 style
warnings (the only two warnings are "Unknown commit id
'df53055c540f'" for the Fixes: tag, which resolves in the input tree but
not in a mainline tag); W=1 compile of drivers/input/misc/aw86927.o for
arm64 (defconfig + CONFIG_INPUT_AW86927=y) with 0 warnings and 0 errors.


Qianhui Xu (6):
  Input: aw86927 - fix the 7 V boost reference for AW86938
  Input: aw86927 - widen the AW86938 boost mode mask
  dt-bindings: input: awinic,aw86927: document the AW86937 variant
  Input: aw86927 - add support for Awinic AW86937
  Input: aw86927 - handle the AW8693X play and boost register layout
  Input: aw86927 - stop playback over suspend, close and shutdown

 .../bindings/input/awinic,aw86927.yaml        |   1 +
 drivers/input/misc/aw86927.c                  | 195 +++++++++++++++---
 2 files changed, 170 insertions(+), 26 deletions(-)

-- 
2.53.0

