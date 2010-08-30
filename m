From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Mon, 30 Aug 2010 15:36:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008301535300.1019@pobox.suse.cz>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>  <1283005748-3293-3-git-send-email-rydberg@euromail.se>  <2A410207-8AAA-4D5A-846A-B69F007E6800@enac.fr> <4C79346F.4050409@euromail.se> <75AEF6DA-F09E-4B90-8E89-6F5B668724C9@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <75AEF6DA-F09E-4B90-8E89-6F5B668724C9@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 28 Aug 2010, St=E9phane Chatty wrote:

> > I think we use the term tracking id differently here. The HID_DG_CO=
NTACTID
> > is
> > actually the slot id, and the tracking id is a sequential number, i=
ncreased
> > whenever the touch is new. I believe the patchset works correctly a=
s long as
> > there is less than 32768 new touches before releasing the oldest on=
e. :-)
>=20
> Oh, right. I definitely need to catch up with Protocol B.

Henrik,

thanks a lot for the patches.

Stephane, could you please send me your Acked-by for those changes? I'd=
=20
like to have this before applying them.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
