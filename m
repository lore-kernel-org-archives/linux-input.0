From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: picolcd: sanity check report size in raw_event()
 callback
Date: Wed, 27 Aug 2014 23:32:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408272331250.21233@pobox.suse.cz>
References: <alpine.LNX.2.00.1408270911130.2992@pobox.suse.cz> <alpine.LNX.2.00.1408270912310.2992@pobox.suse.cz> <20140827101311.098f3fd1@pluto> <alpine.LNX.2.00.1408271025040.2992@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1408271025040.2992@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 27 Aug 2014, Jiri Kosina wrote:

> > Is it worth adding report->id to this hid_warn()?
> >=20
> > A valid device is not expected to ever send >64 bytes reports but i=
n
> > case a firmware update would do so it would help to know for which
> > report it was.
>=20
> It definitely wouldn't hurt. Pull request with the original patch is =
now=20
> on its way to Linus though, so let's do this as a followup patch on t=
op=20
> once this is merged.

I've just queued the below for 3.18.



=46rom: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: picolcd: be more verbose when reporting report si=
ze error

picolcd device is not expected to send any report with size larger than=
 64=20
bytes.

If this impossible event happens (sic!), print also a report ID to allo=
w=20
for easier debugging.

Suggested-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-picolcd_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_c=
ore.c
index 020df3c..c1b29a9 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -351,8 +351,8 @@ static int picolcd_raw_event(struct hid_device *hde=
v,
 		return 1;
=20
 	if (size > 64) {
-		hid_warn(hdev, "invalid size value (%d) for picolcd raw event\n",
-				size);
+		hid_warn(hdev, "invalid size value (%d) for picolcd raw event (%d)\n=
",
+				size, report->id);
 		return 0;
 	}
=20
--=20
Jiri Kosina
SUSE Labs
