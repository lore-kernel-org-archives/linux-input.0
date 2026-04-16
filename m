Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10086331
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350682; cv=none; b=G2Qf99bNoLvY7EuQQws/vofHYUG+kFeJEJuS427czVPUlyfQoPRnr0VEgwYy6nS47TZzQleOX+ZY2JLBrcgHMU/y4USIdbalOrQUtCA5urWv5EP4H+nw6TAbKGex/UOb5xY6zAXhWbxJsk/O0zmxVEGdkSPdmYQjKtxkMhCi/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350682; c=relaxed/simple;
	bh=UlT7SyCAZa0xk9IBX1nfaIB8wKoa/nbBGEueWz+FdcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBt0b1sEOvGU8COrYyLCDwRButxKynMYOPNTdU0qpwLWj3zhxy4lAzvun4PRjpO/30xs+UuF0SXnD6vrMWo4y0HNUd1xzFTE3/oxrNqXmeNYUwUdFmNsnfxARKyDeZbAmdDz5xcC5NIyprVbq7YiKBoVLJ9ZaVM7YZPlBWm24S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAxqDAZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAxqDAZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21B4C2BCAF;
	Thu, 16 Apr 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776350682;
	bh=UlT7SyCAZa0xk9IBX1nfaIB8wKoa/nbBGEueWz+FdcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAxqDAZCuRZqk+KD6dL6BYCZq4IUIUbf6as8UTrjL7c+H9vg7/jItJ0rt5TMQ53Bh
	 Yj4YRFvE5fabP28kdhvUVzJuYChMy1SYcGq7M5/Zj0AyUUsZVRNrXyjsMfMOcVW8F3
	 B4bnvkPedR3kMUlrbrtwrvioFqGybLEup7v+flp0o1BGE5tdKEf5WjIAAwDVk4hks3
	 fxhsIXVLwtzy/OCl+InDlrOhQyp00ISmLfHMrTBl6F5c57h7FRw7zlTAA8jYAC40YG
	 USTqj0GcIV/H656bgxzDCldgWvxRCrYjAXS0OOnywvUvYGyOtZjZHGL8FKppBdkpqo
	 SSv9m3XRGdYwg==
Date: Thu, 16 Apr 2026 15:44:36 +0100
From: Lee Jones <lee@kernel.org>
To: Anj Duvnjak <avian@extremenerds.net>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
	jikos@kernel.org, Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v2] HID: core: downgrade short report warning to debug
 level
Message-ID: <20260416144436.GB10076@google.com>
References: <20260414230017.30217-1-avian@extremenerds.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414230017.30217-1-avian@extremenerds.net>

On Wed, 15 Apr 2026, Anj Duvnjak wrote:

> Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus
> memset()") replaced the silent memset() with hid_warn_ratelimited(), which
> causes dmesg flooding on devices that legitimately send short reports,
> such as the APC UPS (051D:0002).
> 
> Downgrade to hid_dbg_ratelimited() to restore the previous behaviour of
> only reporting under HID_DEBUG, while preserving the security fix of
> removing the bogus memset() and keeping rate limiting in place.
> 
> Fixes: 0a3fe972a7cb14 ("HID: core: Mitigate potential OOB by removing bogus memset()")
> Reported-by: Anj Duvnjak <avian@extremenerds.net>

That's weird.  You reported it to yourself?

> Link: https://lore.kernel.org/linux-input/MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Link: https://lore.kernel.org/linux-input/6256259.lOV4Wx5bFT@natalenko.name/
> Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
> ---
>  drivers/hid/hid-core.c | 4 ++--

Anyway, thanks for your efforts, but this fix appears to be superseded by:

https://lore.kernel.org/all/20260415-wip-fix-core-v1-1-ed3c4c823175@kernel.org/

-- 
Lee Jones [李琼斯]
