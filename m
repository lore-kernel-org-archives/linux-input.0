From: "Przemo Firszt" <przemo@firszt.eu>
Subject: Re: [PATCH] HID: wacom: Fix wacom_probe error handling
Date: Mon, 17 Sep 2012 09:28:44 +0100
Message-ID: <6b8f36c5518404598ba8c60eea6005d6.squirrel@webmail.firszt.eu>
References: <1347848940.20002.1.camel@phoenix>
Reply-To: przemo@firszt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wren.arvixe.com ([50.97.138.99]:38854 "EHLO wren.arvixe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2IQI2q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 04:28:46 -0400
In-Reply-To: <1347848940.20002.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Przemo Firszt <przemo@firszt.eu>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org


Dnia 17 Wrze=B6nia 2012, 3:29 am, Pn, Axel Lin napisa=B3(a):
> In the case of goto destroy_leds, we also need to call hid_hw_stop(hd=
ev)
> and
> remove sysfs attribute files we created for speed and oleds.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/hid/hid-wacom.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index a0fafac..fae7fd7 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -902,10 +902,18 @@ OLED_INIT(7);
>  err_ac:
>  	power_supply_unregister(&wdata->battery);
>  err_battery:
> -	device_remove_file(&hdev->dev, &dev_attr_speed);
> -	hid_hw_stop(hdev);
>  destroy_leds:
>  	wacom_destroy_leds(hdev);
> +	device_remove_file(&hdev->dev, &dev_attr_oled0_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled1_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled2_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled3_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled4_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled5_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled6_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled7_img);
> +	device_remove_file(&hdev->dev, &dev_attr_speed);
> +	hid_hw_stop(hdev);
>  err_free:
>  	kfree(wdata);
>  	return ret;
> --
> 1.7.9.5
Hi Alex,
The initial idea was that the OLEDs/LED are not critical for tablet
functioning and that's why there was no call of hid_stop_hw if the
OLED/LED initialisation faild.
What's is the general kernel/HID policy: is it OK to have a device work=
ing
with some non-essential features missing?

--=20
Regards,
Przemo Firszt

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
