Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A04334B9;
	Fri, 16 Oct 2026 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144861; cv=none; b=X9EpVfEjbcnQQsRBD8nnRNYNUdm+cnaBafQcVaGtPSHqCCt7745fEJx7bUL+hyB9ts3iCvqiR4gcyTXmPtUtv0GkqYTzhLbJNca+3m0kJLSDlBM+yAddG6c3m7GI3XXqRPiKKKnyBABRYiyIZzmoQWT1XxMFNGuAm3Va4yJYX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144861; c=relaxed/simple;
	bh=eISXx7zCyrohEsyK6Hlf8B6S8NoowomYuIauzCxBSDY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uvqipQH9SaBdhJbzxxT78MmStHT01DrQnSXULCAYnDiYQyE3zKKL0b7x8DaZsSm28w+cnBWcbQ7usHEr2BxFUuj+fV1D6A5XmJGnuGQSWwCaL71kXoqE3A9fMfsAKSGRDWid+lwOqT+RiC5PLBR8y0/Jxs5b0zMcZomn2IelK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wsea2xD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wsea2xD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1121F000C4;
	Fri, 16 Oct 2026 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144859;
	bh=5QYLOI476TfeUSAcrrrKaFdTtj6vSeRHwK1hXUdfqIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Wsea2xD9I30t3iZ4BiZwS7tdnsKMUv7gEWwyxAaQySsnWdhb4NBAdS4lDn9bfCcwp
	 ik0o9r2zQOYUnNFN+/Kcv84VGZggRooWcK3cN4lZohWxWm3/Ul+o76Gm4ZkWsO9fAY
	 fmzpj+vXzILGBUSwuxbPOr4DEiYD6DHFOwtdLVWSky8XN8PbWTQskZuEZ6Mg4du8BB
	 OtLenAzUzcuuqU+1xg4QF/q5+ZjTHAQvNGy3083ANPOeTDbJp/Wirmk6gtuBq7FzD/
	 ZAFDGjGshkS/HxJ0lqfAxTq3AdIrJcotHe2vSIjDzAVAy6IelH3C5pVKcqp4pL+VOK
	 uVhCGduDxHLlw==
Date: Fri, 16 Oct 2026 12:00:57 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitriy Geels <dmitriy.geels@gmail.com>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on probe
 failure
In-Reply-To: <20260824173718.14687-1-dmitriy.geels@gmail.com>
Message-ID: <5440o3nq-rp31-6820-4466-s60s78q856o0@xreary.bet>
References: <20260824173718.14687-1-dmitriy.geels@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Aug 2026, Dmitriy Geels wrote:

> The probe error path cancels hidpp->work before freeing the HID++ device
> data, but does not cancel reset_hi_res_work.
> 
> reset_hi_res_work can be scheduled while probing the device. If probe
> subsequently fails, the work can run after the driver data has been
> freed.
> 
> Cancel reset_hi_res_work in the probe error path to prevent a potential
> use-after-free.
> 
> Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
> 
> Signed-off-by: Dmitriy Geels <dmitriy.geels@gmail.com>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

