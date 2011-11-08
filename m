From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH] Input: elantech: adjust hw_version detection logic
Date: Tue, 08 Nov 2011 18:55:37 +0100
Message-ID: <1998016.KAbb3SKMtM@ax5200p>
References: <1320754099-2669-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:54151 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932652Ab1KHRz6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 12:55:58 -0500
In-Reply-To: <1320754099-2669-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, linux-input@vger.kernel.org

hi Jj,

On Tuesday 08 November 2011 20:08:19 JJ Ding wrote:
> This patch fixes some v3 hardware (fw_version: 0x150500) wrongly detected
> as v2 hardware.
> 
> Reported-by: Marc Dietrich <marvin24@gmx.de>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> ---
> Hi list,
> 
> This is patched against v3.2-rc1.
> 
> Marc, could you please test this again? Thanks a lot.

patch works fine here. You may add:

	Tested-By: Marc Dietrich <marvin24@gmx.de>

Btw, are there any known issues with suspend/resume? The touchpad doesn't seem 
to wakeup again after resume, but that's propably a problem of our kbd 
controller driver. Just in case there's something known...

Thanks Marc

> 
>  drivers/input/mouse/elantech.c |   26 ++++++++++++++++++--------
>  1 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 09b93b1..e2a9867 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1210,18 +1210,28 @@ static int elantech_reconnect(struct psmouse
> *psmouse) */
>  static int elantech_set_properties(struct elantech_data *etd)
>  {
> +	/* This represents the version of IC body. */
>  	int ver = (etd->fw_version & 0x0f0000) >> 16;
> 
> +	/* Early version of Elan touchpads doesn't obey the rule. */
>  	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
>  		etd->hw_version = 1;
> -	else if (etd->fw_version < 0x150600)
> -		etd->hw_version = 2;
> -	else if (ver == 5)
> -		etd->hw_version = 3;
> -	else if (ver == 6)
> -		etd->hw_version = 4;
> -	else
> -		return -1;
> +	else {
> +		switch (ver) {
> +		case 2:
> +		case 4:
> +			etd->hw_version = 2;
> +			break;
> +		case 5:
> +			etd->hw_version = 3;
> +			break;
> +		case 6:
> +			etd->hw_version = 4;
> +			break;
> +		default:
> +			return -1;
> +		}
> +	}
> 
>  	/*
>  	 * Turn on packet checking by default.
