From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid:Add warning message if sysfs group is not created
 for passed kobject in the function, mt_probe
Date: Fri, 5 Feb 2016 08:48:04 +0100
Message-ID: <20160205074804.GF12345@mail.corp.redhat.com>
References: <1454601160-21966-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbcBEHsJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 02:48:09 -0500
Content-Disposition: inline
In-Reply-To: <1454601160-21966-1-git-send-email-xerofoify@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Nick,

On Feb 04 2016 or thereabouts, Nicholas Krause wrote:
> This adds a warning message stating that the sysfs group was not
> able to be created for the passed hid_device structure pointer
> with dev_warn.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 296d499..b2b2451 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1133,6 +1133,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  
>  	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
> +	if (ret)
> +		dev_warn(&hdev->dev, "Cannot allocate sysfs group for %s\n", hdev->name);

Just nitpicking here. Checkpatch.pl complains about a line over 80
characters here. Could you (or maybe just Jiri) fix that?

Otherwise:
Reviewed-by: Benjamin Tissoires <benajmin.tissoires@redhat.com>

Cheers,
Benjamin

>  
>  	mt_set_maxcontacts(hdev);
>  	mt_set_input_mode(hdev);
> -- 
> 2.5.0
> 
