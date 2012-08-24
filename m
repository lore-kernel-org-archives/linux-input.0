From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH v4 2/2] input: misc: New USB eBeam input driver.
Date: Fri, 24 Aug 2012 11:37:45 +0200
Message-ID: <50374B69.3040002@laposte.net>
References: <1345673514-11575-1-git-send-email-yann.cantin@laposte.net> <1345673514-11575-3-git-send-email-yann.cantin@laposte.net> <1368810.q4rGz16CTW@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368810.q4rGz16CTW@linux-lqwf.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Le 23/08/2012 09:23, Oliver Neukum a =E9crit :
> On Thursday 23 August 2012 00:11:54 Yann Cantin wrote:
>> +static int ebeam_resume(struct usb_interface *intf)
>> +{
>> +       struct ebeam_device *ebeam =3D usb_get_intfdata(intf);
>> +       struct input_dev *input =3D ebeam->input;
>> +       int result =3D 0;
>> +
>> +       mutex_lock(&input->mutex);
>> +       if (input->users)
>> +               result =3D usb_submit_urb(ebeam->irq, GFP_NOIO);
>> +       mutex_unlock(&input->mutex);
>> +
>> +       return result;
>> +}
>> +
>> +static int ebeam_reset_resume(struct usb_interface *intf)
>> +{
>> +       struct ebeam_device *ebeam =3D usb_get_intfdata(intf);
>> +       struct input_dev *input =3D ebeam->input;
>> +       int err =3D 0;
>> +
>> +       /* restart IO if needed */
>> +       mutex_lock(&input->mutex);
>> +       if (input->users)
>> +               err =3D usb_submit_urb(ebeam->irq, GFP_NOIO);
>> +       mutex_unlock(&input->mutex);
>> +
>> +       return err;
>> +}
>=20
> These functions are identical. You should unify them.

Removed reset_resume from the driver (optional, and not needed
for this hardware).

Thanks.

--=20
Yann Cantin
A4FEB47F
--
