From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BISECTED] Re: psmouse.c: GlidePoint at isa0060/serio1/input0
	lost sync at byte 1
Date: Wed, 16 Jan 2008 10:42:42 -0500
Message-ID: <20080116104024.ZZRA012@mailhub.coreip.homeip.net>
References: <19f34abd0711141226n60323630rdc4833db0bfb2eeb@mail.gmail.com> <19f34abd0801071224kb9cb121u244b00b274231db0@mail.gmail.com> <d120d5000801110647k4b1fa49ene974898baf745aec@mail.gmail.com> <478CFB56.1030700@gmail.com> <20080115154142.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755162AbYAPPnE@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080115154142.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, William Pettersson <william.pettersson@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 15, 2008 at 03:49:12PM -0500, Dmitry Torokhov wrote:
> Hi Vegard,
> 
> On Tue, Jan 15, 2008 at 07:28:38PM +0100, Vegard Nossum wrote:
> > # up/down scroll button
> > drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, 0, 1) [592682]
> > drivers/input/serio/i8042.c: df <- i8042 (interrupt, 1, 12) [596318]
> > psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> > drivers/input/serio/i8042.c: 21 <- i8042 (interrupt, 1, 12) [596321]
> > psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> > drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, 1, 12) [596323]
> > psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> > drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, 1, 12) [596325]
> > drivers/input/serio/i8042.c: 67 <- i8042 (interrupt, 1, 12) [596328]
> > drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [596331]
> 
> Thank you for the debug data. It looks like the scroll buttons on your
> box send 0xdf instead of 0xcf. That should be pretty easy to fix, please
> stay tuned.
> 

Ok, how about this one to begin with?

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mouse/alps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/input/mouse/alps.c
===================================================================
--- linux.orig/drivers/input/mouse/alps.c
+++ linux/drivers/input/mouse/alps.c
@@ -54,7 +54,7 @@ static const struct alps_model_info alps
 	{ { 0x20, 0x02, 0x0e },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* XXX */
 	{ { 0x22, 0x02, 0x0a },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
-	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xff, ALPS_FW_BK_1 } /* Dell Vostro 1400 */
+	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FW_BK_1 } /* Dell Vostro 1400 */
 };
 
 /*

-- 
Dmitry
