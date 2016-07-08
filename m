From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: hid-led: fix Delcom support on big endian systems
Date: Fri, 8 Jul 2016 12:38:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607081238170.24757@cbobk.fhfr.pm>
References: <c65d7daa-e057-8aab-7e3e-2e88bf896061@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41190 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbcGHKic (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jul 2016 06:38:32 -0400
In-Reply-To: <c65d7daa-e057-8aab-7e3e-2e88bf896061@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 8 Jul 2016, Heiner Kallweit wrote:

> Properly handle this __le16 value on big endian systems.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/hid/hid-led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
> index 4c43ef8..d8d55f3 100644
> --- a/drivers/hid/hid-led.c
> +++ b/drivers/hid/hid-led.c
> @@ -327,7 +327,7 @@ static int delcom_init(struct hidled_device *ldev)
>  	 * Several Delcom devices share the same USB VID/PID
>  	 * Check for family id 2 for Visual Signal Indicator
>  	 */
> -	return dp.fw.family_code == 2 ? 0 : -ENODEV;
> +	return le16_to_cpu(dp.fw.family_code) == 2 ? 0 : -ENODEV;
>  }

Applied to for-4.8/hid-led. Thanks,

-- 
Jiri Kosina
SUSE Labs

