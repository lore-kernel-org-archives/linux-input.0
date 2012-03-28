From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
Date: Wed, 28 Mar 2012 22:04:05 +0400
Message-ID: <4F735295.2010604@mvista.com>
References: <1332911324-9840-1-git-send-email-chao.xie@marvell.com> <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60664 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509Ab2C1SFH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 14:05:07 -0400
Received: by bkcik5 with SMTP id ik5so1198065bkc.19
        for <linux-input@vger.kernel.org>; Wed, 28 Mar 2012 11:05:05 -0700 (PDT)
In-Reply-To: <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org

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
