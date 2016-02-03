From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid:Add missing error checking in mt_probe for creating
 sysfs_create_group
Date: Wed, 3 Feb 2016 09:23:55 +0100
Message-ID: <20160203082355.GE12345@mail.corp.redhat.com>
References: <1454470263-29702-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46040 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbcBCIX7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Feb 2016 03:23:59 -0500
Content-Disposition: inline
In-Reply-To: <1454470263-29702-1-git-send-email-xerofoify@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 02 2016 or thereabouts, Nicholas Krause wrote:
> This adds the missing error check in the function mt_probe for
> the call to the function sysfs_create_group for creating the
> group,mt_attrribute as based on the based input device's device
> kobject's member as otherwise we assume the sysfs directory is
> created successfully no matter the return value of
> sysfs_create_group.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 296d499..46ebf06 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1133,6 +1133,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  
>  	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
> +	if (ret)
> +		return ret;

I am not particularly happy with a hard failure here in case the sysfs
group doesn't bind. The group is mainly used for debug, and I am not
sure anybody but me uses it nowadays.

Could you amend the patch to put a warning in case of a failure but
still continue?

Cheers,
Benjamin

>  
>  	mt_set_maxcontacts(hdev);
>  	mt_set_input_mode(hdev);
> -- 
> 2.5.0
> 
