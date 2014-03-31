From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] input: Add new driver for ARM CLPS711X keypad
Date: Sun, 30 Mar 2014 18:19:35 -0700
Message-ID: <2993844.QDC18iO0r3@dtor-d630.eng.vmware.com>
References: <1395165739-17378-1-git-send-email-shc_work@mail.ru> <20140328164228.GA7582@core.coreip.homeip.net> <1396210775.399876201@f299.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41437 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaCaBTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Mar 2014 21:19:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7480004pbb.33
        for <linux-input@vger.kernel.org>; Sun, 30 Mar 2014 18:19:40 -0700 (PDT)
In-Reply-To: <1396210775.399876201@f299.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

On Monday, March 31, 2014 12:19:35 AM Alexander Shiyan wrote:
> Fri, 28 Mar 2014 09:42:28 -0700 =D0=BE=D1=82 Dmitry Torokhov=20
<dmitry.torokhov@gmail.com>:
> > Hi Alexander,
> >=20
> > On Tue, Mar 18, 2014 at 10:02:19PM +0400, Alexander Shiyan wrote:
> > > +	err =3D input_register_polled_device(poll_dev);
> > > +	if (!err) {
> > > +		/* Report initial state */
> > > +		clps711x_keypad_poll(poll_dev);
> > > +
> > > +		return 0;
> > > +	}
> >=20
> > The polled device core will report initial state when input device =
is
> > opened (as long as polling is enabled) so I removed this cunk and
> > applied the rest.
>=20
> I looked amended version, it is made incorrectly.
> ...
> + err =3D input_register_polled_device(poll_dev);
> + if (err)
> + goto out_err;
> +
> +out_err:
> + input_free_polled_device(poll_dev);
> ...
>=20
> Should be:
>  err =3D input_register_polled_device(poll_dev);
>  if (!err)
>  return 0;

Yes, I missed that "return 0;" should be fixed now.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
