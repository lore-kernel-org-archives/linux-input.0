Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832A3988EB;
	Mon, 23 Mar 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268241; cv=none; b=dmmvve2Oc3tA7H/l99aFZ7V36wsVnV5TaUJIAzGq50fgLgn7LdmQoRQPmPFAiHWRYo6+moy4+wcFe+iJ7z87Mvi528DkvGMEHwdiHiYVT6yAETQth1uLrrukx2Bslx1yU/kSHMFo4EHLVjE3J8Uzt9uYdcN0lIrOwgdzxfAWNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268241; c=relaxed/simple;
	bh=6Uov2+PW9/M/oe3iDa1DE2p+e19tzWdz1aw1mX/WKu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sh1YNeRdFBBjTdKB1SLbnEP/nRRSPbyrKCJWkNoIJo1YzKNTtHlKZubNuYUktNVEzz9I97XLnasv2M4XINncnlYm37UCwxJ/M2EtPWnDBrY7hU+DjVlB9qtXHnbMZod91QLQ99vNZVqCi9o08X0UMEzQua5LnQeo+avGKs0fpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAAnSeBLL8FpzImMCw--.60661S2;
	Mon, 23 Mar 2026 20:17:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: andriy.shevchenko@linux.intel.com,
	kees@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] Input: penmount: bound packet buffer indices in IRQ path
Date: Mon, 23 Mar 2026 20:17:15 +0800
Message-ID: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSeBLL8FpzImMCw--.60661S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr45uw4rurWrAFWfAFWrXwb_yoWkJwcE9r
	y8JF95Gw1UCrZF9wnFkry3ZryS9FW2vFykZw13Krs5Gry5X39xta95A3Z3ArWDCw47tr45
	C3y7XryxZ34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjO6pDUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The IRQ handler stores each incoming byte into pm->data[] before the
packet parser gets a chance to reset pm->idx. If the incoming serial
stream never matches one of the expected packet headers, pm->idx can
advance past the fixed receive buffer and the next IRQ will write beyond
PM_MAX_LENGTH.

Reset stale indices before writing the next byte so malformed packet
streams cannot walk past the end of the local packet buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/touchscreen/penmount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/penmount.c b/drivers/input/touchscreen/penmount.c
index 4b57b6664e37..ba09096c6573 100644
--- a/drivers/input/touchscreen/penmount.c
+++ b/drivers/input/touchscreen/penmount.c
@@ -163,6 +163,9 @@ static irqreturn_t pm_interrupt(struct serio *serio,
 {
 	struct pm *pm = serio_get_drvdata(serio);
 
+	if (pm->idx >= pm->packetsize || pm->idx >= PM_MAX_LENGTH)
+		pm->idx = 0;
+
 	pm->data[pm->idx] = data;
 
 	pm->parse_packet(pm);
-- 
2.50.1 (Apple Git-155)

