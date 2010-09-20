From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 21:53:07 +0200
Message-ID: <9C62C97B-C427-4CC7-8248-F70DADE29A35@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>  <1283005748-3293-2-git-send-email-rydberg@euromail.se>  <FF722ED6-6568-47D0-82D1-99B9E9D5AEAF@enac.fr> <4C97BAA2.6000309@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C97BAA2.6000309@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Le 20 sept. 10 =E0 21:48, Henrik Rydberg a =E9crit :
>>
>> I understand this as a trick to get rid of MISC/SCANCODEs that are =20
>> added for
>> every EV_KEY message, consequence of a rule in hid-input.c. =20
>> Wouldn't it be
>> simpler to improve the rule than to work around it?
>
>
> The main reason is to be able to set the fuzz parameters, which are =20
> otherwise
> overwritten by hid-input setup.

OK, I did not notice that :-) Mmm, I guess my comment about fixing =20
hid-input still holds. But we could do it in a later version if time =20
is short.

St.
