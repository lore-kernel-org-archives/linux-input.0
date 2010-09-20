From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 22:04:57 +0200
Message-ID: <4C97BE69.2030100@euromail.se>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>  <1283005748-3293-2-git-send-email-rydberg@euromail.se>  <CE1C24FC-7C9A-4940-8141-391A368C59E5@enac.fr> <4C97BB33.5020806@euromail.se> <6A8BB954-78BB-4507-86F3-19DA5174FA5E@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:37485 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756705Ab0ITUFp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 16:05:45 -0400
In-Reply-To: <6A8BB954-78BB-4507-86F3-19DA5174FA5E@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/20/2010 10:01 PM, St=E9phane Chatty wrote:

>=20
> Le 20 sept. 10 =E0 21:51, Henrik Rydberg a =E9crit :
>=20
>> On 09/20/2010 09:46 PM, St=E9phane Chatty wrote:
>>
>>>
>>> Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :
>>>
>>>>  #define MAX_SLOTS        60
>>>> -#define MAX_TRKID        59
>>>> +#define MAX_TRKID        USHRT_MAX
>>>>
>>>
>>> Oops, I forgot this one: in the rest of the code, it seems to me th=
at you use
>>> your knowledge that TRACKINGID cannot be more than 59 (you use it t=
o map the
>>> tracking ID onto the slot ID). Therefore, why change TRKID to a lar=
ger value?
>>
>>
>> There are only 60 slots available, but an infinite number of trackin=
g ids.
>> Nowhere is the tracking id assumed to be bounded by anything but MAX=
_TRKID.
>>
>=20
> What about this:
> +            value =3D clamp_val(value, 0, MAX_SLOTS - 1);
>              if (md->valid) {
>                  md->curid =3D value;
>                  md->f[value].touch =3D md->touch;
>=20
> If you had tracking IDs 59, 60 and 61 in the same frame, this would n=
ot work
> properly would it?


That is the slot id being set. The microtouch controller is also using =
slots
internally.

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
