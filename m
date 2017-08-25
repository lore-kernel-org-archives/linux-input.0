From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 3/4] HID: udraw-ps3: Set INPUT_PROP_JOYDEV_IGNORE for
 motion sensor
Date: Fri, 25 Aug 2017 10:46:31 +0200
Message-ID: <1503650791.12938.6.camel@hadess.net>
References: <20170824231153.8809-1-roderick@gaikai.com>
         <20170824231153.8809-4-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43348 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754956AbdHYIqf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Aug 2017 04:46:35 -0400
In-Reply-To: <20170824231153.8809-4-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-24 at 16:11 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Set the INPUT_PROP_JOYDEV_IGNORE flag for the motion sensor device,
> so it won't get picked up by joydev.

Ditto on the reason.

> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  drivers/hid/hid-udraw-ps3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-udraw-ps3.c b/drivers/hid/hid-udraw-
> ps3.c
> index 88ea390..7ea4066 100644
> --- a/drivers/hid/hid-udraw-ps3.c
> +++ b/drivers/hid/hid-udraw-ps3.c
> @@ -379,6 +379,7 @@ static bool udraw_setup_accel(struct udraw
> *udraw,
>  	input_set_abs_params(input_dev, ABS_Z, -512, 512, 0, 0);
>  
>  	set_bit(INPUT_PROP_ACCELEROMETER, input_dev->propbit);
> +	set_bit(INPUT_PROP_JOYDEV_IGNORE, input_dev->propbit);
>  
>  	udraw->accel_input_dev = input_dev;
>  
