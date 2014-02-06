From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sony Report actual brightness value when reading
 LED
Date: Thu, 6 Feb 2014 09:46:35 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402060946260.24838@pobox.suse.cz>
References: <1391628858-2916-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405AbaBFIqk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Feb 2014 03:46:40 -0500
In-Reply-To: <1391628858-2916-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 5 Feb 2014, Simon Wood wrote:

> The Dualshock4 controller contains a RGB LED, which is enabled via
> the '/sys/class/leds' interface. At present the driver only returns
> whether each of the RGB LEDs is lit (ie not off), but no indication
> of it's brightness.
> 
> This patch fixes the reading of the current brightnes so that it
> returns the value (rather than just off=0, on=LED_FULL).
> 
> Tested on the DS4 and SixAxis (for compatibility).
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

Applied, thanks Simon.

-- 
Jiri Kosina
SUSE Labs
