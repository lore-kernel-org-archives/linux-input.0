From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Thu, 27 Nov 2008 00:01:50 +0100
Message-ID: <492DD55E.1020508@gmail.com>
References: <200811262333.45245.lukasz@lubojanski.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:48439 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYKZXB4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2008 18:01:56 -0500
Received: by ey-out-2122.google.com with SMTP id 6so314713eyi.37
        for <linux-input@vger.kernel.org>; Wed, 26 Nov 2008 15:01:54 -0800 (PST)
In-Reply-To: <200811262333.45245.lukasz@lubojanski.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>
Cc: linux-input@vger.kernel.org

On 11/26/2008 11:33 PM, =A3ukasz Luboja=F1ski wrote:
> Hi..
>=20
> I have implemented Force Feedback driver for another "GreeAsia" based=
 device
> (0e8f:0012 "GreenAsia Inc.    USB Joystick     ").
> The functionality was tested with MANTA Warior MM816 and SpeedLink St=
rike2
> SL-6635 and fftest software - everything seems to work right.
>=20
> Is there anyone able to check the code say if this good enough to inc=
lude it
> into official kernel ?

It's based on the old infrastructure.

> If there are any suggestion what I should additionally check or what =
I
> should change before posting it please let me know.

Rebase it on a later kernel. It's now hard to comment, since you'll cha=
nge much
of the code :).
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
