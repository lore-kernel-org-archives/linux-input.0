From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: list not released in case of -ENODEV in hidraw_release
 (hidraw.c)
Date: Fri, 22 Jul 2011 16:36:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107221635550.7300@pobox.suse.cz>
References: <BANLkTi=Teg9iN8osSDY9fqadZ+sA-Ng2Sw@mail.gmail.com> <BANLkTikJfc_ZNG6LudKupUULqK+pN93MLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43316 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab1GVOg2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 10:36:28 -0400
In-Reply-To: <BANLkTikJfc_ZNG6LudKupUULqK+pN93MLg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>, Antonio Ospite <ospite@studenti.unina.it>

On Wed, 22 Jun 2011, Amit Nagal wrote:

> > linux kernel ver 2.6.39.1 =A0, =A0hidraw.c =A0, in =A0hidraw_releas=
e function
> > , list pointer ( struct hidraw_list *list ) is not freed
> > in case of -ENODEV .
> >
> > i think the following patch is applicable :
> >
> > --- a/drivers/hid/hidraw.c =A0 =A0 =A02011-06-22 08:57:55.000000000=
 -0400
> > +++ b/drivers/hid/hidraw.c =A0 =A0 =A02011-06-22 08:42:04.000000000=
 -0400
> > @@ -298,6 +298,7 @@ static int hidraw_release(struct inode *
> >
> > =A0 =A0 =A0 =A0mutex_lock(&minors_lock);
> > =A0 =A0 =A0 =A0if (!hidraw_table[minor]) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(list);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
> > =A0 =A0 =A0 =A0}
> >
> > Please correct me if i am mistaken .
> >
>=20
> In continuation of above , in hidraw_release(), for the sequence
> disconnect  followed by last userspace close(fd) call ,
> even kfree(list->hidraw) should also be called , as in
> hidraw_disconnect() function kfree(hidraw) is called only when
> hidraw->open is 0 .
> so list->hidraw should also be freed when calling last close() call
> even after disconnect .

Hi Amit,

your analysis is correct. Could you please re-send the patch with the=20
other fixes added, and also your Signed-off-by line?

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
