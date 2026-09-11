Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D554363C43
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138676; cv=none; b=RiSc6N6KyYCSmiHGdXm1/gTE7w3vHOd58PqmpZgA72oYWsBsBB5Cu+nOv0XBh0r7lbrwDJ6ctCZtrlioizb+CSwM2tQA0gp4COE7U50dhcrlZE6WvfITzYh6hTXybMTqEhAsQr4cxHyDdyeYvOPzDabPwBz1fm0m1JJLAZ90DKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138676; c=relaxed/simple;
	bh=F4r76OBS8+e8Y3mu6kU1rknr580/wKxEFSTkvEGLgis=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FWCIvzF+RfupHETP4hTp7E5tIlQWzTwjlwyLtStrI23JKU0nUyYb+zQDQdQpEUA5q29Z3y9sKa1zt47nKLrbaKesoZvpqeMUJezQAdARcxPfNmMBnawx4vrxRqKUnl2rUe6OvlaeTZPodAyZsz6zBif7NYfrdl/y1dJUyn6JfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjyAkiwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjyAkiwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673DC1F000FF;
	Fri, 11 Sep 2026 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138675;
	bh=8W3COm6uVZjAwnjTBQvACZlpOwmC/SpK8fiTy06SGQc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VjyAkiwP/QL8b9J/8A28Q10j74fUX6JTYUkKToF0+4OL2mdZRECzHRc7D25FyvF6g
	 BS6jSSiRi+rAVzvrplSCgfeiqYcXl8Y5LZcLrV0pXpTHLG5VvGeq5FPl5ZCq0+2XQx
	 VBymjtufPbXB2EuebFKGL4ZiCBPykSjvFWEvfmoj8J0nY59DrpWZleNd7r3x5L05Gb
	 f/ESbNvPXKWwxZdn+4MmiBxfrB/Ps0Y9YpSvYAjRvt0t1KssqRPDO6sZNFBJnoFrAI
	 7f2aym5eDhc466/DOkl2AT84Er1v8bS5ZHxEgLZExsSbrJQiZqKAokDo8WrAP90yS0
	 wp0xYaA0hmfCw==
Date: Fri, 11 Sep 2026 16:57:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Matt Ervin <matt@sockeyesoftware.com>
cc: linux-input@vger.kernel.org, bentiss@kernel.org
Subject: Re: i2c-hid: IRQ storm from Synaptics SYNA32A4 (06CB:CE17) after
 resume
In-Reply-To: <CAAHC7=5QpROQFfmTsrWbt3jxyAGO44jLq9h1Wnsk7JtmuZGLMQ@mail.gmail.com>
Message-ID: <8p372135-55q0-2q5r-po59-5nos4s9qn672@xreary.bet>
References: <CAAHC7=5QpROQFfmTsrWbt3jxyAGO44jLq9h1Wnsk7JtmuZGLMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 1 Sep 2026, Matt Ervin wrote:

> What I have NOT established
> ---------------------------
> I have not built and tested a patched kernel, so I cannot confirm that
> I2C_HID_QUIRK_RESET_ON_RESUME itself is sufficient. What I know is that
> a manual unbind/bind -- which performs a reset -- clears the storm
> reliably, and that it returns on the next resume without it.
> 
> I am happy to test a patch.
> 
> Proposed change, if it is the right call
> ----------------------------------------
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> #define I2C_VENDOR_ID_SYNAPTICS 0x06cb
> #define I2C_PRODUCT_ID_SYNAPTICS_SYNA2393 0x7a13
> +#define I2C_PRODUCT_ID_SYNAPTICS_SYNA32A4 0xce17
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c
> b/drivers/hid/i2c-hid/i2c-hid-core.c
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> { I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA2393,
> I2C_HID_QUIRK_RESET_ON_RESUME },
> + { I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA32A4,
> + I2C_HID_QUIRK_RESET_ON_RESUME },

That seems like a proper fix indeed.

Why haven't you tested it, given that you have the hardware and write 
"happy to test a patch"? :)

Once you test it, can you please submit it properly [1] so that we can 
merge it?

Thanks.

[1] Documentation/process/submitting-patches.rst

-- 
Jiri Kosina
SUSE Labs

