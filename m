From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] G25_support
Date: Tue, 22 Mar 2011 10:40:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103221039090.19969@pobox.suse.cz>
References: <1299842104.2550.24.camel@slim-one-desktop> <1300769820-16198-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57408 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab1CVJka (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2011 05:40:30 -0400
In-Reply-To: <1300769820-16198-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input <linux-input@vger.kernel.org>, Peter <peter@slim-one.de>, Christophe Borivant <christophe.borivant@wanadoo.fr>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>

On Mon, 21 Mar 2011, Simon Wood wrote:

> From: Peter <peter@slim-one.de>
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

You are right that missing entries in this struct for devices which have 
LG_FF flag set doesn't make too much sense.

Adding Michal and Chritophe to CC, as they should have the HW to test.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
