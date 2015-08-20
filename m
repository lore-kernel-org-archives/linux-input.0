From: Gabor Balla <gaborwho@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Thu, 20 Aug 2015 22:50:27 +0200
Message-ID: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f68.google.com ([209.85.215.68]:35303 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbbHTUu2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 16:50:28 -0400
Received: by labia3 with SMTP id ia3so2490889lab.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 13:50:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I could also reproduce this issue using a T450s, but have probably found the
issue behind it.

At some point a new PS/2 mode was introduced by Synaptics, called EWmode. This
can be enabled by setting bit 2 of the mode byte. But previously this bit was
used for 'Disable Gesture', whatever that stands for, and it was reused for
selecting EWmode. Now if plain Wmode is selected, with bit 0 of the mode byte,
than disable gesture is on by default and bit 2 selects EWmode instead.

Reference:
http://www.synaptics.com/sites/default/files/511-000275-01_RevB.pdf

The current implementation of the driver doesn't take EWmode into account, and
enables it, when setting both Wmode and what it thinks to be the disable
gesture bit. It is probably selecting EWmode that causes the glitch.

A quick fix follows:

diff -ru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c2015-08-20 22:25:05.261546729 +0200
+++ b/drivers/input/mouse/synaptics.c2015-08-20 22:21:28.560038539 +0200
@@ -521,7 +521,7 @@
 priv->mode = 0;
 if (priv->absolute_mode)
 priv->mode |= SYN_BIT_ABSOLUTE_MODE;
-if (priv->disable_gesture && !SYN_CAP_EXTENDED(priv->capabilities))
+if (priv->disable_gesture)
 priv->mode |= SYN_BIT_DISABLE_GESTURE;
 if (psmouse->rate >= 80)
 priv->mode |= SYN_BIT_HIGH_RATE;

Regards,
Gabor
