From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [rtc-linux] [RFC v2 PATCH 5/7] input: pmic8058-othc: Add
	support for PM8058 based OTHC
Date: Tue, 1 Feb 2011 14:33:56 +0000
Message-ID: <20110201143356.GB20088@sirena.org.uk>
References: <1296568063-12010-1-git-send-email-aghayal@codeaurora.org> <1296568063-12010-6-git-send-email-aghayal@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43065 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1BAOd7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Feb 2011 09:33:59 -0500
Content-Disposition: inline
In-Reply-To: <1296568063-12010-6-git-send-email-aghayal@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Feb 01, 2011 at 07:17:41PM +0530, Anirudh Ghayal wrote:
> One-touch headset controller is a hardware module in Qualcomm's PMIC8058.
> It supports headset insert/remove and switch press/release detection events
> over 3 MIC BIAS lines. The MIC BIAS lines can be configured to support
> headset detection or act as regular BIAS lines.

This should probably be integrated with ASoC for management of the
biases if nothing else, though it'd also allow other stuff.  ALSA has
support for creating input devices from jacks already.

> +	input_set_capability(ipd, EV_SW, SW_HEADPHONE_INSERT);
> +	input_set_capability(ipd, EV_KEY, KEY_MEDIA);

The ALSA (well, ASoC) stuff would also allow the input device to be
merged with that for other detection methods so if you've got a headset
jack capable of detecting other things (eg, mechanical insertion or
separate mic and headphone detection).
