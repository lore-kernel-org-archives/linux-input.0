Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340315;
	b=Lk5MpNKmjMAEFDrAEETRkc8a4Mlx6w4NkvR+Qlrn+3Xzr3pLijPVm4r4Gr/sBwmfFVWA
	 CjsR1Ad1zgosZx2mGOqZXRraLrD1XcEOsr7Q04CEF5qDJ7k5TSDM0mcXOG07Dmfltx1ez
	 HMvUFsmEZ97h819KWCUAUG7X1oqIOxN9sN9gyVdlY//+u/B8589PfUsqouiPZUzgZu0My
	 cEx/sAcBr+OVmUEpXR1SsRu+0z3I+/Fy5rPuZ4L+0aN+uS5SV2LUHBOPc3J2RD/eM3S3X
	 J0ofaXsTdyvMXhexNwp0CpWArLyIfpsnOSsrhUyBy785yWcRCOMONxsOhEajRnXcrcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cWTDx/0fA1DyLxt6tNb3fWkwDFuV2YkxAbF9ocfnx0Y=;
	b=l8Q8EozYvTEet0d9foq9QPJtwSEsqx38GZL3JMlzaUSfqVBgsKcjufECfWZ6B2UY3yeh
	 Lb1/q3acKfkss86UnXxsa6l2Ow59G0vaWeVdOlvwCUJR6dEWOrmXPdWBM8s3cCza1Ax7m
	 2OgZ+/fXCD2ZXDar7UtopW95xqvRxBzU4xc6V/gi0x6PV2xca/miozZ1dkdwtmT5yJTrl
	 kNGFe60dPBVUVU//HXdoaWhlU2x0Fpwzd34SOwImGuNmrFejAJE7B4cM/g3941c/9HaUx
	 1YjLsmy669BWFxhbh8JpyPdE8Hzot/Zinrtj67D0N/7+myVAKqiq/vOmc3J0aPHJTkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V1sJGOk7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086C606A31C;
	Fri, 30 Oct 2026 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V1sJGOk7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E281F000C1;
	Fri, 30 Oct 2026 06:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793340315;
	bh=cWTDx/0fA1DyLxt6tNb3fWkwDFuV2YkxAbF9ocfnx0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1sJGOk738cvATYUyDumzmpQl0gGqwUEoZIgWLWoQLBBhWpwD9yej2xooPUTVQ7NW
	 Kf7xTz2VsjXSfj0rVEoyBUKvueRZOvQOttH4pvkB0iL8UyFI/BPlCjwHqpupGEIbUT
	 CqU2w37Fdk3K1ITSOz2jUArKxOvC5+7o0lOzgt3M=
Date: Fri, 30 Oct 2026 07:05:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jirislaby@kernel.org, dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org, linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written
 reset_seq
Message-ID: <2026103031-hungrily-compile-49c8@gregkh>
References: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
 <20261030045854.153556-2-zhanxusheng1024@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030045854.153556-2-zhanxusheng1024@gmail.com>

On Fri, Oct 30, 2026 at 12:58:53PM +0800, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> reset_seq is a module_param_array, so param_array() builds it up one
> element at a time: it resets the element count, then for each element
> calls sysrq_reset_seq_param_set(), which stores the key and bumps
> sysrq_reset_seq_version, and afterwards increments the count.  Every
> intermediate step is a self-consistent sequence carrying a fresh version,
> and sysrq_handle_keypress() reparses as soon as the version moves, so
> writing 56,29,111 publishes a one-key sequence and then a two-key one
> before the intended three-key one.
> 
> A key event that lands on the one-key state gives the device a one-key
> sequence, and because the parse runs before set_bit(code, key_down) the
> count is still 0 and reset_canceled is false.  The same event then reaches
> sysrq_detect_reset_sequence(), where ++reset_seq_cnt matches reset_seq_len
> and sysrq_handle_reset_request() runs; sysrq_reset_downtime_ms defaults to
> 0, so sysrq_do_reset() calls orderly_reboot() straight away.  Writing the
> parameter needs root and the key has to be the first one of the new
> sequence, but an administrator who presses that key while reconfiguring
> the sequence reboots the machine.
> 
> Today this needs a device that has not parsed a sequence yet, because
> reset_seq_len only ever grows.  The next patch resets it on every reparse,
> which without this one would expose every device.
> 
> Parse the whole parameter in one callback and replace the sequence under
> a seqlock.  The reader copies it out under raw_seqcount_try_begin(), as
> it runs from the input event path with interrupts disabled, and keeps
> its current sequence if a writer got in the way.  It is a seqlock rather
> than a bare seqcount because writers were not serialised either:
> sysrq_of_get_keyreset_config() stores the sequence from the kernel.sysrq
> sysctl without the module parameter lock.

I'm sorry, but I can't really parse this llm-generated text.  What is
the bug here.  What is being fixed?  And what is changing?

> Behaviour changes:
>  - A key of 0 is rejected instead of silently ending the sequence there.
>  - A write that fails partway keeps the previous sequence.
>  - An element longer than seven characters, such as a zero-padded hex
>    value, is rejected.

So what workflow hits this and will need to be changed if this patch is
applied?

> Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")

no cc: stable?

And how has no one ever hit this issue in the decades that it has been
present?  Is this really something that needs to be fixed?  If so, why?

thanks,

greg k-h
