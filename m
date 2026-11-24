Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495850;
	b=3pKw9C8VS0112HUhjxt1gSyRNnpHnykOvYOYJo+pojOUfrYk9NLE0oBOYOHDD78Ipm9A
	 twhvdRvg+vss4vp8cvca9+5FU3Qs7CLeIbBnKiLyz70I61KxOvt9Jhn2tiswIwRsLRfa/
	 xSEMvj4xCHHv82LRVP8VeVUCFm/4l2/b0EMNs6+I9dz6NqrcBsPCdgsnx5IJog6XZ/5Oy
	 jmy6sXVlQNeatKWVdZY1JA2YBGVpozNNY8cJ/gn7Vvuvy+FwBHdSdgktN6hQD7ee7wdJW
	 aoBoAF0HhbhNe4w4lAVJvpzZffLEdHViS9sknu0f3TM9Ru4aGKbCIa9DTMotLz5FclQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495850;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ewSzo5E2RmlrGMTa7u3UhBHfrlT5mrfj1tOFQ4UHy9Q=;
	b=zgk9ccztY+jWndVA1OcHzJSnEg7wQlXqDLhy6ZHmre2+TJNYIz6vuRb5qOC0F6juFzef
	 ANk9CS7IpXT2/Ot5J3ROV9bdMforWx6GExIYI53n1tjhiYhan8GpSHhgF06Acq68Dom+l
	 5nc/SwYQV/Sy1EmiK4m0EgHKZESDUfhSXZj48YqnApH/uzUgHDybvCHJppDtu4C+POS5/
	 AXpu1ZFH9G066cCmmwEs1qNRcxJgEyK5WqbW2RQOujnnvS+ehtpH8bHU+puhE/fw2hjzw
	 XwxNTGHnOUGIWApuEtDkFo4tgwLQ1A/1gxem5FrOCiwmGWCAQVGZTnYWKIe8COL8XIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=YnQ1isrs;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16499606A322;
	Tue, 24 Nov 2026 04:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16499606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=YnQ1isrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ewSzo5E2RmlrGMTa7u3UhBHfrlT5mrfj1t
	OFQ4UHy9Q=; b=YnQ1isrsEVntDRN6JERjoKocLqutJTmKtPejKhQw+tXOBRgDro
	8eAY0McofIVE5fLF9PkzF6UW+bFDpXW3oYy+GE3QFaM28NVE05UWPRrZiLCSizzH
	PFIwz7MKb5Fihm2WV0hTybSlnFQjAJ3If2UWZNPDRlMuj66s7pPVR4E78=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S4;
	Tue, 24 Nov 2026 12:50:45 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] Input: aw86927 - widen the AW86938 boost mode mask
Date: Tue, 24 Nov 2026 12:50:36 +0800
Message-ID: <20261124045040.559317-3-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfur48trW5JrW3CFyfJFb_yoWkuwb_Zr
	yrZw1kZ340k3Wkta1DJwn3ZFZxtr1rC34UZwnavr1YyFyIkFsrta1vqFWUXwnayrWDGw10
	vw4UAas3ua4FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwV
	AFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUVVbk
	UUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AAmsl

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
index 6d09e5e96b..b9b7315a5d 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -44,7 +44,7 @@
 #define AW86927_PLAYCFG1_BST_8500MV		0x50
 
 #define AW86938_PLAYCFG1_REG			0x06
-#define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(5, 5)
+#define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(6, 5)
 #define AW86938_PLAYCFG1_BST_MODE_BYPASS	0
 #define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)
 #define AW86938_PLAYCFG1_BST_7000MV		0x09
-- 
2.53.0

