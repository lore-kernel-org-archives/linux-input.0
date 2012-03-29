From: Chao Xie <cxie4@marvell.com>
Subject: RE: [PATCH 4/4] Input: pxa27x_keypad add choice to set
 direct_key_mask
Date: Thu, 29 Mar 2012 02:15:00 -0700
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D1A7474ABC7@SC-VEXCH2.marvell.com>
References: <1332911324-9840-1-git-send-email-chao.xie@marvell.com>
 <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
 <4F735295.2010604@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44585 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558Ab2C2JPI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 05:15:08 -0400
In-Reply-To: <4F735295.2010604@mvista.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, Haojian Zhuang <hzhuang1@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Thanks. I will sent V2 patches.

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com] 
Sent: Thursday, March 29, 2012 2:04 AM
To: Chao Xie
Cc: linux-input@vger.kernel.org; eric.y.miao@gmail.com; Haojian Zhuang; linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] Input: pxa27x_keypad add choice to set direct_key_mask

Hello.

On 03/28/2012 09:08 AM, Chao Xie wrote:

> Direct keys usage may not start from KP_DKIN0, add a msk option
> to configure the specifics for platforms that can skip some keys.

> Signed-off-by: Chao Xie<chao.xie@marvell.com>
[...]

> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index b41ebda..661892b 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -391,7 +391,12 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
>   	if (pdata->direct_key_num>  direct_key_num)
>   		direct_key_num = pdata->direct_key_num;
>
> -	keypad->direct_key_mask = ((1<<  direct_key_num) - 1)&  ~mask;
> +	/* Direct keys usage may not start from KP_DKIN0, check the platfrom
> +	 * msk data to config the specific */

    The preferred multi-line comment style is not this one. You got it right in 
the previous patch. :-)

WBR, Sergei
