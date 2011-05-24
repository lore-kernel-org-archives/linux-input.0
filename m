From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] hid-multitouch: Add support for Lumio panels
Date: Tue, 24 May 2011 13:38:44 +0200
Message-ID: <874o4k9vln.fsf@macbook.be.48ers.dk>
References: <1305725244-5327-1-git-send-email-benjamin.tissoires@enac.fr>
	<87boyyo0gr.fsf@macbook.be.48ers.dk>
	<BANLkTikPXHswWQqQHqd8fegotqoZPLErsQ@mail.gmail.com>
	<87mxihd6kh.fsf@macbook.be.48ers.dk>
	<BANLkTi=nyaVBhKB6bKLCqtykjMAaKfEt9A@mail.gmail.com>
	<87ipt533cw.fsf@macbook.be.48ers.dk>
	<17A85239-A316-43B7-B46C-0AD33B0D92C1@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46487 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab1EXLiu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 07:38:50 -0400
In-Reply-To: <17A85239-A316-43B7-B46C-0AD33B0D92C1@enac.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?St=C3=A9phane?=
	Chatty"'s message of "Tue, 24 May 2011 11:05:24 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?St=C3=A9phane?= Chatty <chatty@enac.fr>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, USB list <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org

>>>>> "St=C3=A9phane" =3D=3D St=C3=A9phane Chatty <chatty@enac.fr> writ=
es:

Hi,

 St=C3=A9phane> Benjamin and I have been in touch with the Lumio people=
 about
 St=C3=A9phane> this device and their reply is "old firmware, not suppo=
rted
 St=C3=A9phane> anymore". Peter, is there a way to upgrade your firmwar=
e?

Thanks. I've not been directly involved with this project earlier or in
communication with Lumio, so I'm not 100% sure if this controller board
is able to handle new firmware. This configuration uses 2 cameras, but
we also have another setup with 4 cameras (where multitouch has been
verified under Win7). That one uses a different controller board, and
its firmware uses product ID 6 like on your setup.

I'll try to contact Lumio to verify.

--=20
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
