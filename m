From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: drivers/usb/class/cdc-acm.c patch kernel 2.6.31.-rc1
Date: Wed, 22 Jul 2009 17:43:11 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901B1F567@mi8nycmail19.Mi8.com>
References: <C01FCF206F5D8D4C89B210408D7DB39C12ED1F@mail2.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og116.obsmtp.com ([64.18.1.37]:50839 "HELO
	exprod6og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753828AbZGVVnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 17:43:14 -0400
Content-class: urn:content-classes:message
In-Reply-To: <C01FCF206F5D8D4C89B210408D7DB39C12ED1F@mail2.oerlikon.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>, linux-input@vger.kernel.org

On Wednesday, July 22, 2009 2:09 PM, Wending Weng wrote:
> From 39e8558a114297ee9192f406d63f423aded05288 Mon Sep 17 00:00:00 2001
> From: root <root@SBC_PC_3.localdomain>
> Date: Tue, 21 Jul 2009 10:48:15 -0400
> vers/usb/class/cdc-acm.cSubject: [PATCH]
> When the usb-serial cable is unpluged, the usb host controller driver returns
> all scheduled URBs to usb-serial driver(cdc-acm.c), and the usb-serial driver
> (cdc-acm.c) doesn't detect this exception, continues to schedule the URBs, it
>  causes a dead loop.
> This change fixes this problem.
> 
> Signed-off-by: Wending Weng <wweng@rheinmetall.ca>
> ---
>  drivers/usb/class/cdc-acm.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)

I really don't have any comments on what this patch fixes but...

> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 38bfdb0..3cc3e18 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -372,8 +372,15 @@ static void acm_read_bulk(struct urb *urb)
>                 list_add_tail(&rcv->list, &acm->spare_read_urbs);
>                 list_add(&buf->list, &acm->spare_read_bufs);
>                 spin_unlock(&acm->read_lock);
> -               /* nevertheless the tasklet must be kicked unconditionally
> -               so the queue cannot dry up */
> +
> +               /* Normally, the tasklet must be kicked unconditionally
> +               so the queue cannot dry up, however, if the cable is disconnected,
> +               or whatever fatal error, it must not reschedule any URB */

This multi-line comment is not in the typical kernel style.  Granted the previous
one isn't either.

> +
> +                // Stop rescheduling any URB in case the connection is shutdown

C++ comments are generally frowned upon.  This one should be like:

> +                /* Stop rescheduling any URB in case the connection is shutdown */

> +                if ((urb->status == -ESHUTDOWN) || (urb->status == -EPROTO))
> +                        return;
> +
>         }
>         if (likely(!acm->susp_count))
>                 tasklet_schedule(&acm->urb_task);

Regards,
Hartley
