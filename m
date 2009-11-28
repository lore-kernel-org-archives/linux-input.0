From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: Sat, 28 Nov 2009 18:40:30 +0100
Message-ID: <m3638uy2cx.fsf@intrepid.localdomain>
References: <m3r5riy7py.fsf@intrepid.localdomain> <BDkdITRHqgB@lirc>
	<9e4733910911280906if1191a1jd3d055e8b781e45c@mail.gmail.com>
	<m3aay6y2m1.fsf@intrepid.localdomain>
	<9e4733910911280937k37551b38g90f4a60b73665853@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:55302 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756AbZK1Rk1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 12:40:27 -0500
In-Reply-To: <9e4733910911280937k37551b38g90f4a60b73665853@mail.gmail.com>
	(Jon Smirl's message of "Sat, 28 Nov 2009 12:37:40 -0500")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, stefanr@s5r6.in-berlin.de, superm1@ubuntu.com

Jon Smirl <jonsmirl@gmail.com> writes:

>> 1. Merging the lirc drivers. The only stable thing needed is lirc
>> =C2=A0 interface.
>
> Doing that locks in a user space API that needs to be supported
> forever. We need to think this API through before locking it in.

Sure, that's why I wrote about the need for it to be "stable".
--=20
Krzysztof Halasa
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
