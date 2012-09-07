From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [patch] HID: picoLCD: fix a NULL test in picolcd_raw_cir()
Date: Fri, 7 Sep 2012 23:38:18 +0200
Message-ID: <20120907233818.62aa63d2@neptune.home>
References: <20120907064740.GB12028@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:50831 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2IGVjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Sep 2012 17:39:11 -0400
In-Reply-To: <20120907064740.GB12028@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 07 September 2012 Dan Carpenter <dan.carpenter@oracle.com> wrot=
e:
> Smatch complains that the NULL checking in this function is not
> consistent and could lead to a NULL dereference.  The comments say th=
at
> we should return here if rc_dev is NULL so I've changed the test to
> match the comment.

Good catch! Currently thanks to HID mutex around probe()/remove()
we should never be able to see rc_dev being NULL here.


Once the probe()/remove() mutex gets tied to hw_start()/hw_stop() or
otherwise changed to allow drivers to chat with device during probe()
->rc_dev might be NULL in picolcd_raw_cir().


Reviewed-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Jiri, please apply to picolcd branch.

Thanks,
Bruno


> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Only needed in linux-next.  This is a static checker fix and I don't
> have the hardware to test it.  Please review carefully.
>=20
> diff --git a/drivers/hid/hid-picolcd_cir.c b/drivers/hid/hid-picolcd_=
cir.c
> index 14c5ce0..13ca919 100644
> --- a/drivers/hid/hid-picolcd_cir.c
> +++ b/drivers/hid/hid-picolcd_cir.c
> @@ -51,7 +51,7 @@ int picolcd_raw_cir(struct picolcd_data *data,
> =20
>  	/* ignore if rc_dev is NULL or status is shunned */
>  	spin_lock_irqsave(&data->lock, flags);
> -	if (data->rc_dev && (data->status & PICOLCD_CIR_SHUN)) {
> +	if (!data->rc_dev || (data->status & PICOLCD_CIR_SHUN)) {
>  		spin_unlock_irqrestore(&data->lock, flags);
>  		return 1;
>  	}
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
