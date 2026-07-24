Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0625785C;
	Fri, 24 Jul 2026 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853849; cv=none; b=Id5hvSMqKbOzwqzMP39XOAMzyo+FUTclj+1/tDtoCJqkjPgTlRS670dK5uJ2IX5mWA3nemi2+QR8XCQp7K+1mCO4xVPGCj4zDfqVsvuZxYZHplIH21/ZnhI3YGS+l/JJbuKyYtodCLfZrgyPorSVZmIFwYa2jc0KXeCLoEHnjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853849; c=relaxed/simple;
	bh=/I8j5+x9KPr+NM+YqMt2AH5uB+21+2ScyS6YYDOpd30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvWZarOq23H6hndpCTlmJKhKHlyiB6PUqcNExadOzQMfZqo/GT/GCVDrnVqZvKb9SJ6Y0xFs3GIKtioieE3GLDKhVE1BJjKL4nZK9gYaV9/L1d4jPrsY1MtWY2furKKuuyTWsBc0Qan2E31abRciPH2x1Uuo/t0Hy5G+Iaht1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9WFT3u7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9WFT3u7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A837D1F000E9;
	Fri, 24 Jul 2026 00:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784853848;
	bh=sAND/GDyhYDB9I2ZmQ4z/BduIDPd5rYlZAnMfIgsk8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C9WFT3u7h9tiSV0d0ZFhLcxU/K0vBjiqzCG7K7tzPXXLgefAaaIfG4cmUdM4mP0GL
	 yD1ZNuuP6aa34bLlUW2S17B4wOSeN9Q3aiLr78eOqEL+79B50FO9CtLI0XPLI0Na7q
	 XfwsvGD3Zl4gLP+4aty2sFGBHzW0eeA59cJgCXO/iFI8KQ3XqEnZLceV1DikZ9t0eR
	 pytM0elHK8+0MBDngnMmk1H/t54QWf7hqOgeHXuO3VIGZbZKUVcvbgEJa6nQBnIFJj
	 WCMg5iUCxKjUddOATDfzjdoD2fUmFP/WTQ7IaF9rYJCA2YIdaWTCwdLNtYMtEMUmOG
	 5dbPiM3RGTq8Q==
Date: Fri, 24 Jul 2026 01:43:59 +0100
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
Subject: Re: [PATCH 04/12] iio: position: iqs624: use
 devm_blocking_notifier_chain_register()
Message-ID: <20260724014359.6bfb9139@jic23-huawei>
In-Reply-To: <20260723175325.37397-5-farbere@amazon.com>
References: <20260723175325.37397-1-farbere@amazon.com>
	<20260723175325.37397-5-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:53:17 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> iqs624_pos_notifier_unregister() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
