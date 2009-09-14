From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2 1/2] Input: Add DaVinci DM365 Keypad support
Date: Mon, 14 Sep 2009 11:45:47 -0700
Message-ID: <200909141145.48252.david-b@pacbell.net>
References: <1252951959-31015-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.gq1.yahoo.com ([67.195.15.63]:26057 "HELO
	smtp104.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755353AbZINSpr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 14:45:47 -0400
In-Reply-To: <1252951959-31015-1-git-send-email-miguel.aguilar@ridgerun.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: miguel.aguilar@ridgerun.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

On Monday 14 September 2009, miguel.aguilar@ridgerun.com wrote:
> +=A0=A0=A0=A0=A0=A0=A0dm365_kp =3D kzalloc(sizeof *dm365_kp, GFP_KERN=
EL);
> +=A0=A0=A0=A0=A0=A0=A0key_dev =3D input_allocate_device();
> +
> +=A0=A0=A0=A0=A0=A0=A0if (!dm365_kp || !key_dev) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(dev, "Could not=
 allocate input device\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> +=A0=A0=A0=A0=A0=A0=A0}

Can still leak the kzalloc'ed data...


> +=A0=A0=A0=A0=A0=A0=A0dm365_kp->irq =3D platform_get_irq(pdev, 0);
> +=A0=A0=A0=A0=A0=A0=A0if (dm365_kp->irq <=3D 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(dev, "%s: No DM=
365 Keypad irq\n", pdev->name);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail1;
> +=A0=A0=A0=A0=A0=A0=A0}

Still discards the true fault codes here and later ...


> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "DaVinci DM365 Keypad Driver\n=
");

Nicer not to have such banners; a dev_info() in probe() is
better and won't show on boards where this driver isn't used.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
