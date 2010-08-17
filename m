From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Tue, 17 Aug 2010 06:55:02 -0400
Message-ID: <1282042502.13264.21.camel@mini>
References: <4C695985.5080403@bitmath.org>
	 <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:48685 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0HQKzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 06:55:10 -0400
In-Reply-To: <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input <linux-input@vger.kernel.org>

On Tue, 2010-08-17 at 09:49 +0200, St=C3=A9phane Chatty wrote:
> Le 16 ao=C3=BBt 10 =C3=A0 17:30, Henrik Rydberg a =C3=A9crit :
>=20
>   - the single touch emulation is highly device dependent. I was (and=
 =20
> still am) pretty proud of my choice of tracking the 'oldest' finger =20
> on the panel: this turns multitouch panels into single touch panels =20
> that are impervious to parasite touches. But the drawback is that =20
> currently there is no generic method for this tracking: I used =20
> whatever device-specific information I could use (order of fingers in=
 =20
> a message, tracking id, etc).

St=C3=A9phan,

Can you explain in more detail why you chose an 'oldest' finger approac=
h
for single touch emulation? I wonder if it's the best mechanism. Take
the following example:

1. User touches with one finger and intends to drag an object on screen
2. User touches another finger down, either accidentally or
intentionally, while dragging the first finger
3. User releases first finger to end the drag
4. Object suddenly is dragged under the second finger

As I'm implementing support for the Magic Trackpad right now, I'm havin=
g
to figure out the best way to do single-touch emulation. What I'm
currently doing is converting the first finger touched for single-touch
emulation, and when that finger is released no single-touch emulation
can occur until all fingers have left the screen again.

This should hopefully become a moot point once everyone understands MT
input, but sadly we have to deal with the reality of X not being MT
aware quite yet :).

Thanks,

-- Chase

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
