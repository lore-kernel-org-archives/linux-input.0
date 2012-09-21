From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] HID: Add support for Sony PS3 BD Remote Control
Date: Fri, 21 Sep 2012 22:45:55 +0200
Message-ID: <1348260355.705.9.camel@sirocco.hadess.net>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	 <CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	 <CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	 <CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	 <1347394656.1606.10.camel@sirocco.hadess.net>
	 <CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	 <1347456657.23874.29.camel@sirocco.hadess.net>
	 <CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	 <CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	 <20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	 <1347591892.6145.14.camel@obelisk.thedillows.org>
	 <20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
	 <1347929527.29391.9.camel@obelisk.thedillows.org>
	 <1347932038.29391.17.camel@obelisk.thedillows.org>
	 <20120919184834.8093076c520dba2dc91c2f5d@studenti.unina.it>
	 <1348073986.10827.21.camel@frustration.ornl.gov>
	 <20120921220659.1e257048fed597061efb07f9@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:32964 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757828Ab2IUUp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Sep 2012 16:45:59 -0400
In-Reply-To: <20120921220659.1e257048fed597061efb07f9@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org, David Herrmann <dh.herrmann@googlemail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-input@vger.kernel.org, jkosina@suse.cz

Em Fri, 2012-09-21 =C3=A0s 22:06 +0200, Antonio Ospite escreveu:
> From a user point of view there is still some "set up" happening,
> the gnome bluetooth-applet tells "Successfully set up new device '%
> s'", so maybe we can just call this "set up" in the comment above too=
,
> I
> mentioned the PIN because Gnome bluetooth does something about
> that[1],
> Bastien in gnome-bt case pin=3D"NULL" means that there will be no
> pin request at all by the device, right?

Yep. That means we don't try to pair, we just connect to it. No
security, first come first serve.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
