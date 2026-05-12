Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B73C2BBE;
	Tue, 12 May 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600252; cv=none; b=MZ1nNFGFYIJKfuQIS8yDuUWZ7GIHdEYvAXWIMd/5YPbrtj3NOYA+qcROMos8asr9KrB551MbYiDFa7Ziun7kBiJ1ViXJq6nV7QUmIKFz6y/IbDww4ictT+MnjJRvUDA6SPkig+37MY7j4AdUE7vKJkn1K53U8lpVpbGa/ogWTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600252; c=relaxed/simple;
	bh=sJMDuzzLYoqXM+0T6NcKRgoYDmeDZK3IRqftiEXZl3Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yb843rZu4ac8PY8YEAJDVBB1W9uy9VFmCuYggUsu3/QZ54XgSNRL/W3yJZXW51fU5NDP7dVJp/2LFc5yNZoFUD/oND7fReF3ITmvqqstik+W1cwgqiUBBt9NphCmSH91S48cao95UjPHN3tSQLaQ011kagOlrrpyvKgVi9hMr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O26xDbQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O26xDbQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45BBC2BCB0;
	Tue, 12 May 2026 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600252;
	bh=sJMDuzzLYoqXM+0T6NcKRgoYDmeDZK3IRqftiEXZl3Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=O26xDbQfsxF4HPiqQuLezwRQxaKZkzuVTrvCCmIgipcTsejSToxIkG0Xv7jVHgwpa
	 QW1khjh7oD5K4+QXgbBs3t3ssrzPnC7vBWUxrimbrFW5xFN8NhsKO2G4ly285e7G5r
	 qdXtpX0mvlBDZ9mCGprGr2h93sYuEd2/8MXRRREC3Z3HKAgbpr6g0/tQfcuJjCjkLI
	 BZFCBZQKq8QfOFgxCao07c0RvDZYCiiUNbhIZKtkniPzo81PfMwA3LPkccR3a/KhB3
	 86xfoIGuiqyAWpCa+ysSObnj/DG8Bw9/BvY8A2hlFqF4e617zVrtyFuDjQEnFZAgpL
	 THvMZCc9OQpVw==
Date: Tue, 12 May 2026 17:37:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Nikolas Koesling <nikolas@koesling.info>
cc: Benjamin Tissoires <bentiss@kernel.org>, Lode Willems <me@lodewillems.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Leo <leo@managarm.org>
Subject: Re: [PATCH v3] HID: pulsar: add driver for Pulsar gaming mice
In-Reply-To: <20260412075346.100567-1-nikolas@koesling.info>
Message-ID: <srr004n9-3519-sn47-331r-40rorn3s81n1@xreary.bet>
References: <20260412075346.100567-1-nikolas@koesling.info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 12 Apr 2026, Nikolas Koesling wrote:

> Add a HID driver for Pulsar wireless gaming mice (X2 V2, X2H, X2A,
> Xlite V3). The driver exposes battery level, voltage, and charging
> status through the power supply framework. It supports wired, 1kHz,
> and 4kHz wireless dongle connections.
> 
> The driver also supports Kysona M600 ATK, VXE R1 SE+ and
> VXE Dragonfly R1 Pro, which use the same protocol for reading
> battery status and availability.
> 
> The protocol used by this driver is based on findings from
> python-pulsar-mouse-tool by Andrew Rabert (MIT License):
> https://github.com/andrewrabert/python-pulsar-mouse-tool
> 
> ATK vendor and device IDs were provided by Leo <leo@managarm.org>.
> VXE and Kysona vendor and device IDS are from hid-kysona.c by
>         Lode Willems <me@lodewillems.com>
> 
> Tested-by: Leo <leo@managarm.org>
> Signed-off-by: Nikolas Koesling <nikolas@koesling.info>
> ---
> Changes in v2:
> - Add support for Kysona M600, ATK VXE R1 SE+, and VXE Dragonfly R1 Pro
> - Add device type enum to distinguish vendors and generate proper
>   battery names per vendor/model
> - Add mutual exclusion with HID_KYSONA in Kconfig
> - Add ATK and VXE vendor/device IDs to hid-ids.h
> - Refactor model name generation: extract model_pulsar() and add
>   model_atk() for vendor-specific battery naming
> - Fall back to hdev->name for battery model when device info read
>   fails on non-Pulsar devices (downgrade error to debug log)
> - Remove POWER_SUPPLY_PROP_MANUFACTURER property
> - Pass device type via driver_data in hid_device_id table
> 
> Changes in v3:
> - Increase size of battery model name to hid device name size
> ---
>  MAINTAINERS              |   6 +
>  drivers/hid/Kconfig      |  15 +
>  drivers/hid/Makefile     |   1 +
>  drivers/hid/hid-ids.h    |  15 +
>  drivers/hid/hid-pulsar.c | 754 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 791 insertions(+)
>  create mode 100644 drivers/hid/hid-pulsar.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..207216632918 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11352,6 +11352,12 @@ L:	linux-input@vger.kernel.org
>  S:	Supported
>  F:	drivers/hid/hid-playstation.c
>  
> +HID PULSAR DRIVER
> +M:	Nikolas Koesling <nikolas@koesling.info>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hid/hid-pulsar.c
> +
>  HID SENSOR HUB DRIVERS
>  M:	Jiri Kosina <jikos@kernel.org>
>  M:	Jonathan Cameron <jic23@kernel.org>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c1d9f7c6a5f2..333d165554ee 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -511,12 +511,15 @@ config HID_KYE
>  config HID_KYSONA
>  	tristate "Kysona devices"
>  	depends on USB_HID
> +	depends on !HID_PULSAR
>  	help
>  	Support for Kysona mice.
>  
>  	Say Y here if you have a Kysona M600 mouse
>  	and want to be able to read its battery capacity.
>  
> +	Note: The Kysona M600 is also supported by HID_PULSAR.
> +

I guess that we want to just ditch that driver altogether then?

Thanks,

-- 
Jiri Kosina
SUSE Labs

