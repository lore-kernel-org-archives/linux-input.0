Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4F346E71;
	Thu,  9 Apr 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755620; cv=none; b=grvVD0mDveiOWCVfs3YNR63Chdg/d3pLdRnmUscQ8NMJPQ+pqVbzVjrKixGE2qNwogAyFKDbVw929IBqrVK9es1C7gLm73tpf8VbEoEpUieI3CD7xnP15n9bz/VRbn16xW2m3XbLFOyZCEXtVGu1uciAKtZnj2JLQ/wRx7GqGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755620; c=relaxed/simple;
	bh=wEW1bi7T5AzLSLq7H+BXTkNyynqCVo8raQv8kwI4QKI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IVgh7fzStsprkXqZNvweViahCW2/EH9J0gm3XXNjkxRgTp6w2IIG0OR+vnCHCPAk9o+JISNm3UcprgwTamGxDCdOn8BS+7CBwffhsn6/bABVTTom4oBcAubdwaWNSx9x7XiXytAPddWB1H+94IBTwWVeBzQUx+C1/z+AhvJmULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjo0bnla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjo0bnla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ABEC4CEF7;
	Thu,  9 Apr 2026 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775755619;
	bh=wEW1bi7T5AzLSLq7H+BXTkNyynqCVo8raQv8kwI4QKI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Yjo0bnlaHHtbyOicIqhXGVOX0jLumKQVkEB3CpdnkaoTsuTc1jnAy1LLa6uKNn51B
	 i812bJ6FtHwbZS2hWpiNTdLP9af83PSVZuiPv2w6eTwh5Fa5ONx3A6W0VuV/05ckup
	 VOMkEkaayk53VSY65zcGLEIcrd6qBLMI0iRL2wDaW3/S5AdDh3otXQKd4I0027nvxN
	 e/8b6yMlfZlXRicbcKPL/CH1/9mcyQvZrFIuOEWShCD6OYSIxsjLd2tqLAbVQkKLBv
	 QA3Q20KDTayVACRWQKWashAvTZQg4aDy3oS22M4T407Ka6QVhBAsbTjOUVJU+/hNF/
	 Oh3iZMvhQbeJQ==
Date: Thu, 9 Apr 2026 19:26:57 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benoit Sevens <bsevens@google.com>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: fix race condition when accessing
 stale stack pointer
In-Reply-To: <20260401144811.1242722-1-bsevens@google.com>
Message-ID: <81n26386-p78s-5rqq-5s7o-p8s01sr95q74@xreary.bet>
References: <20260401144811.1242722-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Apr 2026, Benoit Sevens wrote:

> From: Beno=C3=AEt Sevens <bsevens@google.com>
> 
> The driver uses hidpp->send_receive_buf to point to a stack-allocated
> buffer in the synchronous command path (__do_hidpp_send_message_sync).
> However, this pointer is not cleared when the function returns.
> 
> If an event is processed (e.g. by a different thread) while the
> send_mutex is held by a new command, but before that command has
> updated send_receive_buf, the handler (hidpp_raw_hidpp_event) will
> observe that the mutex is locked and dereference the stale pointer.
> 
> This results in an out-of-bounds access on a different thread's kernel
> stack (or a NULL pointer dereference on the very first command).
> 
> Fix this by:
> 1. Clearing hidpp->send_receive_buf to NULL before releasing the mutex
>    in the synchronous command path.
> 2. Moving the assignment of the local 'question' and 'answer' pointers
>    inside the mutex_is_locked() block in the handler, and adding
>    a NULL check before dereferencing.

Now applied.

Benjamin had some ideas on further cleanup (allocating with __free__ 
instead of using stack pointer), but that'd be a little bigger cleanup, so 
let's keep that separate.

Thanks,

-- 
Jiri Kosina
SUSE Labs

