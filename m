From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 13/15] Input: synaptics-rmi4 - properly set F01 container
 on PDT scan
Date: Tue, 4 Feb 2014 15:10:41 -0800
Message-ID: <52F17371.7030507@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com> <1390
 521623-6491-13-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:64496 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933867AbaBDXKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:10:42 -0500
In-Reply-To: <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:

Although necessary, this is redundant to changes already submitted.

> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   drivers/input/rmi4/rmi_driver.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 52345ae..9d8d6ec 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -488,6 +488,8 @@ static int create_function(struct rmi_device *rmi_dev,
>   		return error;
>
>   	list_add_tail(&fn->node, &data->function_list);
> +	if (pdt->function_number == 0x01)
> +		data->f01_container = fn;
>
>   	return 0;
>   }
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
