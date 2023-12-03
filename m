Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k2eki61H"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC771D0;
	Sun,  3 Dec 2023 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=XqEhjdCUEhgSRQMHNm
	7WceDAtyAPDpPFSop9FAZXPDQ=; b=k2eki61HONGLHP5P3jPJgr+HDZgJgFbz+J
	V20VHim35C0ePeAy/mfx5Cma/mzQEXnR310bOJMqT+/Ae+iA04qnnspBy4Prk/za
	1+hdeltfrNVipyu3VMABXOwb/SCchzVFpaZqcfHkzHlZr8eYkUBXovXPZ/aveuYW
	ntUJs9RG4=
Received: from localhost.localdomain (unknown [39.144.190.5])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3f80JsWxlMsRBEg--.16729S2;
	Mon, 04 Dec 2023 00:47:07 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] ipaq-micro-keys: Add error handling for devm_kmemdup
Date: Sun,  3 Dec 2023 08:46:53 -0800
Message-Id: <20231203164653.38983-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f80JsWxlMsRBEg--.16729S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48CF43XrWktw1xtF17Awb_yoW8WrWxpa
	y5G390k3yUWw47Aw1DtF1kuryYya95XF4a9FyDK393uanxWFyktrn0krWSgF1kGrn093W2
	q3W09rs8C3WYvrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRn2-nUUUUU=
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBchY7gletkAhV1wABs8
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Check the return value of i2c_add_adapter. Static analysis revealed that
the function did not properly handle potential failures of
i2c_add_adapter, which could lead to partial initialization of the I2C
adapter and unstable operation.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. In case you find this addition unnecessary, I
completely understand and respect your perspective. My intention was to
enhance the robustness of the code, but I acknowledge that practical
considerations and current functionality might not warrant this change
at this point.
---
 drivers/input/keyboard/ipaq-micro-keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index 7b509bce2b33..1d71dd79ffd2 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -105,6 +105,9 @@ static int micro_key_probe(struct platform_device *pdev)
 	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
 			   keys->input->keycodesize * keys->input->keycodemax,
 			   GFP_KERNEL);
+	if (!keys->codes)
+		return -ENOMEM;
+
 	keys->input->keycode = keys->codes;
 
 	__set_bit(EV_KEY, keys->input->evbit);
-- 
2.17.1

