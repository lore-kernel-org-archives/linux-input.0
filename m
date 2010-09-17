From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Add a hid quirk for input sync override
Date: Fri, 17 Sep 2010 18:49:00 +0200
Message-ID: <4C939BFC.2080008@euromail.se>
References: <1282640084-19217-1-git-send-email-rydberg@euromail.se>  <alpine.LNX.2.00.1009011252450.26813@pobox.suse.cz>  <4C7E39CC.80402@euromail.se> <alpine.LNX.2.00.1009021630000.26813@pobox.suse.cz> <D154A68C-ABA2-4C6C-B7E1-C0989357B8F7@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:47056 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752Ab0IQQtL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Sep 2010 12:49:11 -0400
In-Reply-To: <D154A68C-ABA2-4C6C-B7E1-C0989357B8F7@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/17/2010 06:20 PM, St=E9phane Chatty wrote:

>>>
>>>
>>> Sounds good. I suppose Stephane wants to have a say regarding the 3=
m driver
>>> first, but no rush. What version are you targeting?
>>
>> 2.6.37 looks reasonable if everything it agreed upon in the followin=
g
>> week(s).
>>
>=20
> After many adventures, I finally managed to get the driver *and* the =
3M panel
> available at the same time. XDS and the satellite events did not help=
 :-)
>=20
> I'm observing a few things that look strange with evtest, starting wi=
th missing
> ABS_MT_SLOT at the beginning of interaction sequences.


ABS_MT_SLOT will only be emitted when it actually changes, i.e., not ne=
cessarily
between frames.

> Investigating... Henrik,
> would it be useful if I send you evtest logs, what I did with my fing=
ers and
> what I find strange in the result?


Certainly. Have you encountered anything strange in the actual interact=
ion with
the device? I have been running the 3M patches daily for several weeks =
and found
no issues.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
