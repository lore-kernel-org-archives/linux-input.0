From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue is not empty.
Date: Fri, 23 Apr 2010 14:08:14 -0700
Message-ID: <201004231408.15885.dmitry.torokhov@gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com> <1271984938-13920-9-git-send-email-arve@android.com> <20100423135625.1e12d005.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33350 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384Ab0DWVIV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Apr 2010 17:08:21 -0400
In-Reply-To: <20100423135625.1e12d005.randy.dunlap@oracle.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, =?iso-8859-1?q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Sven Neumann <s.neumann@raumfeld.com>, Tero Saarni <tero.saarni@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Matthew Garrett <mjg@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that =
will
> > block suspend while the event queue is not empty. This allows users=
pace
> > code to process input events while the device appears to be asleep.
>=20
> All new ioctls need to be added to Documentation/ioctl/ioctl-number.t=
xt,
> please.

I do not see the reason for it to be in the kernel still. Have a proces=
s
that listens to all input devices (or subset of them), once events stop
coming initiate suspend.

>=20
> > Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> > ---
> >=20
> >  drivers/input/evdev.c |   22 ++++++++++++++++++++++
> >  include/linux/input.h |    3 +++
> >  2 files changed, 25 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > index 2ee6c7a..66e0d16 100644
> > --- a/drivers/input/evdev.c
> > +++ b/drivers/input/evdev.c
> > @@ -585,6 +594,19 @@ static long evdev_do_ioctl(struct file *file,
> > unsigned int cmd,
> >=20
> >  		else
> >  	=09
> >  			return evdev_ungrab(evdev, client);
> >=20
> > +	case EVIOCGSUSPENDBLOCK:
> > +		return put_user(client->use_suspend_blocker, ip);
> > +
> > +	case EVIOCSSUSPENDBLOCK:
> > +		spin_lock_irq(&client->buffer_lock);
> > +		if (!client->use_suspend_blocker && p)
> > +			suspend_blocker_init(&client->suspend_blocker, "evdev");
> > +		else if (client->use_suspend_blocker && !p)
> > +			suspend_blocker_destroy(&client->suspend_blocker);
> > +		client->use_suspend_blocker =3D !!p;
> > +		spin_unlock_irq(&client->buffer_lock);
> > +		return 0;
> > +
> >=20
> >  	default:
> >  		if (_IOC_TYPE(cmd) !=3D 'E')
> >=20
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 7ed2251..b2d93b4 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -82,6 +82,9 @@ struct input_absinfo {
> >=20
> >  #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release=20
device */
> >=20
> > +#define EVIOCGSUSPENDBLOCK	_IOR('E', 0x91, int)			/* get=20
suspend block
> > enable */ +#define EVIOCSSUSPENDBLOCK	_IOW('E', 0x91, int)			/*=20
set
> > suspend block enable */ +
> >=20
> >  /*
> > =20
> >   * Event types
> >   */
>=20
> thanks,
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your c=
ode
> *** --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
