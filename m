Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BB4A263A;
	Fri, 18 Sep 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736860; cv=none; b=lloVa9Bhxl4ku4jKH6EjK7RxtFBqfMjg8ScNGxdldKvJ/InzmRhVLzxTylo3Dy65DsPJvbA/pC+Y5YqJcP4aDd/fmgf6CvjKcw2QZS7/Smy0J2K97669jjRV7mgupTBmmcZ132ZijYNwQTJVC/DyzXk5AgBcTUQLEcHK8+4z3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736860; c=relaxed/simple;
	bh=yLRKkVjHFH2CAOoqG8ghcoAuUHWfmqtMg8pbmAm89bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTFsnfCijM9VdCftWYbeDNuQ4VPP2O91S+2q+bPpzM6WcMgAXq9vfPehSYu9Es91RlxHz9eOLQUu9nxv5GA9lepELCRlWg6jvXQKzzGqv3VzGnA3+o23n4zg/+LuM5iq9JVyf/dq7V5YtRDM97AjbzUsy8+7JtsE416XMcFfwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=YhQgO8y9; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="YhQgO8y9"
Message-ID: <bca0facb-8840-4691-aebc-e3063c6c3d14@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789736850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUk0QaHaOHcefy3cF34cxRQ5NlHqBn6AdrcK4LTyzD0=;
	b=YhQgO8y9BMFmml0KZlH0FT3AzNCrA9YHyuNWujznrpuMnz1ALgUCyFNCQ8kHqjn9e3LP1W
	C5qUW5G85qOui0zY9hOqpaMHc7EvyGHSn3yeHxWUIbU8xYCU7D/G7VTfm7soeMTiaukDR6
	qvQmbtZSe39IrGiLUQtLtTiEuaJwd+4=
Date: Fri, 18 Sep 2026 15:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 05/10] mailbox: apple: Add DockChannel FIFO controller
To: michael.reeves077@gmail.com, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-input@vger.kernel.org,
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>,
 Sasha Finkelstein <k@chaosmail.tech>
References: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
 <20260918-apple-mtp-keyboard-final-v2-5-a5c685e50b60@gmail.com>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20260918-apple-mtp-keyboard-final-v2-5-a5c685e50b60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 13:06, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> DockChannel is a hardware FIFO used by Apple coprocessors for
> low-latency byte-stream communication with the AP.
>
> Add a mailbox controller that preallocates RX storage, tracks IRQ
> enable state in software, and reports TX completion from the TX-empty
> interrupt.
>
> Reject messages larger than the FIFO and return -EBUSY while the
> previous message is still pending. This keeps the provider usable for
> future small-message clients such as serial transports without a TX
> worker.
>
> Handle RX and TX interrupts in a thread so mailbox callbacks and locking
> run outside hard-IRQ context.
>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>   MAINTAINERS                               |   2 +
>   drivers/mailbox/Kconfig                   |  12 +
>   drivers/mailbox/Makefile                  |   2 +
>   drivers/mailbox/apple-dockchannel.c       | 371 ++++++++++++++++++++++++++++++
>   include/linux/mailbox/apple-dockchannel.h |  29 +++
>   5 files changed, 416 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7fe2ebb5e..e5be5934c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2677,6 +2677,7 @@ F:	drivers/input/touchscreen/apple_z2.c
>   F:	drivers/iommu/apple-dart.c
>   F:	drivers/iommu/io-pgtable-dart.c
>   F:	drivers/irqchip/irq-apple-aic.c
> +F:	drivers/mailbox/apple-dockchannel.c
>   F:	drivers/mfd/macsmc.c
>   F:	drivers/nvme/host/apple.c
>   F:	drivers/nvmem/apple-efuses.c
> @@ -2695,6 +2696,7 @@ F:	drivers/video/backlight/apple_dwi_bl.c
>   F:	drivers/watchdog/apple_wdt.c
>   F:	include/dt-bindings/interrupt-controller/apple-aic.h
>   F:	include/dt-bindings/pinctrl/apple.h
> +F:	include/linux/mailbox/apple-dockchannel.h
>   F:	include/linux/mfd/macsmc.h
>   F:	include/linux/soc/apple/*
>   F:	include/uapi/drm/asahi_drm.h
> [...]
> diff --git a/drivers/mailbox/apple-dockchannel.c b/drivers/mailbox/apple-dockchannel.c
> new file mode 100644
> index 000000000..d0a66e1b7
> --- /dev/null
> +++ b/drivers/mailbox/apple-dockchannel.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple DockChannel mailbox controller
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * DockChannel is a byte FIFO used by Apple co-processors. This driver exposes a
> + * single FIFO pair as a Linux mailbox channel and moves payload bytes with PIO.
> + * There is no DMA involved, so relaxed MMIO accessors are sufficient for the
> + * FIFO accesses themselves.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mailbox/apple-dockchannel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/unaligned.h>
> +
> +#define APPLE_DOCKCHANNEL_FIFO_SIZE	0x800
> +
> +#define IRQ_MASK			0x0
> +#define IRQ_FLAG			0x4
> +
> +#define IRQ_TX				BIT(2)
> +#define IRQ_RX				BIT(3)

The dockchannel interface used for dockchannel-uart / DebugUSB uses 
different bits here, so these should probably be read from the device 
tree if the mailbox driver is supposed to be somewhat generic.

> [...]
