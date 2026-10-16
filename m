Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BB039C637
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138470; cv=none; b=cpB+B9ToI21ac5tjmMd/9xfH02bz9LgEBkGOxyIxkrltzxWBVawt1RfdfArlfpYAZfvtkKqp3iNdz429tMhzVvXz+QIWgCiXlmQ5E/3kur6yUV23nJKeR1txWuj+lc+heaUiMA93tiBnCPQkCfDuvcUdSpTyF0yitaFxFMUGV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138470; c=relaxed/simple;
	bh=nc2xVyGZatTTib8wVJfq+qI0ScOpY3qaGUxT4g3C3wM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O/05n4ayRCc/YefVsSAdFPNAUmltzYysO5JDVX3HyLPGpfhDdfHGMTTS/R7Do8BwA4/50uYw4sNlSEuFva8jKrvpzd30KUzuhGUfoz8/6VIn66OUklSbPc1SKz5CabP1UOkHj1wUuR6lHOXuI+JrbeDGimXyql5R86Nwuq17OrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmthsCWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmthsCWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEFE1F000C4;
	Fri, 16 Oct 2026 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138469;
	bh=wBNIguumVZ620aob9TsJcjN4G7RtVy5W7wp/zDPuddA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=nmthsCWFbkNS2s4dmqfip5y2PTd2eThBdQRK3lG3npRzKzu5SJD7i0WQhMGad06d1
	 2aiS9b0ddgd7y5aH9MZ4mVAy8m3q54BHwT7julHhMvGoekCeWfGdY/zU+hXIpnJNjI
	 gPvu5ZXDnRwNJJiGeWIsyUwJDtAe9pxg9wSyNSGKh/vVe04lTf/qFCyjBTCI+c1zVc
	 u38NEtDuZM1SVriRzp+pQ4WIIsrjT+e+AFUHfMJpc1w20YQMRl8BFZpR6Us895+Zp9
	 jfaigkMK9HHazf1Jwa2FfV2df28yLvN7FGSGPMcs8DrwRSLTuxOMJ0Jp7xr0JQWUpy
	 bNcDs8/p2IOJg==
Date: Fri, 16 Oct 2026 10:14:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rafael Passos <rafael@rcpassos.me>
cc: David Rheinsberg <david@readahead.eu>, bentiss@kernel.org, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    Brigham Campbell <me@brighamcampbell.com>, 
    Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 0/3] HID: wiimote: new LED behavior on connect +
 scoped_guards
In-Reply-To: <20261009022844.2790778-1-rafael@rcpassos.me>
Message-ID: <897q5o18-094p-3884-s8o6-8249n59p0p6q@xreary.bet>
References: <20261009022844.2790778-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Oct 2026, Rafael Passos wrote:

> Hi,
> This patchset contains one feature change, and 3 patches appying=20
> scoped cleanup to locking and to the initialization functions for
> the led probing and the main wiimote probe call.
> 
> The feature is turning different LEDs for each of the first 4 wiimotes conn=
> ected.
> >From id 5 forward, the LED will cycle back to 1, and so on.
> This uses the ida struct, so its quite simple and lightweight.
> The hid_info log message prints out the controller id.
> 
> While implementing this feature, I decided to cleanup the code using
> scoped_guard for the many spinlocks in the driver. There are two places
> where the original lock/unlock version fits best, and I left them
> untouched.
> I also used the __free scope cleanup in the wiimote_probe and LED probe.
> 
> It was really fun working with this driver.
> I tested it with 4 Wii Motion Plus remotes (gen2).
> Video recording of my tests (48s video).
> https://rcpassos.me/video/wiimote-led-linux-driver

Applied to hid.git#for-7.4/wiimote, thanks.

-- 
Jiri Kosina
SUSE Labs

