From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] Drivers: HID: fix warnings: from is u16 which never <
 0
Date: Thu, 25 Apr 2013 09:21:02 +0800
Message-ID: <517884FE.407@asianux.com>
References: <5160FC50.6080503@asianux.com> <alpine.LNX.2.00.1304241632560.29143@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:60418 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669Ab3DYBVt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Apr 2013 21:21:49 -0400
In-Reply-To: <alpine.LNX.2.00.1304241632560.29143@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 2013=E5=B9=B404=E6=9C=8824=E6=97=A5 22:33, Jiri Kosina wrote:
> On Sun, 7 Apr 2013, Chen Gang wrote:
>=20
>> >=20
>> >   from is u16 which never < 0.
>> >=20
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  drivers/hid/hid-icade.c |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >=20
>> > diff --git a/drivers/hid/hid-icade.c b/drivers/hid/hid-icade.c
>> > index 09dcc04..76b5a75 100644
>> > --- a/drivers/hid/hid-icade.c
>> > +++ b/drivers/hid/hid-icade.c
>> > @@ -159,7 +159,7 @@ static const struct icade_key icade_usage_tabl=
e[30] =3D {
>> > =20
>> >  static const struct icade_key *icade_find_translation(u16 from)
>> >  {
>> > -	if (from < 0 || from > ICADE_MAX_USAGE)
>> > +	if (from > ICADE_MAX_USAGE)
>> >  		return NULL;
>> >  	return &icade_usage_table[from];
>> >  }
> Applied, thanks.

Thanks, too.

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
