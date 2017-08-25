From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/4] HID: sony: Set INPUT_PROP_JOYDEV_IGNORE flag for
 motion sensors.
Date: Fri, 25 Aug 2017 10:46:13 +0200
Message-ID: <1503650773.12938.5.camel@hadess.net>
References: <20170824231153.8809-1-roderick@gaikai.com>
         <20170824231153.8809-3-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52810 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbdHYIqQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Aug 2017 04:46:16 -0400
In-Reply-To: <20170824231153.8809-3-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-24 at 16:11 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Configure the motion sensor sub device with the
> INPUT_PROP_JOYDEV_IGNORE
> flag to prevent joydev from picking it up.

Can you please add the reason why to the commit message?

> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  drivers/hid/hid-sony.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index d03203a..6c290c6 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1375,6 +1375,7 @@ static int sony_register_sensors(struct sony_sc
> *sc)
>  	}
>  
>  	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev-
> >propbit);
> +	__set_bit(INPUT_PROP_JOYDEV_IGNORE, sc->sensor_dev-
> >propbit);
>  
>  	ret = input_register_device(sc->sensor_dev);
>  	if (ret < 0)
