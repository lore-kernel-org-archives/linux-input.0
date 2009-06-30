From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: X window don't read my input device automatically
Date: Mon, 29 Jun 2009 19:31:39 -0700
Message-ID: <20090630023139.GA10652@dtor-d630.eng.vmware.com>
References: <e715744d0906181955h646e5941y4d54056b1ea4d27e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:31109 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbZF3Cbn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 22:31:43 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1093066wfd.4
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 19:31:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e715744d0906181955h646e5941y4d54056b1ea4d27e@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: guo jerry <mimi0213kimo@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jun 19, 2009 at 10:55:20AM +0800, guo jerry wrote:
> Hi all,
> =A0=A0=A0=A0=A0=A0=A0 I have written my multi-touch panel device driv=
er and register
> two input devices.
> =A0=A0=A0=A0=A0=A0=A0 they appear in /dev/input/event7 & /dev/input/e=
vent8. The
> problem is that why
> =A0=A0=A0=A0=A0=A0=A0 X window can read other mouse devices automatic=
ally and work under X
> =A0=A0=A0=A0=A0=A0=A0 environment but the device driver written by my=
 own cannot.
> =A0=A0=A0=A0=A0=A0=A0 I guess that if the evbit and keybit which I se=
t is not correctly.
> =A0=A0=A0=A0=A0=A0=A0 I set my evbit & keybit as following:
>=20
> =A0=A0=A0=A0=A0=A0=A0 input->evbit[0] =3D BIT_MASK(EV_KEY) || BIT_MAS=
K(EV_ABS);

I don't think you want 'logical or' here but rather a bitwise one.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
