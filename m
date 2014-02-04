From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 02/15] Input: synaptics-rmi4 - don't kfree devm_ alloced
 memory
Date: Tue, 4 Feb 2014 15:08:19 -0800
Message-ID: <52F172E3.7050601@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:63783 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936591AbaBDXIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:08:20 -0500
In-Reply-To: <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>

This is redundant with patch code submitted 2013/01/22.  See here:
     http://www.spinics.net/lists/linux-input/msg29280.html

and in any case, Dmitry has submitted a more thorough tidy up here:
     http://www.spinics.net/lists/linux-input/msg29323.html

> ---
>   drivers/input/rmi4/rmi_f01.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index cf1081f..98bc65a9 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -390,7 +390,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   	return 0;
>
>    error_exit:
> -	kfree(data);
> +	devm_kfree(&fn->dev, data);
>   	return error;
>   }
>
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
