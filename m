From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH V1] hid: hid-multitouch:- No need of devm functions
Date: Tue, 13 Dec 2016 09:24:55 +0100
Message-ID: <20161213082455.GE13907@mail.corp.redhat.com>
References: <1481122773-6909-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbcLMIZA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 03:25:00 -0500
Content-Disposition: inline
In-Reply-To: <1481122773-6909-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Dec 07 2016 or thereabouts, Arvind Yadav wrote:
> In function mt_probe, the memory allocated for td->fields
> is live within the function only. After the allocation
> it is immediately freed with devm_kfree. There is no need
> to allocate memory for td->fields with devm function so
> replace devm_kzalloc with kzalloc and devm_kfree with kfree.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Please don't.

It's true that the buffer is only used temporary, but there are 2
reasons for that:
- the driver uses devm everywhere
- the return path is simplified by using devm

And here, the error code path will be more complex for no gain.

Cheers,
Benjamin

>  drivers/hid/hid-multitouch.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index fb6f1f4..13ea309 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1126,11 +1126,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	td->mt_report_id = -1;
>  	hid_set_drvdata(hdev, td);
>  
> -	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
> -				  GFP_KERNEL);
> +	td->fields = kzalloc(sizeof(struct mt_fields), GFP_KERNEL);
>  	if (!td->fields) {
>  		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto error_nomem;
>  	}
>  
>  	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
> @@ -1138,11 +1138,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	ret = hid_parse(hdev);
>  	if (ret != 0)
> -		return ret;
> +		goto error_free;
>  
>  	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret)
> -		return ret;
> +		goto error_free;
>  
>  	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
>  	if (ret)
> @@ -1153,10 +1153,15 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	mt_set_input_mode(hdev);
>  
>  	/* release .fields memory as it is not used anymore */
> -	devm_kfree(&hdev->dev, td->fields);
> +	kfree(td->fields);
>  	td->fields = NULL;
>  
>  	return 0;
> +
> +error_free:
> +	kfree(td->fields);
> +error_nomem:
> +	return ret;
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.7.4
> 
