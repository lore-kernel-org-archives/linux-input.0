Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93B36A345
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599637; cv=none; b=mObtL19pUZNo+1GDfxL4i+LRKyE7uJw3ZXREU/UfPfVNfKDb5+1GRR4MKZojIktSozbqRet1Lm3BSbOsZkW8vAmUeBmtgppGZNTFhNzDP2MaFwt2szI0EyvNxABcRo49KWim2MBiuMjORsglpIvLf1KDlFHvoPAqM+zeWZ4zhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599637; c=relaxed/simple;
	bh=ESMpgHOLVTfa11US9oHtsMZNl/4T5NjyIcWyyRcgmNA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HQxVvQlIo0r16EkLHTAzDit3SHA/qF+avsMwv/7TE3OLTpmnM9Ch/JXpyhqsPXPjsCL7Vp2bZI3OwP8qzClPLw0KvNf7WuBzJlHheDi8YHXBNJwwW+utGvYZLft7gB2OI1yAZw0OqvBd/sxdov+EiHas9ze1/QZd4Cxubum9bcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUjf6C59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUjf6C59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DFBC2BCB0;
	Tue, 12 May 2026 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599637;
	bh=ESMpgHOLVTfa11US9oHtsMZNl/4T5NjyIcWyyRcgmNA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IUjf6C59nHtZbpCGBnJMfNtOqjKgoFMJOvU0JEg+cKAP8vaJq6V3FK2M3yFNR0Zf+
	 XBfWb73xdbqoUokfFRlbRO0PuuQNBJJE5INoSXysMy2p0BHH5RAHLevJ29pLE4MfpI
	 9G5qhJHJ+jVW5tgVycC6LxMAcqcvMB66t6IROBF3Y0jecH1398Az/xSPMR0BoAWNSH
	 MwtXUW3lSeWSo/++JnnOKDHFb694aRvHhp5M/ybSwTHG432Kq6S49lFnPkMVUN3QZv
	 9Zcer5NoDSf9+3C7V0qI17afpRGB9hYZtXLRnIFhj6g9jKiVBEbcMOejoWfMwMQQQK
	 ucmL1EUOsJ2Ug==
Date: Tue, 12 May 2026 17:27:14 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Andrew Maney <andrewmaney05@gmail.com>
cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com
Subject: Re: [RFC PATCH] HID: iota-ups: add driver for LattePanda IOTA UPS
In-Reply-To: <20260316072034.56694-1-andrewmaney05@gmail.com>
Message-ID: <s1oso970-sn51-p676-6p61-4p2rq4459sso@xreary.bet>
References: <20260316072034.56694-1-andrewmaney05@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Mar 2026, Andrew Maney wrote:

> This driver exposes the DFRobot LattePanda IOTA UPS board as a standard
> power_supply device, allowing desktop environments and power management
> tools such as UPower and systemd-logind to display battery status,
> remaining capacity, and charging status without any special
> configuration. It also enables automatic suspend or shutdown on low
> battery and power profile configuration via any tool that supports the
> standard power_supply interface.
> 
> The UPS presents itself as an Arduino Leonardo HID device running custom
> firmware (VID 0x2341, PID 0x8036). It reports status and capacity via
> HID reports 0x07 and 0x0C respectively.
> 
> The charge limit (80% or 100%) is configured via a physical DIP switch
> on the UPS board and cannot be detected automatically. Userspace can
> inform the driver of the configured limit via
> charge_control_end_threshold.
> 
> Known issue: the driver occasionally reports 0% capacity briefly on
> initial load before the first valid HID report is received. I am
> investigating the cause.
> 
> Signed-off-by: Andrew Maney <andrewmaney05@gmail.com>
> ---
>  iota-ups.c | 355 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 355 insertions(+)
>  create mode 100644 iota-ups.c
> 
> diff --git a/iota-ups.c b/iota-ups.c
> new file mode 100644
> index 0000000..df334b2
> --- /dev/null
> +++ b/iota-ups.c

You seem to have generated this patch in a strange way, so that it can't 
be applied on top of the tree (i.e. in a standard 'patch -p1' way that 
all the tools default to).

Could you please re-generate it properly and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

