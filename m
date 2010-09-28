From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 28 Sep 2010 21:52:59 +0200
Message-ID: <4CA2479B.7050305@euromail.se>
References: <1284476919.3732.10.camel@PhEeeTab> <4CA242B7.7020609@euromail.se> <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:55488 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758312Ab0I1Txb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:53:31 -0400
In-Reply-To: <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Philipp Merkel <mail@philmerk.de>, linux-input@vger.kernel.org

On 09/28/2010 09:43 PM, St=E9phane Chatty wrote:

>=20
> Le 28 sept. 10 =E0 21:32, Henrik Rydberg a =E9crit :
>=20
>>
>> Philipp, Stephane, if you are interested in testing out the driver o=
n the
>> 0eff:480d, please let me know (off list), and we should hopefully be=
 able to
>> find a merge.
>>
>=20
>=20
> I don't have an eGalax device :-)
>=20
> By the way, since you apparently have access to a Joojoo and I did no=
t get any
> response from any Joojoo owner, can you tell us whether it exhibits t=
he bogus Xs
> and Ys that Philipp has observed? It would be consistent with the ran=
ge
> inconsistency that you have observed.


Yes, since (4k << 3) =3D=3D 32k, I believe we are looking at the same b=
ehavior on
both devices.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
