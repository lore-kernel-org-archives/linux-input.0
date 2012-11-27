From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Tue, 27 Nov 2012 11:56:44 -0800
Message-ID: <20121127195644.GA29727@core.coreip.homeip.net>
References: <1354020025-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1354020025-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46436 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab2K0T4u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 14:56:50 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so6190226pad.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 11:56:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1354020025-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, Nov 27, 2012 at 12:40:23PM +0000, Mark Brown wrote:
> The Arizona CODECs contain a haptics module providing vibration feedback
> support. Implement basic support for this, providing simple start/stop and
> signal magnitude control.
> 
> Since the output path for haptics is routed through the CODEC audio routing
> it is modelled as a signal generator within ASoC, the haptics driver calls
> DAPM to start and stop the output drivers. An appropriate output path must
> be configured via ALSA to connect the haptics source to the correct output.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

with minor nits:

> +
> +	if (effect->u.rumble.strong_magnitude) {
> +		/* Scale the magnitude into the range the device supports */
> +		if (arizona->pdata.hap_act) {
> +			haptics->intensity = effect->u.rumble.strong_magnitude
> +				>> 9;

If we have to fit in 80 columns can we format like this:

			haptics->intensity =
				effect->u.rumble.strong_magnitude >> 9;

> +			if (effect->direction < 0x8000)
> +				haptics->intensity += 0x7f;
> +		} else {
> +			haptics->intensity = effect->u.rumble.strong_magnitude
> +				>> 8;

and here as well - I really hate shifts moved over to the next line.

How do you want to merge it? My tree or some other?

Thanks.

-- 
Dmitry
