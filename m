Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86075391505;
	Fri, 16 Oct 2026 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129111; cv=none; b=C7i89AGLjX01nEnZW6FLjUryWbfpLfkpxL09jpMgKjXwjT7IvBnYKiV7dB5Z99oKA/y3atMRuiMSL5T3ljZdGpjIx2mqJFmdQN3WDGafg1+IqfoJ/t4Pp4rKQqOiIfUNdcm1hWI3B70RfYm2X2L2a2oQ0rjo4YTjJhzC6keGFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129111; c=relaxed/simple;
	bh=nEMDcs4Zs8kI1gClc9kpOz3v9gplPFjZYGvHidHei8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB9PkaqRwJ9RPHn2Z+Xg5TdHQhK3K73mAWJWKhYwjjs+mSjNE+yLXwHMajZvDCqXlexlRVOO1kJQ337F/b1/GwQfKaaV4BS4Q+6AjCQEj9GK8WW0CzR8WOwzWm9Prr9q31F4/5VEwHsAJERxeJU7mPCWTPBoE5Z9bjYxfPWvEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnKCKQA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnKCKQA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0151F000C4;
	Fri, 16 Oct 2026 05:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792129110;
	bh=JGEVfYNl18koKRIAFfTstQnQp506IaOOikYiWUvbgK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KnKCKQA2k1CY0Z0NEIwBSOycF6RUAKt/oJPwSFVEcLte52letL/itoSwjyF+jprjw
	 rd3dWH7Qa8YisUuKAkzJxXTHwyAHiDv0lzdB+DLBFLdrC/qVeb22XO4MWUUgnE6sU+
	 TiU00JqwnMi49dg8v6FwkbUbKMawjOAEfT0TzBWA=
Date: Fri, 16 Oct 2026 07:38:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH] Input: sysrq - reset the per-device key state when
 reparsing reset_seq
Message-ID: <2026101652-estimator-mutate-98a8@gregkh>
References: <20261016032732.2328852-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016032732.2328852-1-zhanxusheng@xiaomi.com>

On Fri, Oct 16, 2026 at 11:27:32AM +0800, Zhan Xusheng wrote:
> sysrq_parse_reset_sequence() rebuilds a device's view of the reset
> sequence, but only clears reset_seq_cnt.  reset_keybit is only ever
> __set_bit() and reset_seq_len is only ever incremented, and nothing else
> in the file clears either.  The struct sysrq_state holding them is
> allocated once per input device in sysrq_connect() and lives until the
> device goes away, so both accumulate across calls.
> 
> The function is called from sysrq_filter() whenever
> sysrq_reset_seq_version has moved on, which happens when the reset_seq
> module parameter is written.  It is mode 0644, so this is reachable at
> runtime:
> 
>   # echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq
>   # echo 59,60     > /sys/module/sysrq/parameters/reset_seq
> 
> After the second write reset_seq_len is 5 rather than 2, and
> reset_keybit has five keys set rather than two.  The trigger in
> sysrq_detect_reset_sequence() is
> 
> 	if (++state->reset_seq_cnt == state->reset_seq_len &&
> 	    !state->reset_canceled)
> 
> and reset_seq_cnt cannot exceed the number of keys actually in the
> sequence, so holding the whole new sequence no longer resets the machine.
> The stale bits also make keys that were dropped from the sequence still
> test positive, so pressing one takes the increment path instead of
> cancelling, and releasing one decrements reset_seq_cnt, which can take it
> negative.
> 
> The boot path is not affected: both the command line and
> sysrq_of_get_keyreset_config() leave sysrq_reset_seq_version at its
> initial 1, so a freshly kzalloc'd state parses exactly once with both
> fields already zero.
> 
> Clear them along with reset_seq_cnt.
> 
> Note the error direction is towards not resetting, as reset_seq_len only
> grows, so this costs an emergency reset on systems that reconfigure the
> sequence rather than causing an unwanted one.
> 
> Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  drivers/tty/sysrq.c | 2 ++
>  1 file changed, 2 insertions(+)

Why is a tty patch prefix "Input:"?

thanks,

greg k-h
