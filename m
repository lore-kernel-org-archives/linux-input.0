From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1  1/1] Input: elantech - fix absolute mode setting on
 some Asus touchpads
Date: Wed, 25 Mar 2015 15:52:22 -0700
Message-ID: <20150325225222.GA17427@dtor-ws>
References: <20150325203428.GA24094@lantern>
 <1427318875-12142-1-git-send-email-ulrik.debie-os@e2big.org>
 <1427318875-12142-2-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35575 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbCYWw1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 18:52:27 -0400
Received: by igcau2 with SMTP id au2so115010560igc.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2015 15:52:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427318875-12142-2-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, George Moutsopoulos <gmoutso@yahoo.co.uk>

Hi Ulrik,

On Wed, Mar 25, 2015 at 10:27:55PM +0100, Ulrik De Bie wrote:
> On Asus TP500LN and X750JN, the touchpad absolute mode is reset each
> time set_rate is done.
> 
> In order to fix this, we will verify the firmware version, and if it
> matches the one in those laptops, the set_rate function is overloaded
> with a function elantech_set_rate_restore_reg_07 that perfoms the
> set_rate with the original function, followed by a restore of reg_07
> (the register that sets the absolute mode on elantech v4 hardware).
> 
> Also the asus TP500LN and X750JN firmware version, capabilities, and
> button constellation is added to elantech.c
> 
> Reported-and-tested-by: George Moutsopoulos <gmoutso@yahoo.co.uk>
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> ---
>  drivers/input/mouse/elantech.c | 22 ++++++++++++++++++++++
>  drivers/input/mouse/elantech.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 6e22682..991dc6b 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -893,6 +893,21 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
>  }
>  
>  /*
> + * This writes the reg_07 value again to the hardware at the end of every
> + * set_rate call because the register loses its value. reg_07 allows setting
> + * absolute mode on v4 hardware
> + */
> +static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
> +		unsigned int rate)
> +{
> +	struct elantech_data *etd = psmouse->private;
> +
> +	etd->original_set_rate(psmouse, rate);
> +	if (elantech_write_reg(psmouse, 0x07, etd->reg_07))
> +		psmouse_err(psmouse, "restoring reg_07 failed\n");

I wonder if set rate is useful for Elantech and if it would not be
simpler to just have an empty stub for set_rate, maybe even for all
Elantech devices?

Thanks.

-- 
Dmitry
