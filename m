From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: wacom: Unregister sysfs attributes on remove
Date: Wed, 7 Sep 2011 13:36:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109071336420.13109@pobox.suse.cz>
References: <1315241129-3889-1-git-send-email-dh.herrmann@googlemail.com> <1315241129-3889-2-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57509 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757275Ab1IGW3a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Sep 2011 18:29:30 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 603108ADF6
	for <linux-input@vger.kernel.org>; Thu,  8 Sep 2011 00:29:29 +0200 (CEST)
In-Reply-To: <1315241129-3889-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>

On Mon, 5 Sep 2011, David Herrmann wrote:

> HID devices can be hotplugged so we should unregister all sysfs attributes when
> removing a driver. Otherwise, manually unloading the wacom-driver will not
> remove the sysfs attributes. Only when the device is disconnected, they are
> removed, eventually.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Applied, thanks David.

> ---
>  drivers/hid/hid-wacom.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index f66a597..a597039 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -423,6 +423,7 @@ static void wacom_remove(struct hid_device *hdev)
>  #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
>  	struct wacom_data *wdata = hid_get_drvdata(hdev);
>  #endif
> +	device_remove_file(&hdev->dev, &dev_attr_speed);
>  	hid_hw_stop(hdev);
>  
>  #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
> -- 
> 1.7.6.1
> 

-- 
Jiri Kosina
SUSE Labs

