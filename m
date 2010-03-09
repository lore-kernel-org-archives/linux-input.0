From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid-magicmouse: Fix oops after device removal.
Date: Tue, 9 Mar 2010 13:37:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003091337180.17799@pobox.suse.cz>
References: <87aaui2usx.fsf@troilus.org> <20100309074820.GD17288@core.coreip.homeip.net> <87iq951zu0.fsf_-_@troilus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38133 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab0CIMhf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 07:37:35 -0500
In-Reply-To: <87iq951zu0.fsf_-_@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

On Tue, 9 Mar 2010, Michael Poole wrote:

> Ask the HID core not to register an input device for the mouse.
> Fix an oops after removing the device, due to leaving the new
> input device registered.
> 
> Signed-off-by: Michael Poole <mdpoole@troilus.org>
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

Applied, thank you Michael.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
