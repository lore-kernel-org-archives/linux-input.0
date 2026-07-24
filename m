Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8E21CC71;
	Fri, 24 Jul 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853808; cv=none; b=ISY86Rh4NeF3iYeAEw2XO28opLI3Odik3/Z11fmPhMnKty28EadGdZUJWUtS9bTi0rZo98OXrr0Q7TXSqZL3hlYvhi8fXMh57Ne/dpplso0J93A3Jwy5yAfbBknqIHZB9iG+S5bdfczZ6ERJSLw4uOwTaUHsmMnk+zTrEbhRUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853808; c=relaxed/simple;
	bh=TUDslfQ6AHbaIRWv5z8CH2oD5DRVsRi7DoS3MtQPiKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj1IfWiYqrbRz9OL3f48PLjdjVDcFbpJ+YCYOJZ4ZK3s0K2+Srgnh9gnStD/wfp7m0/IhjV3g1PzGH2D+Yf3l0PWfHx2R0kvhIL4LQZMDnUzfVMw8nPTtZZHk5moNvATMaymp2zM0W1JHSTaBWNjGTzntScjp40a20GigHCQWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxrxTpOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxrxTpOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B071F000E9;
	Fri, 24 Jul 2026 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784853806;
	bh=Zx3cHNYN2OPwFgsjcFq7S4HDPrL4HbkMZ9aUbpCAnrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LxrxTpOkW/C6SRD156xzONQe8B8KA8Co3sO8WWFhFCp1ZryeorGu4PT29v1C467tb
	 r7W+k0LG7Oh9rQrblIIEfxrAcmr7jgUhv+k2r32kpPGxScQtGfBn5tDszM+RlUb+01
	 GFLQSkxSxZR/efGxu8/AMy5jj7vLfPPNGIGSOG9vqVJVHQWNiAiyGjtcJaye2/i4He
	 jdbYCy6bQ5zqyjCq7LNg4e2tjZMsp12iVzaDX1/6viEFIHHjtuJ5xPRdDpVQ8ya62s
	 pXtVP55HouaZ8yYOSS+Ge2aMiNfgt187rCke8Fe2vb4CcPLRI4ZZ+BbXI2Y2cpVv2G
	 i74YO3tO3b8Xw==
Date: Fri, 24 Jul 2026 01:43:17 +0100
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
 <ankita@nvidia.com>, <leitao@debian.org>, <jason@os.amperecomputing.com>,
 <pedro.pbg@usp.br>, <paulmck@kernel.org>, <frederic@kernel.org>,
 <kees@kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 03/12] iio: light: iqs621-als: use
 devm_blocking_notifier_chain_register()
Message-ID: <20260724014317.29d6c627@jic23-huawei>
In-Reply-To: <20260723175325.37397-4-farbere@amazon.com>
References: <20260723175325.37397-1-farbere@amazon.com>
	<20260723175325.37397-4-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:53:16 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> iqs621_als_notifier_unregister() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Seems relatively unlikely to cause a merge conflict if these changes
go through non subsystem trees - hence the Ack rather than asking
for an immutable branch with patch 1 on it.

Thanks,

Jonathan
