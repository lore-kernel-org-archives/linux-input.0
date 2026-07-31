Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA478378823;
	Fri, 31 Jul 2026 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530061; cv=none; b=WcSQVqESAB4LhZzedt0Bf6DzKCgj2jAtaKLzuuJcyvDiPlWpnpjpTx/Mh/JDthXOXLlPlpxS9TOjYcd60un/lGAw9aMes9m/hxsRYK3aGDGUfog8zRrzaY4Wr1vASqzWX32w+STTjLz48sxMymj7Z76Iod5t53bICX/jGevMzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530061; c=relaxed/simple;
	bh=Aw+NrUCA5ebHr7SpJt83ZqJ1Oul+yWL/nBP/ZUMMB6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFN/ZCe+tr0fJrjZ0EZdwQvZ5dCR+Ccy495h9TmmgVZjkYLAuZdZSurrdHKEsBR9Dx6qCHQzk4mZu7pvLWQFuB+OCXpwDgfJCIpbE7Mx1W3P6kv+3dNJchI+o29zLW25P9WKSvJa/VhVeqZ5/jzbbyygEwssqJPpEZCQ24+9dFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsEdIuc1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsEdIuc1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F966C2BCF6;
	Fri, 31 Jul 2026 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785530061;
	bh=Aw+NrUCA5ebHr7SpJt83ZqJ1Oul+yWL/nBP/ZUMMB6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FsEdIuc1RSrnzF/iOVLy5g96TP8utoFWskYC77ow79m/CLFjCUPrhpy+b6YAzp9IC
	 ffxtwmh0E+gnFypj/KBgTUhynzwQS5n06kkJpJhvzi+BMGkUZnCY/ibHTq3sz9x8Ro
	 iiDPNM2y3jPjKMz61kKgH7DkRkXJyHxgFc2DOJYsplSI3FWNn56C3rEMINrYclylM7
	 IpZTRzbDxUQmGWh/ckc7kgo5m0hhAhZPNGTLWHeh+wlo+TqhcJIEH/RKfB3VpFors7
	 5S0iJjJ0u6pmjnVQHu/t4plToD2bmmpykEAeGUGDnKgj2Zhyi2+V1KqjMnKXmjtjlx
	 cCHHYhnq/b+bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64723C55173;
	Fri, 31 Jul 2026 20:34:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 31 Jul 2026 22:34:14 +0200
Subject: [PATCH v9 3/5] Input: synaptics-rmi4 - don't do unaligned reads in
 IRQ context
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synaptics-rmi4-v9-3-f088c47af6c5@ixit.cz>
References: <20260731-synaptics-rmi4-v9-0-f088c47af6c5@ixit.cz>
In-Reply-To: <20260731-synaptics-rmi4-v9-0-f088c47af6c5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Marcus Ramberg <marcus@means.no>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=vAqnQGN6pz6rr7DIayEzXt/GiaRM85ZXWL7LWrBPOzA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqbQbLDb7vW+fOcETd68pmui1yZb4EPzX4JJYER
 8z2eXJvI/2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCam0GywAKCRBgAj/E00kg
 cpQREADJf5PE0SUaT6a7UkeXvChP0dBZP0GkVwrJKuSvXC/Is6YISns/p5VkcRkGcCGFmbJeLPE
 qXi1gENbyoPfSAQpTKQPUKyZ4mPLMPVwTk6m/RLuS1gp0us9noq5poScpIjYiq5LaX6REZTdNJQ
 +vvLH0xSXAViYnz0tl+J7P9eo63FuYTqxdkkK+M+Dii5i/a9sUVkDgOcjamNnjJuU+bzJYxnMoN
 knqOODf83/OhWkjVXI1hh8SlE3d4m3xjiPH2A3/qvpBLVdf8FUTTHLm2LWTU3L4p6Gszx/FUM/W
 JYvGuhc9+aGnBTsvNuE0Sh9BcyGhfdFNQJN/9qBwuhMCFNZ4ehNtjJA5aHM//sjDauX7JpuedLW
 7EfrOU3p6aIPaKFK89dBZysk5KVe1a3NOGWQ+G0WQEs+xj/A9Cf6DuJMjl+NfwJApMYJimVsTmP
 JvCdwcq0Ea1MoR6OkjwiMfdzOV0laqINSkIClKV5c8dqz3DJsKUJGf1MZrI6VJKYdqnQLnc3Seg
 K8HZXenVJghJGUeCzRbM7iNw0vkyqMsSOzTY1XS6KYiqG5jzTxsSIaD1LzYomHjiaetzQH4TOyn
 GHJCpYZympEkl4JdHiKUWqrs0S0oxdwfpd3GhCrVs004qj+g9pD5n9Bc/9EkpxEjzLqFbji76Oe
 rSxLjxhPpWT1FLw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Kaustabh Chakraborty <kauschluss@disroot.org>

Some replacement displays include third-party touch ICs which incur a
significant penalty (1-2 seconds) when doing certain unaligned reads.
This is enough to break functionality when it happens in the hot path,
so adjust the interrupt handler to not read from an unaligned address.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_driver.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 3edec5ae1f8c9..5e7766363aa23 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -133,19 +133,24 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	struct device *dev = &rmi_dev->dev;
 	int i;
 	int error;
 
 	if (!data)
 		return 0;
 
 	if (!data->attn_data.data) {
+		/*
+		 * Read the device status register as well and ignore it.
+		 * Some aftermarket ICs have issues with interrupt requests
+		 * otherwise.
+		 */
 		error = rmi_read_block(rmi_dev,
-				data->f01_container->fd.data_base_addr + 1,
-				data->irq_status, data->num_of_irq_regs);
+				data->f01_container->fd.data_base_addr,
+				(u8 *)data->irq_status - 1, data->num_of_irq_regs + 1);
 		if (error < 0) {
 			dev_err(dev, "Failed to read irqs, code=%d\n", error);
 			return error;
 		}
 	}
 
 	mutex_lock(&data->irq_mutex);
 	bitmap_and(data->irq_status, data->irq_status, data->fn_irq_bits,
@@ -1117,26 +1122,27 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 		dev_err(&rmi_dev->dev, "Failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
 	data->irq_count = irq_count;
 	data->num_of_irq_regs = (data->irq_count + 7) / 8;
 
 	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
-	data->irq_memory = devm_kcalloc(dev, size, 4, GFP_KERNEL);
+	data->irq_memory = devm_kzalloc(dev, size * 4 + 1, GFP_KERNEL);
 	if (!data->irq_memory) {
 		dev_err(dev, "Failed to allocate memory for irq masks.\n");
 		return -ENOMEM;
 	}
 
-	data->irq_status	= data->irq_memory + size * 0;
-	data->fn_irq_bits	= data->irq_memory + size * 1;
-	data->current_irq_mask	= data->irq_memory + size * 2;
-	data->new_irq_mask	= data->irq_memory + size * 3;
+	/* The first byte is reserved for the device status register */
+	data->irq_status	= data->irq_memory + size * 0 + 1;
+	data->fn_irq_bits	= data->irq_memory + size * 1 + 1;
+	data->current_irq_mask	= data->irq_memory + size * 2 + 1;
+	data->new_irq_mask	= data->irq_memory + size * 3 + 1;
 
 	return retval;
 }
 
 int rmi_init_functions(struct rmi_driver_data *data)
 {
 	struct rmi_device *rmi_dev = data->rmi_dev;
 	struct device *dev = &rmi_dev->dev;

-- 
2.53.0


