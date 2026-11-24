Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485039;
	b=MyyqGpVU8XEMlO+WcBmskCcxNY1TLLdUYfDudOXstU3RTumYGrfovKXtkUSV83DaPwyS
	 Fp6yTgCOfwhr8k4OcK2uH+ybjJnZ9gvdc8JJ6GVN4JGP64UV1nZot07acuvT4cKoiJ2ot
	 IzCjjz72xrZtQw4zPh7pLA1XwtBG7gwSzhfvbLcLI3TNomdXv3WkfJx74W1CcH55+nnf6
	 i+TE9JfyIAOn9e8PIe6hUt47ldkwfr3qdZN8Pi++TVTNiQLOErNg1m7N3wo4n7pX1djvB
	 jWvs3+KXO1W6Xk5KMOeW+hKExbiNRWL9VpJV38enN8F5xQWEphMCcbxmNg+ReC1IcmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485039;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0v6SacVxJF8vWHkgyLmi9nYNQ9TUMeNxVSHsYTdV6sg=;
	b=zzmX5F/54bILtS+2ykZepcJUeshSUFhwJKae68okjNK02w1bXA7CJ/VISelNLP02rLWk
	 cZQHHjGuaDHmynTwoffuhV795Ebc000WlahowCIHHroNWHI+s+WVMiRQ8ucHgPWpLTUBA
	 38puuflRYpmVPCQ/Fin5CDTgFZD5ka8OYS2XhhPJmaBBWdyEDGT7QMjNQBebZT+e/du4A
	 qzqrUTJZC5WxyXuW+bkIt9fbIrBrux3GpScqWdpgsnwoFR6wC1qBE6UnPk7XHsOL1TQH7
	 fIAjDwL5nfXoCh5nDcHcgajuuJ5LkyoRKm5/4psBmFmxstQa1+lqtNF1JM6hyAbTaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=MUkMHptM;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946C606A33D;
	Tue, 24 Nov 2026 01:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5946C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=MUkMHptM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=0v6SacVxJF8vWHkgyLmi9nYNQ9TUMeNxVS
	HsYTdV6sg=; b=MUkMHptMGF5ugiNmuemPcCie79bA0WhEJE0RckaiaHZ8r0Nn5d
	CUat6B+HR1Is3WpWpUO91hOUwQoh9EqQf4x5JRt7CLh3PcZsDs7O1MM/gbID1bG0
	RXOh0qbGrAa/M2f2ZizbYQEdxuRJrPdDCk0sK41C35/mr+KJYYY1GVIrc=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHPDFk7QRrHDHvAA--.1941S4;
	Tue, 24 Nov 2026 09:50:33 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] Input: aw86927 - widen the AW86938 boost mode mask
Date: Tue, 24 Nov 2026 09:50:24 +0800
Message-ID: <20261124015028.1427420-3-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDHPDFk7QRrHDHvAA--.1941S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfur48trW5JrW3CFyfJFb_yoWktrg_Zr
	yrZw1kZ340k3Wkta1DJwn3ZFZxtr1rC34UZwnavr15tFyIkFsrta1vqFWUXwnayrWDGw1v
	vw4UAas3ua4FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4
	AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU01a
	0DUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQAysK

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
index 6d09e5e96b2a..b9b7315a5dbe 100644
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

