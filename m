From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pxa: Fix some issues with pxa27x_keypad driver v2
Date: Wed, 28 May 2008 10:31:25 -0400
Message-ID: <20080528103004.ZZRA012@mailhub.coreip.homeip.net>
References: <20080528162539.6d7a2158.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.242]:16590 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYE1Oba (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 10:31:30 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2162503hsl.5
        for <linux-input@vger.kernel.org>; Wed, 28 May 2008 07:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080528162539.6d7a2158.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, eric miao <eric.y.miao@gmail.com>

Hi Antonio,

On Wed, May 28, 2008 at 04:25:39PM +0200, Antonio Ospite wrote:
>  
> -	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> -		BIT_MASK(EV_REL);
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	if (keypad->pdata->rotary0_rel_code || keypad->pdata->rotary1_rel_code)
> +		input_dev->evbit[0] |= BIT_MASK(EV_REL);

Shouldn't this also check pdata->enable_rotaryX?

-- 
Dmitry
