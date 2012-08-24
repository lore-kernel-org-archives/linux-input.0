From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH v4 2/2] input: misc: New USB eBeam input driver.
Date: Fri, 24 Aug 2012 11:31:08 +0200
Message-ID: <503749DC.2080808@laposte.net>
References: <1345673514-11575-1-git-send-email-yann.cantin@laposte.net> <1345673514-11575-3-git-send-email-yann.cantin@laposte.net> <5832321.EK5PCgIIzt@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:21304 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab2HXJ3f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Aug 2012 05:29:35 -0400
In-Reply-To: <5832321.EK5PCgIIzt@linux-lqwf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

Hi,

Le 23/08/2012 08:54, Oliver Neukum a =E9crit :
> On Thursday 23 August 2012 00:11:54 Yann Cantin wrote:
>> +       /* input final setup */
>> +       err =3D input_register_device(ebeam->input);
>> +       if (err) {
>> +               dev_dbg(&intf->dev,
>> +                       "%s - input_register_device failed, err: %d\=
n",
>> +                       __func__, err);
>> +               goto out_free_urb;
>> +       }
>> +
>> +       ebeam_setup_input(ebeam, input_dev);
>> +
>> +       /* usb final setup */
>> +       usb_set_intfdata(intf, ebeam);
>=20
> Hi,
>=20
> this looks like a classic race. You initialize the device after you
> register it. However, it may be used at that time.

Ok, moved ebeam_setup_input before input_register_device.

Thanks.

--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
