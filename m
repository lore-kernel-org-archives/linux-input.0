From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Tue, 22 Dec 2009 20:27:39 +0100
Message-ID: <48B39262-E923-4047-8DC4-5E21E666887D@enac.fr>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr>  <20091211124226.GD17995@ibawizard.net>  <20091211141038.0CBD8951F5@smtp.lii-enac.fr>  <20091211223622.GA3067@core.coreip.homeip.net>  <694242AB-D4DC-470D-916D-9ADB2B798FBA@enac.fr> <20091222185628.GA28392@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:45210 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbZLVT1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 14:27:45 -0500
In-Reply-To: <20091222185628.GA28392@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ynezz@true.cz, linux-input@vger.kernel.org


Le 22 d=E9c. 09 =E0 19:56, Dmitry Torokhov a =E9crit :
>
> I meant "read-modify-write" is worse.
>
> To modify a bitfiled the processor has to fetch data from memory (or
> cache if it is in cache) perform a logical operation on it, and store
> it back in teh memory. With boolean occupying 1 byte, on most
> architectures (older alphas is one exception I know of) var=3Dtrue =20
> can be
> done by simple store, no need for "read-modify" part.

OK. I had not realized this. My processor architecture courses were =20
too long ago.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
