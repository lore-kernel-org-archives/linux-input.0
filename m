Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07F38C2C4;
	Fri, 27 Mar 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608906; cv=none; b=SfWp041x18p84ceYsGdjg62FspTihkuc79G6XFrfB5o+q/UKg5S9QUXmCDswdSkK8i+JS0H0kiw5vRlQ2PhVLEzMdHnyXOyHIygDz4DmphSz6kKZ/IhWI/J7lE6MZW/Bd8Aw62c85Go9+unf1h365eaJF8WgTklStHxtd0xwLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608906; c=relaxed/simple;
	bh=k+e3h2eRiDAKVGO/Bw3nDX1vP6ZATXcfAVRBF1oCmoY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CSKoMZs221k5vG7oeWAN3cLBBqOlXUwZW5Suw7xDg92oPNPJckEONlM9I0ySQdHIdwaJ7DfHwg231BS0UChW81vEprGk3jGhvEakG/PvanrcTwwBsSD+NRkjBlyQePazMT52BRQ9bdEUXYb1gI0PybzL8JoQ1BFS3klCSM4zSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiZ8kVjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiZ8kVjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3CDC19423;
	Fri, 27 Mar 2026 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608905;
	bh=k+e3h2eRiDAKVGO/Bw3nDX1vP6ZATXcfAVRBF1oCmoY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OiZ8kVjy48o7JQMcxaAUbAAorl52ahX+qLy4FM0ojC0tsMlQKNnQzk37s0Xj4ep4N
	 zF9fktwdWLNW6VOvw+CEhfWhVYA1/mkRZ4AoviodtKuB7WfwCOtdfm79/cerePpwoh
	 2wMqXwJBnNV8qjoKPYjc7PACmgcr0sqHbTMWq0JlO/H8NGBcT03HDMlci0IJeQh1R0
	 ZyZOqIhhvm0J529B26ZQ1gQ+2ZgLljgEnZyFt5qixtJLXatHoAKQCQcotALD6Z5J/3
	 FvByjs3L/mJBfEc7RyQWhnS703n1RJFCKnVyAceNn/F722WUbwSMfqPURw/XeXYSWc
	 pfhpgBjTy8btg==
Date: Fri, 27 Mar 2026 11:55:03 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Ethan Tidmore <ethantidmore06@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
    Aditya Garg <gargaditya08@live.com>, Jonathan Denose <jdenose@google.com>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-lenovo-go: fix LEDS dependencies
In-Reply-To: <20260324192045.2895560-1-arnd@kernel.org>
Message-ID: <5184r5p1-p39s-3r9n-0773-072oo18r41p0@xreary.bet>
References: <20260324192045.2895560-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added hid-lenovo-go and hid-lenovo-go-s drivers attempt to
> 'select LEDS_CLASS', which has a dependency on NEW_LEDS, causing a build
> failure when NEW_LEDS itself it disabled:
> 
> WARNING: unmet direct dependencies detected for LEDS_CLASS
>   Depends on [n]: NEW_LEDS [=n]
>   Selected by [m]:
>   - HID_LENOVO_GO [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
>   - HID_LENOVO_GO_S [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
> 
> WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
>   Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=m]
>   Selected by [m]:
>   - HID_LENOVO_GO [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
>   - HID_LENOVO_GO_S [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
> ERROR: modpost: "led_set_brightness_nopm" [drivers/leds/led-class.ko] undefined!
> ERROR: modpost: "led_set_brightness" [drivers/leds/led-class.ko] undefined!
> ERROR: modpost: "led_get_color_name" [drivers/leds/led-class-multicolor.ko] undefined!
> ERROR: modpost: "led_set_brightness" [drivers/leds/led-class-multicolor.ko] undefined!
> 
> Device drivers generally should not select other subsystems like this, as
> that tends to cause dependency problems including loops in the dependency
> graph.
> 
> Change these two and the older hid-lenovo driver to behave the same way as all
> other HID drivers and use 'depends on LEDS_CLASS' or 'depends on LEDS_CLASS_MULTICOLOR'
> instead, which itself has NEW_LEDS and LEDS_CLASS as dependencies.
> 
> Fixes: a23f3497bf20 ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
> Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Good catch, that escaped my attention during review. Applied to 
hid.git#for-7.1/lenovo-v2, thanks Arnd!

-- 
Jiri Kosina
SUSE Labs

