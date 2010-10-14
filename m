From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/4] hid-multitouch: a first step towards multitouch unification
Date: Thu, 14 Oct 2010 14:13:10 +0200
Message-ID: <4CB6F3D6.6030502@euromail.se>
References: <20101013222811.6EC0B95210@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33688 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529Ab0JNMNV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 08:13:21 -0400
In-Reply-To: <20101013222811.6EC0B95210@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, chatty@enac.fr

On 10/14/2010 12:28 AM, Stephane Chatty wrote:

>=20
> Hi Jiri, Dmitry, Henrik,
>=20
> this set of patches is aimed at unifying support for HID multitouch p=
anels,
> in a driver named hid-multitouch.
>=20
> So far, this driver works only for panels that share common features =
in their
> implementation of the Win7-compatible multitouch HID protocol. This c=
urrently
> includes Cando, Quanta, MosArt, Cypress, GeneralTouch and Pixcir, and=
 excludes
> Stantum and N-trig. 3M is left aside for now because it contains some=
 specific
> code. eGalax is also left as a special case because of the duality be=
tween
> their resistive and capacitive panels.


Excellent. I think we will be able to fit 3M into here as well in a bit=
, once we
have made our way through the current patches. :-)

>=20
> St=E9phane Chatty (4):
>   hid-multitouch: support for PixCir-based panels in a generic code s=
tructure
>   hid-multitouch: migrated support for Cando panels
>   hid-multitouch: added support for Cypress TrueTouch panels
>   hid-multitouch: migrated support for MosArt panels
> =20


Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
