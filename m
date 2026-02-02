Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F32E645;
	Mon,  2 Feb 2026 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065463; cv=none; b=mCmIpBdhgQiGII1XpbDpTNPdQbbfthBmlJ1dOcHABBRmK96bKFJ7vBhucch6NIrPPBfospsxffd56ITw/K+UqSM9g0EBQiVrgZKt0tGs6/fXhkcslLt9n3m/nFTIt2qCYlg17gnDLsTsZCtJBVRvT/gxwJMd1R7yGrHkBfVncEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065463; c=relaxed/simple;
	bh=8mr+h0FkFQsUZr1MgdRFNOHGr2hkKdoBYRIKziBbqvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I+ONzkLHsSKuNSuSvktVx/hvamaAipvz73FaC+nXFu7kdxAT3dKxqLxQVR0KWcm96T5btZZtr9QdrQEeLmLHVhrDpcodTLjVzhk8yVRRqucwrkhUgdZqFdolK/gf4t/5w0wU2NAQLe0Fx9riWyxt2/FawztG2fpQsGnVgg1dRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWNNFhAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWNNFhAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF7CC116C6;
	Mon,  2 Feb 2026 20:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065462;
	bh=8mr+h0FkFQsUZr1MgdRFNOHGr2hkKdoBYRIKziBbqvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZWNNFhARpvPZYzQ+OaNaaM2B5pGAOB3k8yxbe3HumtU+JqFpQhd9JG9QtElIu5wjO
	 quwa6gJOWAJBqGzxhkCknfMXSVEd4xJppuE7qe+2K1sYWl9MIBY+a6lKB7LPgNhuq+
	 R/omZWjGX9J8GaxN95enVMagC3hOpqsJ35c/wRLR1iVZWWbLfbE85yE+wCBtOFLaak
	 XyaX8zhyTvAeShW9rU/GCr2JRjvWCBxS1msq1uSl70t+5l6R6Rrg40QCCRtKbFQWgE
	 xrdykCTWIt0buak2rHFgAx+nJBICMPMKFCuxNXCWwcOcpZRHHBZJ4N9DGBSxDsNgiJ
	 wxiCIQekUOMkQ==
Date: Mon, 2 Feb 2026 21:51:00 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sahil Chandna <chandna.sahil@gmail.com>
cc: bentiss@kernel.org, connorbelli2003@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: asus: Add check for cancelling fn_lock_sync_work
In-Reply-To: <20260130155204.96831-1-chandna.sahil@gmail.com>
Message-ID: <0r86s1os-1ps3-5532-s454-25ros9q18nop@xreary.bet>
References: <20260130155204.96831-1-chandna.sahil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 30 Jan 2026, Sahil Chandna wrote:

> syzbot reported a workqueue warning where fn_lock_sync_work is cancelled
> during device removal before the work has been initialized. This can
> happen when the device is disconnected while initialization is still
> in progress.
> Fix this by initializing fn_lock_sync_work before marking fn_lock as
> enabled, and by using fn_lock as a flag in the remove path. This
> ensures cancel_work_sync() is only called for initialized work.
> 
> Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
> Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
> Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>

Applied to hid.git#for-6.20/asus, thanks.

-- 
Jiri Kosina
SUSE Labs

