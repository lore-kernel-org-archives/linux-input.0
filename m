From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 23:44:06 +0100
Message-ID: <B647823B-9F78-4B59-A7D5-F84805BD60A1@enac.fr>
References: <4B75E14A.2050602@seas.upenn.edu>   <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>   <4B760D60.6020907@seas.upenn.edu>   <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>   <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu>  <4B96C4A8.3060005@euromail.se>  <429B5FFF-C9A8-497C-AB96-48516E53A354@enac.fr> <4B96CBB2.1030901@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:36742 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab0CIWoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:44:10 -0500
In-Reply-To: <4B96CBB2.1030901@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>


Le 9 mars 10 =E0 23:29, Henrik Rydberg a =E9crit :

> St=E9phane Chatty wrote:
>>
>> Le 9 mars 10 =E0 22:59, Henrik Rydberg a =E9crit :
>>>
>>> On the contrary, the MT protocol is dependent on one of the
>>> single-touch events
>>> BTN_TOUCH or ABS_PRESSURE to be present in the event stream for =20
>>> proper
>>> device
>>> identification and for correct handling of zero-finger events. =20
>>> The latter
>>> because at least one value (BTN_TOUCH or ABS_PRESSURE) must change
>>> state to pass
>>> through input filtering when no fingers are present. This is what =20
>>> needs
>>> clarification.
>>
>> Someone has pointed this to me a few weeks ago and tbh I had the =20
>> feeling
>> that this is a bug in the protocol that we failed to notice last =20
>> summer.
>> I agree with you that BTN_TOUCH plugs the hole, but I don't find =20
>> it very
>> satisfactory that we need one protocol to inform another.
>
> Frankly, I never even imagined there would be pure MT devices =20
> without support
> for the existing single-touch applications. But sure, it was an =20
> oversight at the
> time.

In my case, not detecting it was a pure mistake, nothing else :-) And =20
I've worked with formal models of input devices for decades, which =20
makes it really embarrassing.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
