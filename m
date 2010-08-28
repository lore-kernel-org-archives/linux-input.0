From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Sat, 28 Aug 2010 17:56:52 +0200
Message-ID: <2A410207-8AAA-4D5A-846A-B69F007E6800@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-3-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:48077 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab0H1P46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Aug 2010 11:56:58 -0400
In-Reply-To: <1283005748-3293-3-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :

> The current code sometimes misses to report the last BTN_TOUCH event
> when multiple fingers are lifted simultaneously.  With the
> introduction of MT slots, the tracking id is available to determine
> the oldest active contact.

Hi Henrik,

good job on exploiting the sync quirk!

About the oldest active contact, I'm not so sure though. I don't have =20
the device with me but I remember that 3M recycle IDs, giving the =20
lowest available ID to any new finger; this means that the lowest ID =20
is not always the oldest finger.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
