Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AF387375;
	Fri, 16 Oct 2026 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129067; cv=none; b=JpBPUQMhPcxZlc9qkE+NiCa7v/AKJSDCVFnF0D/RzDzBTbQGxnGGPMfZHrGrtJGXFXRDHN7USG9EAFLPGAPytZqx+bpDAzq+6NFGWzZfGijElQQzFUIALBbLg+UMdR+qU8pgPl71cYWDkX9LRtIeQw+BDna/CID3dBsGOSKT17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129067; c=relaxed/simple;
	bh=vJfTgfPUfhn8fHCYl0wfzB88SMobhW5sO3haKTJGQMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTaTVF76NytCdg6h3L8eIcJjWhf4rfrXt9Kg2IchrEqwRNfAtfl1KJqr1ilKxozH54qj06m9X3yHNSrvB2aMwqPmGIwlWsXhdfCF3k3gONxfDlKTmBDRdLUVmRBu9U1jYlTmpeJZE76uKXbIaui3ySSYMBx2qpw6dxjlbhCpXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIp3g2ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIp3g2ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245B31F000C4;
	Fri, 16 Oct 2026 05:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792129065;
	bh=RUD8aFqIEpAPhBkdxouZRQic4xT7I2diCYNJNCGNZr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GIp3g2aowY10XC79he7edSoanj1+/KDRy841XK/87fBDTxeOJuQ3tdwbfPckgGQNx
	 yEllr9Kyzsxl/cLjYmCuRlcglqVOgATYjjE1sCL/OvfhDuom3XP9GwJdXms9o+DAsK
	 Y2IpqSJeM9hLSn2DoAFGCRKWO/VYWghmgLXlwQ3Y=
Date: Fri, 16 Oct 2026 07:37:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH] Input: sysrq - reset the per-device key state when
 reparsing reset_seq
Message-ID: <2026101624-dealmaker-camera-094e@gregkh>
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

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
