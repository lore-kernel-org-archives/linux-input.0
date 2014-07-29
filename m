From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: change logging level of log messages related
 to unexpected reports
Date: Tue, 29 Jul 2014 11:10:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291109380.16390@pobox.suse.cz>
References: <1405114551-24354-1-git-send-email-aduggan@synaptics.com> <1405114551-24354-2-git-send-email-aduggan@synaptics.com> <20140715190723.GC21045@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140715190723.GC21045@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Benjamin_Tissoires_=A0?= <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 15 Jul 2014, Benjamin Tissoires =C2=A0 wrote:

> On Jul 11 2014 or thereabouts, Andrew Duggan wrote:
> > Userspace tools may use hidraw to perform operations on the device =
from userspace while
> > hid-rmi is bound to the device. This can cause hid-rmi to print err=
or messages when its
> > ->raw_event() callback gets called as the reports pass through the =
HID stack. In this case
> > receiving responses which were not initiated by hid-rmi is not actu=
ally an error so the resulting
> > error messages are incorrect and misleading. This patch changes the=
 log messages to debug so
> > that the messages can be turned on in the event that there is a pro=
blem and there is not
> > a userspace tool running.
> >=20
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > ---
>=20
> Fair enough
>=20
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ sorry for late response, I am just re-appearing from vacation-land ]

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
