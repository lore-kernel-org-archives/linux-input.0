From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [patch] HID: logitech-hidpp: leaks and NULL dereferences
Date: Fri, 31 Oct 2014 09:49:01 -0400
Message-ID: <20141031134901.GB24511@mail.corp.redhat.com>
References: <20141031091439.GA11252@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760119AbaJaNtY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 09:49:24 -0400
Content-Disposition: inline
In-Reply-To: <20141031091439.GA11252@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Oct 31 2014 or thereabouts, Dan Carpenter wrote:
> Shift the allocation down a few lines to avoid a memory leak and also
> add a check for allocation failure.
> 
> Fixes: 2f31c5252910 ('HID: Introduce hidpp, a module to handle Logitech hid++ devices')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Ouch, I am ashamed of not having spot that :/

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Dan!
Benjamin

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 361e97d..3cce995 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -200,13 +200,15 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
>  	u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
>  	struct hidpp_report *response)
>  {
> -	struct hidpp_report *message = kzalloc(sizeof(struct hidpp_report),
> -			GFP_KERNEL);
> +	struct hidpp_report *message;
>  	int ret;
>  
>  	if (param_count > sizeof(message->fap.params))
>  		return -EINVAL;
>  
> +	message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
> +	if (!message)
> +		return -ENOMEM;
>  	message->report_id = REPORT_ID_HIDPP_LONG;
>  	message->fap.feature_index = feat_index;
>  	message->fap.funcindex_clientid = funcindex_clientid;
> @@ -221,8 +223,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
>  	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
>  	struct hidpp_report *response)
>  {
> -	struct hidpp_report *message = kzalloc(sizeof(struct hidpp_report),
> -			GFP_KERNEL);
> +	struct hidpp_report *message;
>  	int ret;
>  
>  	if ((report_id != REPORT_ID_HIDPP_SHORT) &&
> @@ -232,6 +233,9 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
>  	if (param_count > sizeof(message->rap.params))
>  		return -EINVAL;
>  
> +	message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
> +	if (!message)
> +		return -ENOMEM;
>  	message->report_id = report_id;
>  	message->rap.sub_id = sub_id;
>  	message->rap.reg_address = reg_address;
