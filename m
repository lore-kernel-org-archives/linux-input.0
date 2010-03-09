From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 23:29:06 +0100
Message-ID: <4B96CBB2.1030901@euromail.se>
References: <4B75E14A.2050602@seas.upenn.edu>  <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>  <4B760D60.6020907@seas.upenn.edu>  <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>  <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <4B96C4A8.3060005@euromail.se> <429B5FFF-C9A8-497C-AB96-48516E53A354@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51437 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755363Ab0CIW3Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 17:29:24 -0500
In-Reply-To: <429B5FFF-C9A8-497C-AB96-48516E53A354@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

St=E9phane Chatty wrote:
>=20
> Le 9 mars 10 =E0 22:59, Henrik Rydberg a =E9crit :
>>
>> On the contrary, the MT protocol is dependent on one of the
>> single-touch events
>> BTN_TOUCH or ABS_PRESSURE to be present in the event stream for prop=
er
>> device
>> identification and for correct handling of zero-finger events. The l=
atter
>> because at least one value (BTN_TOUCH or ABS_PRESSURE) must change
>> state to pass
>> through input filtering when no fingers are present. This is what ne=
eds
>> clarification.
>=20
> Someone has pointed this to me a few weeks ago and tbh I had the feel=
ing
> that this is a bug in the protocol that we failed to notice last summ=
er.
> I agree with you that BTN_TOUCH plugs the hole, but I don't find it v=
ery
> satisfactory that we need one protocol to inform another.

=46rankly, I never even imagined there would be pure MT devices without=
 support
for the existing single-touch applications. But sure, it was an oversig=
ht at the
time.

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
