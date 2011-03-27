From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] G25_support
Date: Sun, 27 Mar 2011 21:41:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103272140430.26754@pobox.suse.cz>
References: <1299842104.2550.24.camel@slim-one-desktop> <1300769820-16198-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57749 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754202Ab1C0TlO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2011 15:41:14 -0400
In-Reply-To: <1300769820-16198-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input <linux-input@vger.kernel.org>, Peter <peter@slim-one.de>

On Mon, 21 Mar 2011, Simon Wood wrote:

> From: Peter <peter@slim-one.de>

Could you please provide full name here, so that I could apply the patch 
with proper authorship attribution?

Thanks.

> 
> Small patch to add support for the G25/G27 by adding USB ID's
> as suggested by Peter.
> 
> Boots but otherwise untested as I don't have hardware, .debs for
> kernel (2.6.38) here if want to test/run Ubuntu/Debian:
> http://www.mungewell.org/Logitech_Wii_Wheel/
> 
> Reported-by: Peter <peter@slim-one.de>
> Signed-off-by: Simon Wood <simon@mungewell.org>
> ---
>  drivers/hid/hid-lgff.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
> index 90d0ef2..f099079 100644
> --- a/drivers/hid/hid-lgff.c
> +++ b/drivers/hid/hid-lgff.c
> @@ -73,6 +73,8 @@ static const struct dev_type devices[] = {
>  	{ 0x046d, 0xc293, ff_joystick },
>  	{ 0x046d, 0xc294, ff_wheel },
>  	{ 0x046d, 0xc295, ff_joystick },
> +	{ 0x046d, 0xc298, ff_wheel },
> +	{ 0x046d, 0xc299, ff_wheel },
>  	{ 0x046d, 0xca03, ff_wheel },
>  };

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
