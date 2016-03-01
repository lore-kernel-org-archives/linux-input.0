From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: Simple approach to write PS3/PS4 usermode driver?
Date: Tue, 1 Mar 2016 20:56:56 +0100
Message-ID: <56D5F408.4020604@m-reimer.de>
References: <56C2270E.9080603@m-reimer.de>
 <20160215223436.fc5a3f66f82ee49b161099ea@ao2.it>
 <56C37C5A.6030303@m-reimer.de>
 <CAM4jgCrRCUQYZBnhKGhc27UTkyzQS=rJOP4jrdT1UGtLDGqNzQ@mail.gmail.com>
 <20160227225909.073f78a9@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:60803 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbcCAT5A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Mar 2016 14:57:00 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id 40376434E0
	for <linux-input@vger.kernel.org>; Tue,  1 Mar 2016 20:56:59 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id aml42QsNsY_z for <linux-input@vger.kernel.org>;
	Tue,  1 Mar 2016 20:56:58 +0100 (CET)
In-Reply-To: <20160227225909.073f78a9@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 02/27/2016 10:59 PM, Bruno Pr=C3=A9mont wrote:
> Have you tried event remapping as supported by evdev?
>
> Have a look at EVIOCGKEYCODE and EVIOCSKEYCODE ioctls for event devic=
es.
>
> Those might be sufficient to perform your remapping (as long as games=
 don't
> do magic based on event device identification).

They do! A few games actually have support for the PS3 controller so I=20
would have to enable/disable my modifications depending on that.

I just want some easy way to use my controllers with any game that=20
supports xbox pads. This also involves scaling the stick values to the=20
range used by the Xbox pad.

I'm nearly done with USB support in my usermode driver and currently I=20
think I won't do bluetooth as this starts to suck. USB seems to be many=
=20
times easier...

=46or whatever reason the PS4 controller doesn't send anything to the=20
interrupt socket (I already send all "initialization sequences" I found=
=20
on the web) and the PS3 controller seems to use some crazy special type=
=20
of connecting (does the controller actually try to connect to my PC and=
=20
so I have to listen for it??).

I still hope to be at least able to support the PS4 controller in=20
bluetooth mode, but I don't have any clue why the interrupt socket is=20
silent...

Best regards,

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
