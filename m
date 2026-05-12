Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BC3E173D
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602278; cv=none; b=t0HQQZ6NhWfiG64ZRSiE+fp14o68F5FMojUf9gnTwTD/17hrf+hIp8e63L8mMshiIGTRU0jQO7yyCbjuKOGWPZZ4cCSRYkP/hrntbOgo72qeMW+NrvhCaGKc4j92xAQN6avHcusZthmNu71rPJKgORGk1GX6u1ui8iJUpwK7CS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602278; c=relaxed/simple;
	bh=m+XUhF9ImE1CK41jsOALq398PiGPCjSKHydFQCTMGbY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kyg9m6vzSdfq0IVjAJ7L6iBI6+JE/WCGqsqcRtPwAZbq3oPIpqtJRt+gtfb0AREbF1x94f0594hD8ap5LTK9igqpyPwJwfN1eb+0GKk4I/DfP06bwiT6/GkQH7nF8Mp/btEARyV2+HCGQWBTED8bAMPOVa5+u9CeHE1TW/glnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m42rybxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m42rybxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E83C2BCC7;
	Tue, 12 May 2026 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602278;
	bh=m+XUhF9ImE1CK41jsOALq398PiGPCjSKHydFQCTMGbY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=m42rybxjvTf6+LeMP8wptj4ftId72tJsrOtEgejwtOxYbF2YO3ejr9A0KyUjZ+tS2
	 GlHPi3FqW8xBpBBlMUMQJ4tUMbkHCo647OC4dJdJCubzjSPpgenSY5jGjR1RTOUmRC
	 6Lz2NKjNHD9UcKXxA2tpPoFSug9AFb8myTgRS3jQH6vBGamII7QM1F+/XR+eoKjo7x
	 8uG6tpEDmNZCOceTmzqSHiXazjZfZnBpP2fvJWhHSe1tgLVr4wVfPBV4fHukjQMvZf
	 kvfFcHBiojTSa69wNOT1JxMe4KkFHPIBFodUt3edz+dat12/KDwCVf+yanevQbpRcM
	 Ro92I+d0RUWlw==
Date: Tue, 12 May 2026 18:11:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Harald Judt <h.judt@gmx.at>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND 2] HID: Add force feedback support for Speedlink
 Cougar Vibration Flightstick
In-Reply-To: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
Message-ID: <1q46pn22-177p-9no9-q4p7-4qq8n38po504@xreary.bet>
References: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 May 2026, Harald Judt wrote:

> Hi,
> 
> I have implemented force feedback/rumble support for the Speedlink
> Cougar Vibration Flightstick joystick. While I am not quite sure about
> the correctness of my approach regarding the strong and weak motors, it
> seems to work as expected; I ran the fftest samples and also tested it
> successfully with SuperTuxKart.
> 
> Here is the code, hopefully I have set up thunderbird mail correctly to
> not mangle the patch...
> 
> 
> From 48d8512fbe49ae7b940dc5869fe50aa905d3d5fb Mon Sep 17 00:00:00 2001
> From: Harald Judt <h.judt@gmx.at>
> Date: Sun, 18 Jan 2026 02:47:20 +0100
> Subject: [PATCH] HID: Add force feedback support for Gembird based joystick
> 
> This commit adds force feedback support for a Gembird based joystick, namely
> the SpeedLink Cougar Vibration Flightstick (SL-6630), which sports vibration
> motors for rumble effects. Though it is not easy to determine, it seems to have
> one motor in the base and the other in the stick, both are of equal
> strength. The implementation tries to take this into account for realising weak
> and strong rumble effects and has been tested using fftest and SuperTuxKart.
> 
> Signed-off-by: Harald Judt <h.judt@gmx.at>
> ---
>  drivers/hid/Kconfig           |   8 ++
>  drivers/hid/Makefile          |   1 +
>  drivers/hid/hid-gembird-joy.c | 178 ++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h         |   3 +
>  drivers/hid/hid-quirks.c      |   3 +
>  5 files changed, 193 insertions(+)
>  create mode 100644 drivers/hid/hid-gembird-joy.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 04420a713be0..b4e2c8f67728 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -406,6 +406,14 @@ config HID_GEMBIRD
>  	help
>  	Support for Gembird JPD-DualForce 2.
>  
> +config HID_GEMBIRD_JOY_FF
> +	tristate "Gembird Joysticks force feedback support"
> +	depends on USB_HID
> +	select INPUT_FF_MEMLESS
> +	help
> +	Force feedback support for Gembird (Vendor ID 0x12bd) based devices:
> +	  - Speed Link Cougar Vibration Flightstick (SL-6630)
> +
>  config HID_GFRM
>  	tristate "Google Fiber TV Box remote control support"
>  	help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 361a7daedeb8..593a429661ed 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
>  obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
> +obj-$(CONFIG_HID_GEMBIRD_JOY_FF)	+= hid-gembird-joy.o

Would it be possible to link this support to hid-gembird if enabled?

Thanks,

-- 
Jiri Kosina
SUSE Labs

