Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844023D890C;
	Mon, 30 Mar 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880522; cv=none; b=nSYW8Cw1BxeExz9N3npcBfQsK9MC3CgepU2fQ2pWHHvO1HP/XhYfldwrHqRF9xEakdzGp8oai/Ved0Cr0YFLXxYWuw442uWNWf/6/Zyu4TAfAmbrxDG6CWkXTNRhgTk1trYrXgjqqhUbKpycY9skIYPspwpY/GAigr/uQT7uGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880522; c=relaxed/simple;
	bh=Ic1RGzhhSbQ+YrDsDkpkls2djTt4iLSTo2bi6782Umc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=keMW00EPNuUfwRkcrFsNa/TiNM5w0zK3MBV7iov6Vab2NYbZ9RrU6syFMR9IAkn5sohoG++451E+/l2yRTUSpWp7CbBUi4BrChAKC0puoqk+PxOrmWt0SNWuuDyzPoRJ27QDS4MTU2YjsM+reHE40SIipcwpuV6vtZ8hm69+VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELTT1yun; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELTT1yun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04580C4CEF7;
	Mon, 30 Mar 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880522;
	bh=Ic1RGzhhSbQ+YrDsDkpkls2djTt4iLSTo2bi6782Umc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ELTT1yun+1gKgYpYMGSXAuKb9FTiGOXgUHke/3XCEZBU1NgIdFAsdTUrlpBYuYZiI
	 uSeP15D5VW6zsjRF6w8KHjq0AnPu51f+qxN+1+zSq6Mw04WOVmlVLTGf+YjyphhD47
	 TpEi6warlaZMCjtKNuxYnlxVCUgDyvtoGKikEGt7s9lWdXtM0ssmym/v0dD+mHTTzr
	 hW7WWDR5byoVIvSzKTFeqOynO1/zQLXsFwb9RQPPeXIpjCii1KK+bTCUMfdStpUvQ4
	 BPqCTrel8ekEUxqSk20fRlrgu6H3XzSeyPSbnob6xh+1Ud8xPvuSZEfBwvgl7gEchu
	 RSRVXFdRL52Eg==
Date: Mon, 30 Mar 2026 16:21:59 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: honjow <honjow311@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, denis.benato@linux.dev, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: gpd: fix report descriptor on GPD Win handheld
 (2f24:0137)
In-Reply-To: <20260324013847.68024-1-honjow311@gmail.com>
Message-ID: <4666no95-0r6o-q7rs-os15-0n8s85p41021@xreary.bet>
References: <20260324013847.68024-1-honjow311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, honjow wrote:

> The OEM USB HID interface found on GPD Win handhelds (VID 2f24, registered
> to ShenZhen HuiJiaZhi / GameSir, PID 0137) declares 63-byte Input and
> Feature reports for Report ID 1, but the firmware only transfers 11 data
> bytes per interrupt.
> 
> Since commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()"), the HID core rejects undersized reports instead of zero-
> padding them. This breaks the device entirely on kernels >= v7.0-rc5.
> 
> Fix it by patching the report descriptor in report_fixup(), reducing
> Report Count from 63 to 11 for both Input and Feature.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221271
> Signed-off-by: honjow <honjow311@gmail.com>

I have added Fixes: tag and applied to hid.git#for-7.0/upstream-fixes, 
thanks.

-- 
Jiri Kosina
SUSE Labs

