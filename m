Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501C1C84BC;
	Mon, 27 Jul 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117594; cv=none; b=Sk27ABARdKfg2CmdmP/dk9Xb01DxedG/G+6ufNodnodNux0X6f1f+kN528UfaPlBU1hPI+metiXr2GUikl7/liYEqC8kCttaEmHJ2n+qZyCS3Bg1Imh8GgS/ASXK9oCEw0P++wkO1+qTLYbbHo5oydhajDX9LRnySQs0rrydUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117594; c=relaxed/simple;
	bh=u8Mt7HAFbY6OqlykdtFxpDnfyjSCyALMFrH/EOd83oI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0sVQBdn2gP3UAcoIBjWNjJ6NalC2gSyDMkUHvZzK3H6OpZ82FrFIB+17EzNaeYQd79ltAgO1TxRlLoaGAhEtwQjE1znfmJlZPg0IenrgKXP9Po3oxFUSuWIez+dRwl4WNlmYsB1lAuwFGaQkvP7LlCYcLTKt72Vo2HeI89AGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY4hJjB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY4hJjB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9058D1F000E9;
	Mon, 27 Jul 2026 01:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785117593;
	bh=nZJso3wvl11PoLPxnOpvESbySVV+G23t86b38Wal29Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JY4hJjB+fRmaD1UahHTdI4SLUjeYBs7C1mmv4sFWVW95dY5Z5Ose4L/svPJK4aAw7
	 c/lkgZ7ihdnHbfatDpfMJug3IoKFeeb/AH9aPcBYE3RWrpauMQ92bOSj6DmMa5d/In
	 guLNpyvpY9dfgtmS4pWbp6kgjcuFgPtSIifmXSuynEsFc/SnkFPtvJ+QuH8n2L2+jX
	 HjO1FrJzvRby/MAzbbV7dgERD2MmTNcJXB5kE2PjROZRz8B+imGMbwQK9IVVNDJiV2
	 0IoC7V+V1YGrA8xJgZPrra+ix4iBcnK7mCygAmevSGwqODpDpO/n6vaynPSDZCibs+
	 DoYKS7JZPNACw==
Date: Mon, 27 Jul 2026 02:59:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
 <guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
 <lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>,
 <linusw@kernel.org>, <brgl@kernel.org>, <orsonzhai@gmail.com>,
 <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <dmitry.torokhov@gmail.com>, <hansg@kernel.org>,
 <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>, <ukleinek@kernel.org>,
 <fabio.m.de.francesco@linux.intel.com>, <kaihengf@nvidia.com>,
 <ankita@nvidia.com>, <leitao@debian.org>, <pedro.pbg@usp.br>,
 <paulmck@kernel.org>, <frederic@kernel.org>, <kees@kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 09/13] ACPI: APEI: GHES: use
 devm_blocking_notifier_chain_register()
Message-ID: <20260727025946.325bb038@jic23-huawei>
In-Reply-To: <20260726101739.33170-10-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
	<20260726101739.33170-10-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 10:17:35 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> ghes_vendor_record_notifier_destroy() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Btw I fully agree with Borislav reply to say slow down! 

I'm not sure anyone will like having 3 versions in their inbox
when they get in to work tomorrow.

Jonathan
