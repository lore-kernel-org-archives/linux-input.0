Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410E2F0C62;
	Fri, 11 Sep 2026 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106169; cv=none; b=mvDtYvMkgFdz47abrvjH+fNzipKgTChB6GIOj86f4Cd6dhz56mgrQNoTiYaD/jj+gsMFedzj8s39gw3k40wxUdhaCcqNLXjRL3uBjvIt2caSZp+fyEpGYYrnQwGqFoKntaf7e8hVl4E3neFmr+aLakflYgRWzEARdEIp7MlN5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106169; c=relaxed/simple;
	bh=fRjkz3VzyhlKA5dd0Or//wRGErJaECSJgUogOU2BLdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWk76nIOxHV4pWBHfltC+gkKltowRvEOqcDwhQAOFknnCR82pDLoaxFHexWuWBABoiyyBRMHBpQueMt6aALCwnxxoimOovOLC/BPsz9FIk7FhWo2zbmIPIK43BMfVTWMBcOw6Iv7SDaExIF3iFAGPvwyHNoNB+TTrrT//p10j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbc5BWzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbc5BWzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0371F00893;
	Fri, 11 Sep 2026 05:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789106167;
	bh=C96TeqNXybbYRYTn+F4XCBfajRcSXfI48B2FYhGoXt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jbc5BWzP0tP0p8Q6sLAH5jSdNbwfhYR0NMf0K7UG2Mnoc0fkCCFdnQjCPPtXVSRpz
	 62/QenGQjdpxZiapH+nw5md05RtpIew+3jOY/KGbb+UR4PmpLql15cN/OUzr+dIGDq
	 D88sV2b5FJE5GqbP5vqtL/ORrRZZEVnNmnIHW3co=
Date: Fri, 11 Sep 2026 07:54:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	Curtis Vogt <curtis.vogt@gmail.com>
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <2026091133-silliness-recollect-e190@gregkh>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910170254.833871-3-mario.limonciello@amd.com>

On Thu, Sep 10, 2026 at 12:02:53PM -0500, Mario Limonciello wrote:
> The Valve Index HMD stops serving its EDID after the host disables the
> DisplayPort PHY.  The headset remains powered by its breakout box across
> suspend and shutdown, so the bad state survives and the next connector
> detection reports "No EDID read".  The HMD then appears as a synthesized
> 640x480 display until it is power-cycled.
> 
> The 64-byte HID output report 0x16 with command 0x01 reboots the headset
> and restores its EDID service.  Add a device-specific driver which sends
> this report for system sleep transitions and orderly shutdown while leaving
> runtime autosuspend alone.
> 
> Resume a runtime-suspended interface for a shutdown request and restrict
> the command to the composite interface which declares report 0x16.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4333
> Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939
> Assisted-by: LLM
> Co-developed-by: Curtis Vogt <curtis.vogt@gmail.com>
> Signed-off-by: Curtis Vogt <curtis.vogt@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../ABI/testing/sysfs-driver-hid-valve-index  |  12 ++
>  drivers/hid/Kconfig                           |  11 ++
>  drivers/hid/Makefile                          |   1 +
>  drivers/hid/hid-ids.h                         |   1 +
>  drivers/hid/hid-valve-index.c                 | 142 ++++++++++++++++++
>  5 files changed, 167 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-valve-index
>  create mode 100644 drivers/hid/hid-valve-index.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-valve-index b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
> new file mode 100644
> index 0000000000000..47d8c26b1eace
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
> @@ -0,0 +1,12 @@
> +What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/reboot
> +Date:		October 2026
> +Contact:	linux-input@vger.kernel.org
> +Description:
> +		Writing a boolean true value reboots the Valve Index headset to
> +		recover its EDID service. Writing a boolean false value has no
> +		effect. This file is write-only.

Shouldn't this just be a debugfs file?  Making it a sysfs file seems
"risky" as it's not a normal operation.

> +		The Valve Index is a composite HID device. The reboot command is
> +		only supported by the interface that provides the headset's 64-byte
> +		output report. Writing true to this file on another interface fails
> +		with -ENODEV.

Why would it be present on "another interface'?  That feels wrong.

thanks,

greg k-h
