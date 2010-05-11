From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 3/3] Input: elantech - signature...
Date: Tue, 11 May 2010 23:01:48 +0200
Message-ID: <4BE9C5BC.5050503@tudelft.nl>
References: <20100511081848.10546.95545.stgit@localhost.localdomain> <20100511081859.10546.11991.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:39635 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab0EKVBu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 17:01:50 -0400
In-Reply-To: <20100511081859.10546.11991.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Florian Ragwitz <rafl@debian.org>, Arjan Opmeer <arjan@opmeer.net>

Op 11-05-10 10:18, Dmitry Torokhov schreef:
For the first time, the touchpad is detected out of the box on my Dell
mini 10... so sweet ;-)

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Tested-by: Eric Piel <eric.piel@tremplin-utc.net>


> ---
> 
>  drivers/input/mouse/elantech.c |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 232556a..b18862b 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -575,6 +575,24 @@ static struct attribute_group elantech_attr_group = {
>  	.attrs = elantech_attrs,
>  };
>  
> +static bool elantech_is_signature_valid(const unsigned char *param)
> +{
> +	static const unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10 };
> +	int i;
> +
> +	if (param[0] == 0)
> +		return false;
> +
> +	if (param[1] == 0)
> +		return true;
> +
> +	for (i = 0; i < ARRAY_SIZE(rates); i++)
> +		if (param[2] == rates[i])
> +			return false;
> +
> +	return true;
> +}
> +
>  /*
>   * Use magic knock to detect Elantech touchpad
>   */
> @@ -617,7 +635,7 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
>  	pr_debug("Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
>  		 param[0], param[1], param[2]);
>  
> -	if (param[0] == 0 || param[1] != 0) {
> +	if (!elantech_is_signature_valid(param)) {
>  		if (!force_elantech) {
>  			pr_debug("Probably not a real Elantech touchpad. Aborting.\n");
>  			return -1;
> 

