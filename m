Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586231691A;
	Tue, 24 Mar 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381238; cv=none; b=sLySzvH2W6hwQs4hZrfmeGboNOqUCwfvLcY7y826UR8hxCjleTzrvbbCTFLlzM6dFuFteDVHKR+680ajO0cdA4nZPqXbX7wfHS0KGZNPX8/P8fTHsMPlojLw3ZUUFxgotYjt9HkalmGe2WrkmDZBUS20I+gkUwPTV2BWfTx3J+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381238; c=relaxed/simple;
	bh=VCse1xCtxoF4MyEFsHZyYJfrLmDWd9cd/+XS4IjkZ5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3PyQxlnD+z75OE/4N0Pa8NzIIwNuFXQ97QWdgGbu6Iz//Sao/w8qebQHcQ3iSdAutzvw8r58aG0qLtw2EBII3FEBItHs3UohwG3lfaeweHxDfMQsiyjzTBRv8TYtWPzVxnWrPjnrqE2H3MkcZIniN5fQId5ue+bs1JfJT/0JUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/ou4nn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/ou4nn3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2942C2BCB8;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381237;
	bh=VCse1xCtxoF4MyEFsHZyYJfrLmDWd9cd/+XS4IjkZ5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s/ou4nn3BRkMDgMGdlcSLPB3x2JLF31GA4loWC+T/WZHTW2lwN6lYdzqJGOa7IPdE
	 5WwZWtDGjpXVviUhLgneUl7ZzwbPV828b/iNptJHm29UT5pluEtuPto4WAguAVn4FG
	 HKKbFFBcfj5arTzlwzTFXNy2IEK8RLCIfKIEu9MXjs1VdgVjojIqfL5o+RiCX5AoxM
	 cMMWfaWF5U4zQKug+0u9T7Cy+Cnl6danPSTgQioNPWJU7AqlfAsUFspLmlaB7hfr4/
	 5SX8BJEituhNa+FIvojGWBu6zYWZQNxtqxeE7zwv7yq6T+5noLhXinoU7UdKmi9Jbx
	 +FCCWhXflhevQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6BEFEC104;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 24 Mar 2026 20:40:38 +0100
Subject: [PATCH v8 5/7] Input: synaptics-rmi4 - don't do unaligned reads in
 IRQ context
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-synaptics-rmi4-v8-5-2168d2df68f5@ixit.cz>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
In-Reply-To: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pY5k/gqKTi/BEjLe/7aOST0jOUN5xJW885H1HFH5k7g=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuizj1L2aPn4MWac2tmQe6Qi/G4LK/0KyGikI
 U94HP8mh8iJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 cob2EACe4bPaqNvBuA6OAvRf5kP9P+B4hA6NPtrVYoaFG6S47TdvTIHi9rUl7IhvrmluaRQ375F
 hEexpWn9xoYcoDw/2sqxPvC0bz1p5YGDA12IJ1dShlK5FdDqobL2gEF1TVi3mNFouHq0cMd5s6p
 wWymAkE+cMf6Z7Bfp7S1AGoEGlkAI/9iFsTAbDnZgH1mNiuBo1YN7ZQ8RznJ35ZD465atpbUia/
 9j12Hj1Zi+VzcoPAeENeG77NkuwoVd8r+CJt5KtHZjaJQkMojEvuXLVbr9bZcE36G1Wy+D/VsGC
 5crAaLcdw12jA2agAY70/63MyulyujOCgWlpNaeS+JWeOnlCkQLMVb8Tn2fObwMI879i16eQRwF
 7LfFC3TvFP4P3wNzWFAWbIEQRVOI3MdERz/3HuTW2T0ebO7hJZkyViVQwByBXC3PvX/eWacderx
 58HMG86iUog3HltZzboHrn/m6diQ4etaFVg7TK+WaMZv2+YjRka6xM16qPxxqM5SuFau9fnkQLl
 n1BGgQd05rGNjTAtD1kLh/p5P2XMJdNYtjgE9GcdIxjEwiRnGy1Gf5jeMdy2sMRXL2P9a+u+uaH
 GN9fJ7eBcDND6sK+lTX+o2pd+zNtbFsiO5diQgPGgAQXbr+6p4WYrn5fZozdHhULfT1BX3cZndd
 mrXFzZqxl+cCqzQ==
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
index dea04cf076eb4..fc84799c36e04 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -137,9 +137,14 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
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
@@ -1078,16 +1083,17 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
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

-- 
2.53.0


