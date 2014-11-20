From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bisected two-finger scrolling regression on Lenovo Y50 (Re:
 [PATCH 1/5] Input: elantech - use elantech_report_trackpoint for hardware v4
 too)
Date: Wed, 19 Nov 2014 23:42:07 -0800
Message-ID: <20141120074207.GA30434@dtor-ws>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
 <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org>
 <546D9120.1040703@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44190 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaKTHmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 02:42:12 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so2255452iec.38
        for <linux-input@vger.kernel.org>; Wed, 19 Nov 2014 23:42:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <546D9120.1040703@mit.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
Cc: Ulrik De Bie <ulrik.debie-os@e2big.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Marcus Overhagen <marcus.overhagen@gmail.com>

Hi Anders,

On Thu, Nov 20, 2014 at 01:58:40AM -0500, Anders Kaseorg wrote:
> On 08/30/2014 10:10 AM, Ulrik De Bie wrote:
> >The Fujitsu H730 has hardware v4 with a trackpoint. This enables
> >the elantech_report_trackpoint for v4.
> 
> Kernel 3.18-rc5 has made two-finger scrolling unusably glitchy on my
> Lenovo Y50-70 Touch, and caused an associated kernel warning.  I
> bisected the regression to this commit (caeb0d37).
> 
> This may be the same as https://bugzilla.redhat.com/1165390,
> although that only reports the warning, not the glitchy scrolling.
> 

Thank you for your report. Please try the patch below.

Markus, I put you as tested-by since you tried basically the same patch
earlier.

-- 
Dmitry


Input: elantech - trust firmware about trackpoint presence

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Only try to parse data as coming from trackpoint if firmware told us that
trackpoint is present.

Fixes commit caeb0d37fa3e387eb0dd22e5d497523c002033d1

Reported-and-tested-by: Marcus Overhagen <marcus.overhagen@gmail.com>
Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 3fcb6b3..f2b9780 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -428,14 +428,6 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 	int x, y;
 	u32 t;
 
-	if (dev_WARN_ONCE(&psmouse->ps2dev.serio->dev,
-			  !tp_dev,
-			  psmouse_fmt("Unexpected trackpoint message\n"))) {
-		if (etd->debug == 1)
-			elantech_packet_dump(psmouse);
-		return;
-	}
-
 	t = get_unaligned_le32(&packet[0]);
 
 	switch (t & ~7U) {
@@ -793,7 +785,7 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	unsigned char packet_type = packet[3] & 0x03;
 	bool sanity_check;
 
-	if ((packet[3] & 0x0f) == 0x06)
+	if (etd->tp_dev && (packet[3] & 0x0f) == 0x06)
 		return PACKET_TRACKPOINT;
 
 	/*
