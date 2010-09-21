From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Tue, 21 Sep 2010 21:20:34 +0200
Message-ID: <6B445E9B-2146-4AD8-B9F4-94A68E4BFA0C@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>  <1283005748-3293-3-git-send-email-rydberg@euromail.se>  <B5146B49-1D7A-4AFD-B925-3F35E83A2A96@enac.fr> <alpine.LNX.2.00.1009211904290.26813@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:54717 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0IUTUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 15:20:41 -0400
In-Reply-To: <alpine.LNX.2.00.1009211904290.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Le 21 sept. 10 =E0 19:05, Jiri Kosina a =E9crit :

> On Tue, 21 Sep 2010, St=E9phane Chatty wrote:
>
>>> The current code sometimes misses to report the last BTN_TOUCH even=
t
>>> when multiple fingers are lifted simultaneously.  With the
>>> introduction of MT slots, the tracking id is available to determine
>>> the oldest active contact. Use this information to simplify and
>>> correct the touchscreen emulation logic.
>>>
>>
>> Acked-by: St=E9phane Chatty <chatty@enac.fr>
>
> It doesn't apply without 2/3 being applied as well. So I'll not be
> applying it for now, and either please rebase it, or re-send =20
> together with
> 2/3 once the situation with 0eef:72xx is sorted out. Ok?

Er, there must be some confusion here: 0eef:72xx is about hid-egalax, =20
in a different thread.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
