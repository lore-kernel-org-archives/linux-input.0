From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] hid-magicmouse: Fix oops after device removal.
Date: Tue, 9 Mar 2010 09:36:47 -0800
Message-ID: <20100309173647.GA23378@core.coreip.homeip.net>
References: <87aaui2usx.fsf@troilus.org>
 <20100309074820.GD17288@core.coreip.homeip.net>
 <87iq951zu0.fsf_-_@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45204 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0CIRg4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 12:36:56 -0500
Received: by fxm5 with SMTP id 5so1569748fxm.29
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 09:36:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87iq951zu0.fsf_-_@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

On Tue, Mar 09, 2010 at 06:47:35AM -0500, Michael Poole wrote:
> From 7466c15f196621c44b01e3e1f8abd61099e48989 Mon Sep 17 00:00:00 2001
> From: Michael Poole <mdpoole@troilus.org>
> Date: Tue, 9 Mar 2010 06:46:09 -0500
> Subject: [PATCH v2] hid-magicmouse: Fix oops after device removal.
> 
> Ask the HID core not to register an input device for the mouse.
> Fix an oops after removing the device, due to leaving the new
> input device registered.
> 
> Signed-off-by: Michael Poole <mdpoole@troilus.org>

Yep, looks good, thank you for making the change.

> ---
>  drivers/hid/hid-magicmouse.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 4a3a94f..c174b64 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -353,7 +353,7 @@ static int magicmouse_probe(struct hid_device *hdev,
>  		goto err_free;
>  	}
>  
> -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDINPUT);
>  	if (ret) {
>  		dev_err(&hdev->dev, "magicmouse hw start failed\n");
>  		goto err_free;
> @@ -409,8 +409,11 @@ err_free:
>  
>  static void magicmouse_remove(struct hid_device *hdev)
>  {
> +	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
> +
>  	hid_hw_stop(hdev);
> -	kfree(hid_get_drvdata(hdev));
> +	input_unregister_device(msc->input);
> +	kfree(msc);
>  }
>  
>  static const struct hid_device_id magic_mice[] = {
> -- 
> 1.7.0.2
> 

-- 
Dmitry
