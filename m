From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: Re: [PATCH 2/2] Alps Dualpoint, Interleaved packets
Date: Tue, 15 Dec 2009 22:01:33 +0100
Message-ID: <1260910893.6294.26.camel@sardelle.necksus.de>
References: <1259513695.32495.171.camel@sardelle.necksus.de>
	 <20091204084902.GB22570@core.coreip.homeip.net>
	 <1259963240.27307.213.camel@sardelle.necksus.de>
	 <1260742145.9901.18.camel@sardelle.necksus.de>
	 <20091215064224.GB12669@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933671AbZLOVBk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 16:01:40 -0500
In-Reply-To: <20091215064224.GB12669@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input ML <linux-input@vger.kernel.org>


Hi Dmitry,

I really hate to say, but I can still desync it.

[1240043.147596] alps.c: handle cf
[1240043.148778] alps.c: handle 14
[1240043.150043] alps.c: handle 1a
[1240043.157696] alps.c: handle 5f
[1240043.158851] alps.c: handle c
[1240043.160044] alps.c: handle 29
[1240043.163885] alps.c: handle 2f
[1240043.165051] alps.c: handle 0
[1240043.166213] alps.c: handle ff
[1240043.166218] alps.c: refusing packet[5] =3D ff
[1240043.166221]=20
[1240043.166227] psmouse.c: DualPoint TouchPad at isa0060/serio1/input0=
 lost sync at byte 6

In short, it's a 6-byte followed by a 3-byte; we mistakenly process it
as a interleaved PS/2 (oh well), and, while the final bytes come in,
happen upon high bits set in the PS/2 packet.  In a way, this is correc=
t
behaviour, because we _are_ processing the data incorrectly...  In my
last patch, this went unnoticed because I didn't check for the high bit
in bytes 7,8,9.

=46or all practical purposes (i.e. not pressing three buttons and fumbl=
ing
with both pointers at the same time), the patch works very well.

In particular, no double clicks.  :-)

--=20
Sebastian Kapfer
 Inst. f=FCr Theoretische Physik I        Office +49-9131-85-2-8450
 Universit=E4t Erlangen                   Mobile +49-160-9577-6436
 Staudtstr. 7, Raum 02.583.             sebastian.kapfer@physik.uni-erl=
angen.de

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
