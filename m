Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD134C141;
	Mon,  3 Aug 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783155; cv=none; b=D3o1bv7+lsG+iRjqSMrXkg45v3OjsF5zXX2CZZC6QMyyG64cgiLEHOBZh9Ok9ErDhdQ7qdv/pOOu3sfhOUWIXcQvJhsm5ad7T5qYyeMmONnqqLwKbC+pDBASwSTUGIn8fNUyDN+mP29sSvvzinX4GbMuHtT3CC9zMbHVLCSZihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783155; c=relaxed/simple;
	bh=eIhYPupwLcTqrKKi8K5uR85YeqJMrTyCeZbZOAqQ5UU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jL2WuJyAoduldPMDwYNU9vJ2O8gAHL5RJnbQ8/arS5pjQB89CySYWDXCFaDerO3O+5xDfYz+e4vDPm8nPhEjftgFyEBKp1LA603buev7vgfz8eGQPhG37rQNRtiIaQRa+b9q+RQRNN/e0Fi55gPwfMfy1+FEvrhKmy7v4wIrr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsmZgJ7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsmZgJ7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002351F000E9;
	Mon,  3 Aug 2026 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783154;
	bh=3g+xbiaeG3SFkhq5kXsw+jMtbPOy9LtaKXexOX4bk38=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fsmZgJ7eM0nGvtHJN+P+sx9t2c3lGDpkaSJl3b3W/5LMptiw6X0lcWapwQjqX5DDP
	 xqbJXhCwv579oyHt6WfB0ArfBiFNdX7iPPUL/p2KD83mcB197Qo37hU0361Ja8DgiS
	 3ZHnm1vel0E4ha/J3VUeTOz2qMs+s9X3CJt+A53du60y3uD9uapxmq3LQu3+4n1Mlg
	 MoihSLTr0rUJLA6InkRn8/5VjO3GmM4b34uFOFErw+8gK4+svppPxUrEKiVmKtAK3n
	 0pmUzCutG1x39Lea4sx63PlUgReWHwLCdPKzXl/RhOu5cdkamLMQVIPGOtR0DsGQHf
	 pG4SjFfZwwdKA==
Date: Mon, 3 Aug 2026 20:52:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ai Chao <aichao@kylinos.cn>
cc: bentiss@kernel.org, dianders@chromium.org, treapking@chromium.org, 
    kenkinming2002@gmail.com, raoxu@uniontech.com, superm1@kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: i2c-hid: Fix "(null)" output when reading report
 descriptor fails
In-Reply-To: <20260716112932.4038146-1-aichao@kylinos.cn>
Message-ID: <7pn3n63q-soo6-2627-8p75-rs478236onp9@xreary.bet>
References: <20260716112932.4038146-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Jul 2026, Ai Chao wrote:

> When i2c-hid fails to read the HID report descriptor during device
> initialization, the error message prints as:
> 
>   hid (null): reading report descriptor failed
> 
> The HID device name is set in hid_add_device() after calling
> hdev->ll_driver->parse(), so when i2c_hid_parse() fails and calls
> hid_err(), the device name has not been set yet, resulting in "(null)"
> output.
> 
> Use dev_err(&client->dev, ...) instead of hid_err(hid, ...) because
> the I2C client device is fully initialized with a proper name, providing
> meaningful error messages for debugging.
> 
> Before: hid (null): reading report descriptor failed
> After:  i2c_hid i2c-TPD0001:00: reading report descriptor failed

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

