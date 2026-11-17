Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892878;
	b=nTcJ/Mig8Vi8oaPLT6WfneOJcju1WcOwlpJi5aumAM6slpMakyvhfTMjmzv6X3hQDNLT
	 KVCR6rBymPLApAvYG3BotDCC/4LqANXw78d8peVlYy3ZC7sEu5Zy2bFAWZyXYOMOooTav
	 6j3nAzK+Fbh/6GrkpbkiYNhFJ6MDwSThH0xcKdL9XtSAEDC0PwT03SjpvVg/O7QrOU8mn
	 LHYXIJzZp6ltFdjEt7tS059/vEb16VukUqc4dcA5yFYuLfY70CX5+eZ/rbeNWwOHK3CVb
	 egBrihsOsqUBODmUU86JhpU0EBg5owqDGsviohHVZomvzrOQ1hTzlZ9cEe0pzILwL2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892878;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=PKuzruYde8o5Rrnc2hXCLl7BvEt4Oecgg5TOhjQsy+Y=;
	b=kI1fqJrMxuOzl2UQASgMW/ushw6mKro5IEpLt0CPtMivU794FNu3K55Jc/UxtI/DjoN0
	 Hjn4wpU/hvlMC8FFJDakpYGi9oWHQHL74VtPxPMZDAA0kJyqVdIC4ZLboYk89yZ8872yK
	 eV2voBAL1qrV4EUjXtKjyWik4eytOgRGqpizrIyhQG3MKx/RvYD+KHzbDActn0AJxThQQ
	 F+ib7muzI5o5KQM5aMJqKw+b5eqXl3+mBhOJRZl/oQXCnZs+KMFumm3QXXfrSq86GO07g
	 0FNO04k14swvwtxpJsWrdiSa6EcJdBKP81cyd+bDMB7amlmR3TX1oFEUqWDNEctlM0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=VvB+Nyr4;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBC606A335;
	Tue, 17 Nov 2026 05:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36FBC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=VvB+Nyr4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=PKuzruYde8o5Rrnc2hXCLl7BvEt4Oecgg5
	TOhjQsy+Y=; b=VvB+Nyr4aG2V6MsaAYoXV+IHju4t668EnyaJxHdlc+KlLmrR66
	UFdgncwHoVy7OhIIpib3IC2uODWC2twDiIJcX26s1CvPS/YmSVYigrPwJHR1+a6E
	LPOFConRyjcxbBGe3Ce2Ez2rQIMwbtY5xo9V7+divZ7vY7eBHhFf2HZAA=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S4;
	Tue, 17 Nov 2026 13:21:13 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 2/6] Input: aw86927 - widen the AW86938 boost mode mask
Date: Tue, 17 Nov 2026 13:21:08 +0800
Message-ID: <20261117052112.32527-3-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfur48trW5JrW3CFyfJFb_yoWkurg_Zr
	1rZw1kZ340ka1kta1DJ3sxZrZxtrn5C34UZwnaqr1YyFyIyFsrtF40qFWjqwnayrWDGwnF
	vw4UAas3ua4FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwV
	AFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIqXd
	UUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwASst

The boost mode of the AW86938 and AW86937 is a two-bit field at bits 6:5
of PLAYCFG1, but the mask is defined as GENMASK(5, 5).  When the driver
selects bypass mode it only clears bit 5 and leaves bit 6 at whatever the
bootloader left in the register, so the part may keep a boost mode that
the driver did not ask for.  Widen the mask so that both bits are
programmed.

Fixes: df53055c540f ("Input: aw86927 - add support for Awinic AW86938")
Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 813f359..9dda96c 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -45,7 +45,7 @@
 #define AW86927_PLAYCFG1_BST_8500MV		0x50
 
 #define AW86938_PLAYCFG1_REG			0x06
-#define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(5, 5)
+#define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(6, 5)
 #define AW86938_PLAYCFG1_BST_MODE_BYPASS	0
 #define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)
 #define AW86938_PLAYCFG1_BST_7000MV		0x09
-- 
2.53.0

