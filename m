From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Thu, 20 Aug 2015 14:35:26 -0700
Message-ID: <20150820213526.GA10980@localhost>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35243 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbHTVfb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 17:35:31 -0400
Received: by pdob1 with SMTP id b1so18457750pdo.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 14:35:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Balla <gaborwho@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Gabor,

On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
> Hi,
> 
> I could also reproduce this issue using a T450s, but have probably found the
> issue behind it.
> 
> At some point a new PS/2 mode was introduced by Synaptics, called EWmode. This
> can be enabled by setting bit 2 of the mode byte. But previously this bit was
> used for 'Disable Gesture', whatever that stands for, and it was reused for
> selecting EWmode. Now if plain Wmode is selected, with bit 0 of the mode byte,
> than disable gesture is on by default and bit 2 selects EWmode instead.
> 
> Reference:
> http://www.synaptics.com/sites/default/files/511-000275-01_RevB.pdf
> 
> The current implementation of the driver doesn't take EWmode into account, and
> enables it, when setting both Wmode and what it thinks to be the disable
> gesture bit. It is probably selecting EWmode that causes the glitch.
> 
> A quick fix follows:
> 
> diff -ru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> --- a/drivers/input/mouse/synaptics.c2015-08-20 22:25:05.261546729 +0200
> +++ b/drivers/input/mouse/synaptics.c2015-08-20 22:21:28.560038539 +0200
> @@ -521,7 +521,7 @@
>  priv->mode = 0;
>  if (priv->absolute_mode)
>  priv->mode |= SYN_BIT_ABSOLUTE_MODE;
> -if (priv->disable_gesture && !SYN_CAP_EXTENDED(priv->capabilities))
> +if (priv->disable_gesture)

It looks like the patch "direction" is reverted. Also, the presence of
extended capabilities is not the indication that gesture mode should not
be used: in relative mode bit 2 disables gesture reporting, in absolute
mode it enables Extended W-mode.

Does the patch below also work for you?

Thanks.

-- 
Dmitry


Input: synaptics - fix handling of disabling gesture mode

Bit 2 of the mode byte only disables gesture reporting when touchpad is in
relative mode, when in absolute mode it activates the so-called Extended
W-mode that confuses driver and causes missing button presses on some
Thinkpads (x250, T450s).

Reported-by: Nick Bowler <nbowler@draconx.ca>
Suggested-by: Gabor Balla <gaborwho@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 28daca1..97c5dde 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -519,12 +519,15 @@ static int synaptics_set_mode(struct psmouse *psmouse)
 	struct synaptics_data *priv = psmouse->private;
 
 	priv->mode = 0;
+
 	if (priv->absolute_mode)
 		priv->mode |= SYN_BIT_ABSOLUTE_MODE;
-	if (priv->disable_gesture)
+	else if (priv->disable_gesture)
 		priv->mode |= SYN_BIT_DISABLE_GESTURE;
+
 	if (psmouse->rate >= 80)
 		priv->mode |= SYN_BIT_HIGH_RATE;
+
 	if (SYN_CAP_EXTENDED(priv->capabilities))
 		priv->mode |= SYN_BIT_W_MODE;
 
@@ -1482,7 +1485,7 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	}
 
 	priv->absolute_mode = absolute_mode;
-	if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
+	if (!absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity))
 		priv->disable_gesture = true;
 
 	/*
