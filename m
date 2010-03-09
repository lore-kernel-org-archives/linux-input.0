From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] hid-magicmouse: Fix oops after device removal.
Date: Mon, 8 Mar 2010 23:48:20 -0800
Message-ID: <20100309074820.GD17288@core.coreip.homeip.net>
References: <87aaui2usx.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:54853 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab0CIHs1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 02:48:27 -0500
Received: by yxe29 with SMTP id 29so815249yxe.4
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 23:48:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87aaui2usx.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

On Mon, Mar 08, 2010 at 07:38:38PM -0500, Michael Poole wrote:
> From 57c6af4c2dadcce71566995baa15593103ab33aa Mon Sep 17 00:00:00 2001
> From: Michael Poole <mdpoole@troilus.org>
> Date: Mon, 8 Mar 2010 19:09:26 -0500
> Subject: [PATCH 1/1] hid-magicmouse: Fix oops after device removal.
> 
> Ask the HID core not to register an input device for the mouse.
> Fix an oops after removing the device, due to leaving the new
> input device registered.
> 
> Signed-off-by: Michael Poole <mdpoole@troilus.org>
> ---
>  drivers/hid/hid-magicmouse.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 4a3a94f..2e7d701 100644
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
> @@ -409,7 +409,10 @@ err_free:
>  
>  static void magicmouse_remove(struct hid_device *hdev)
>  {
> +	struct magicmouse_sc *msc;

Blank lines between variable definitions and code are always
appreciated. but also coudl be written as:

	struct magicmouse_sc *msc = hid_get_drvdata(dev);

> +	msc = hid_get_drvdata(hdev);
>  	hid_hw_stop(hdev);
> +	input_unregister_device(msc->input);
>  	kfree(hid_get_drvdata(hdev));

You have msc already sho that should be 'kfree(msc);'.
>  }
>  

-- 
Dmitry
