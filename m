Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3146C827;
	Fri, 16 Oct 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144990; cv=none; b=h25bJxNZe6MntSGecxNeUhfNiaADHD3UjX21mzmu2o9GUAPkCnoUVNrN0E5EY+SBONuo8VzZ8OxAKjuBbYyaxeWTpX8SVwdMfnY7njmI/d4eR4VaTQKvGGQXUpM6LmDLIVHkv/M5U6K9VN5OtcL4oxcQqHrGTxq70cibUVOTD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144990; c=relaxed/simple;
	bh=Q6ydQmtKfJsoMbn5TcHsdEZETrS8jWuBpfXnq7HX4mw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A8zbtFHxNcxUTzVBfCNtvU1Ho9O7I/4GVLEohlQAxQrm9qHuWTJKz8GZrCjust0/oC4HNs7A2WLjIP7IotUTECfOixiw76tNO7SjmuhF4CWeME/uqG7kJP9E9UkSRbiILilYYnuAOWMNikb/RslZc+XGkS2oSBNjBPpywVs+zJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3ndWThD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3ndWThD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EC51F000C4;
	Fri, 16 Oct 2026 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144989;
	bh=U86KGK8O8GV1yxkzk1W4ty2PYP2Kgos6r/hhIa+PMVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=A3ndWThDLdscEyARtqNBwm9NLuBMk0emL+ZcHLmIpKnrwOxQAyKtrtotIuJZZrQZ/
	 IO50OZQH0myTBQHrCBvoraWetdzFlSTXU8NMNQ6X7x/BMz7+ykI7LOx3uZpTiSmvg2
	 N8yOoxRBi+8P6fmXomWKJJRNOFILAIbeJEkwictWg+/AR1r0Iocu3qjtkECiRgylAG
	 b3/tTmTW4Mv/JAu5CuG6VBpvpB8yAL+31ovr9Kan61VGBsMkOnS2U1XDGS2rUgK0Mp
	 LdGUK3cU8EA2QjzUMxrN9zSXmmyiOW2Lxe7ZN7K1Lp9qm9atkmdOYrbw4dgqHlZ1Mw
	 iHMLZ2+U6ga8g==
Date: Fri, 16 Oct 2026 12:03:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel@lists.opengamingcollective.org
Subject: Re: [PATCH 00/10] HID: hid-lenovo-go-s: Fix various bugs
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Message-ID: <7s882475-7947-nsq0-60s9-9s52981s18p3@xreary.bet>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Sep 2026, Derek J. Clark wrote:

> This series fixes various bugs in the hid-lenovo-go-s driver
> 
> Patch 1 fixes a dropped error on return from mcu_property_out()
> 
> Patch 2 creates a mechanism to ignore stale responses if they timed out
> in the previous command.
> 
> Patch 3 fixes a deadlock if the device is removed while cfg_setup() is
> running.
> 
> Patch 4 adds missing pm_ptr to the reset_resume function pointer.
> 
> Patch 5 adds a kobject_uevent notify during reset-resume to ensure the
> os_mode return is caught by udev.
> 
> Patch 6 adds a suspend callback to cancel delayed work and re-queue the
> cfg_setup if the device was suspended prior to or during the work.
> 
> Patch 7 moves attribute init to the end of cfg_setup, ensuring the
> attributes can only be used once the MCU is ready.
> 
> Patch 8 reorganizes hid_gos_cfg and renamed it to gos_cfg_drvdata in
> preparation for later fixes.
> 
> Patch 9 moves the static led_classdev to become a member of the drvdata
> struct.
> 
> Patch 10 moved drvdata from a static global to a device allocated
> struct.

Given where we currently are in the development process, I've queued the 
whole lot in hid.git#for-7.4/lenovo, thanks.

-- 
Jiri Kosina
SUSE Labs

