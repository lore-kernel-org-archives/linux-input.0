From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RESEND] hid: 3m: Adjust major / minor axes to scale
Date: Wed, 22 Sep 2010 00:18:20 +0200
Message-ID: <4C992F2C.1070601@euromail.se>
References: <4C992775.3000000@euromail.se> <B4B2743B-D21F-4EC2-8E1E-5C52C78B5AF6@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:42856 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755503Ab0IUWSy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 18:18:54 -0400
In-Reply-To: <B4B2743B-D21F-4EC2-8E1E-5C52C78B5AF6@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/21/2010 11:51 PM, St=E9phane Chatty wrote:

> No problem with this one at all.
>=20
> Henrik, do you confirm that this applies only to 3M? Or is it a gener=
al issue
> with the mapping from HID to input?


Of the devices I have seen so far, the touch width mapping is fairly ar=
bitrary.
Some are too large, some are too small. Regarding HID drivers in genera=
l, I
really cannot say. No particular pattern so far, in other words.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
