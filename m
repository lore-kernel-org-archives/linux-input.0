From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 23:11:46 +0100
Message-ID: <429B5FFF-C9A8-497C-AB96-48516E53A354@enac.fr>
References: <4B75E14A.2050602@seas.upenn.edu>  <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>  <4B760D60.6020907@seas.upenn.edu>  <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>  <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <4B96C4A8.3060005@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:55474 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab0CIWLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:11:50 -0500
In-Reply-To: <4B96C4A8.3060005@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>


Le 9 mars 10 =E0 22:59, Henrik Rydberg a =E9crit :
>
> On the contrary, the MT protocol is dependent on one of the single-=20
> touch events
> BTN_TOUCH or ABS_PRESSURE to be present in the event stream for =20
> proper device
> identification and for correct handling of zero-finger events. The =20
> latter
> because at least one value (BTN_TOUCH or ABS_PRESSURE) must change =20
> state to pass
> through input filtering when no fingers are present. This is what =20
> needs
> clarification.

Someone has pointed this to me a few weeks ago and tbh I had the =20
feeling that this is a bug in the protocol that we failed to notice =20
last summer. I agree with you that BTN_TOUCH plugs the hole, but I =20
don't find it very satisfactory that we need one protocol to inform =20
another.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
