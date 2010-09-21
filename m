From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] hid: 3m: Adjust to sequential MT HID protocol
Date: Tue, 21 Sep 2010 16:12:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211612400.26813@pobox.suse.cz>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1213242F-BA51-4D3C-93F9-5CF29DEC513B@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1213242F-BA51-4D3C-93F9-5CF29DEC513B@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 20 Sep 2010, St=E9phane Chatty wrote:

> > The multitouch extensions to the HID protocol allows for contact
> > data to be sent over several reports, which is also the case for
> > the 3M M2256PW touchscreen. This patch modifies the logic to only
> > synchronize the input layer when all contacts have been received.
> > Consequentially, the full 60-finger capacity of the device is enabl=
ed.
> >=20
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> >  drivers/hid/hid-3m-pct.c |   22 ++++++++++++++++++----
> >  1 files changed, 18 insertions(+), 4 deletions(-)
>=20
> You can add
>=20
> Acked-by: Stephane Chatty <chatty@enac.fr>

Applied, thanks guys.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
