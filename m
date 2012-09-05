From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [eBeam PATCH 2/2] input: misc: New USB eBeam input driver.
Date: Wed, 05 Sep 2012 09:29:49 +0200
Message-ID: <3991181.oZKWSZGdK8@linux-lqwf.site>
References: <1346539923-9704-1-git-send-email-yann.cantin@laposte.net> <1346539923-9704-3-git-send-email-yann.cantin@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46168 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2IEHbJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Sep 2012 03:31:09 -0400
In-Reply-To: <1346539923-9704-3-git-send-email-yann.cantin@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, jikos@suse.cz

On Sunday 02 September 2012 00:52:03 Yann Cantin wrote:

Hi,

before we add yet another sysfs interface, we should ask whether calibr=
ation
isn't a problem that should be solved with a common API.

	Regards
		Oliver

> +static ssize_t ebeam_calibrated_set(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   const char *buf,
> +                                   size_t count)
> +{
> +       struct ebeam_device *ebeam =3D dev_get_drvdata(dev);
> +       int err, c;
> +
> +       err =3D kstrtoint(buf, 10, &c);
> +       if (err)
> +               return err;
> +
> +       if (c =3D=3D 1) {
> +               memcpy(&ebeam->cursetting, &ebeam->newsetting,
> +                      sizeof(struct ebeam_settings));
> +               ebeam->calibrated =3D true;
> +               ebeam_setup_input(ebeam, ebeam->input);
> +       } else {
> +               memcpy(&ebeam->newsetting, &ebeam->cursetting,
> +                      sizeof(struct ebeam_settings));
> +               ebeam->calibrated =3D false;
> +               ebeam_setup_input(ebeam, ebeam->input);
> +       }
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR(calibrated, S_IRUGO | S_IWUGO,
> +                  ebeam_calibrated_get, ebeam_calibrated_set);
> +
> +static struct attribute *ebeam_attrs[] =3D {
> +       &dev_attr_min_x.attr,
> +       &dev_attr_min_y.attr,
> +       &dev_attr_max_x.attr,
> +       &dev_attr_max_y.attr,
> +       &dev_attr_h1.attr,
> +       &dev_attr_h2.attr,
> +       &dev_attr_h3.attr,
> +       &dev_attr_h4.attr,
> +       &dev_attr_h5.attr,
> +       &dev_attr_h6.attr,
> +       &dev_attr_h7.attr,
> +       &dev_attr_h8.attr,
> +       &dev_attr_h9.attr,
> +       &dev_attr_calibrated.attr,
> +       NULL
> +};
> +
--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
