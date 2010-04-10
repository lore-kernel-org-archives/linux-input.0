From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 21:36:50 +0200
Message-ID: <5B957660-AC69-4545-8657-38F3FEE307C8@enac.fr>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr> <alpine.LNX.2.00.1004102123210.8345@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:56663 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab0DJTg4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 15:36:56 -0400
In-Reply-To: <alpine.LNX.2.00.1004102123210.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stephane Chatty <chatty@lii-enac.fr>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux@philmerk.de


Le 10 avr. 10 =E0 21:25, Jiri Kosina a =E9crit :

>> From other reports we won't get what anyway?

The device sends either multitouch or touchpad-like reports depending =20
on which mode it's in. In _probe we set it in multitouch mode, and =20
therefore we can safely ignore the touchpad fields from the report =20
descriptors.


> Otherwise the driver looks OK to me, I'll add the slab.h include as
> noticed by Christoph (as implicit slab.h inclusion has gone away in
> mainline already).

Thx.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
