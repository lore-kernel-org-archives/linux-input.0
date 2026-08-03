Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EA3A3826
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787030; cv=none; b=iBWgJ2dK1K1n7misfz7hHIvMnuiTOivOC4GzL5gn1y+DMR2qhDSBdE0QPhVNr09bD22tpwvWFqNEzz+D5cZ2joTQSYuwOe2wREFJHK0pS3jqKkCgV1SUXbN/LC8ondugwpfEQYNo6fHjxFWZWVeY8dasK1TTgn+Xn/PklPoeH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787030; c=relaxed/simple;
	bh=x4sNSj7bAzSs4U/3B488i1Dy8cUpEMoMIdKFVJN5L5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HUj/j7X22JGL1kM+fC8dbF5E9ep6aC4fFLx/nFIGYszFtOI+/JW+MXt6gOfJ5m1idup5rTyCsLKydJ7eZCBkdYYnIkgaPcv8POx7cO19yCvk3P/J7gQWldFh9LHrj66gynZWxKKEzTmOI8ReAEM07MZtUyW4aPFUX3LOwE75A+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4hptH59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4hptH59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5501F000E9;
	Mon,  3 Aug 2026 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787029;
	bh=CFzmKZcULOSOf+wJALrKENCduC9+boLQZK0fYvqxJDo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=N4hptH59H3qoTCGO46TleTbQ7FCgyV6DI7D4OBmV4UQLdCtpvOjKEzLRl+oHbaFKQ
	 GVt38CEhg6EE9/YHWXaPJEhhdoN2JdkZFxRAbqghTYe74iBoFXzgdJ+Hpkpe2942D4
	 0nU40SfVj2Vk2/vCO4HQ9FdXK/hCuMDKMmiILXETn2EjRMezwlRcc+D3uI9i42n5ML
	 LigcjtcKmg+6F6aTN4mYJdIak/9VpPoQBBw8Wx1gL4U57WT/7fLXdz3hlS7V7nh392
	 Bd4yOgdOiEP+Cgj9RRbawBcJlvZdUCPfwErQPAOewjkp6sbA9B0AtDlBWdg2slKePZ
	 BiXCm+7bEBt3w==
Date: Mon, 3 Aug 2026 21:57:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Wahid7852 <wahidzk0091@gmail.com>
cc: linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com, 
    Lixu Zhang <lixu.zhang@intel.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES
 from firmware
In-Reply-To: <20260720175656.559351-1-wahidzk0091@gmail.com>
Message-ID: <5o73858o-6607-p601-7306-911r63nr7948@xreary.bet>
References: <20260627224753.35075-1-wahidzk0091@gmail.com> <20260720175656.559351-1-wahidzk0091@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jul 2026, Wahid7852 wrote:

> From: Wahid Khan <wahidzk0091@gmail.com>
> 
> Some ISH firmware versions (observed on Tiger Lake LP, 8086:a0fc,
> GUID {33AECD58-B679-4E54-9BD9-A04D34F0C226}) periodically re-send an
> unsolicited HOSTIF_DM_ENUM_DEVICES response roughly every 79 seconds.
> 
> The current guard collapses two distinct cases into one condition:
> 
>   if (!(response_flag) || init_done)  ->  bad packet + ish_hw_reset
> 
> This incorrectly treats a valid post-init firmware announcement as a
> corrupted packet, triggering an ISH soft-reset and a full ISHTP
> re-initialisation cycle on each occurrence (~1100 times per day on
> affected hardware).
> 
> Split the check: reject messages with no response flag as before, but
> simply discard valid ENUM_DEVICES messages that arrive after init is
> complete.
> 
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

