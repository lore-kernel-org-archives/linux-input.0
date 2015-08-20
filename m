From: Gabor Balla <gaborwho@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Fri, 21 Aug 2015 01:35:47 +0200
Message-ID: <CAMmwwr_ZGvMODEHEawV+06tWmtoA5pYZAx1dYX1x4CopybmtqA@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
	<CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
	<20150820230840.GB12900@localhost>
	<20150820231339.GA7236@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f67.google.com ([209.85.215.67]:36820 "EHLO
	mail-la0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbHTXft (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 19:35:49 -0400
Received: by labd1 with SMTP id d1so2666722lab.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 16:35:47 -0700 (PDT)
In-Reply-To: <20150820231339.GA7236@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Dmitry,

> How about this one?

It looks fine for me, I've also tested it and it works.
Still, can we do something about synaptics_set_disable_gesture() function too?
Not sure what it does, but it certainly looks like it could break EWmode.
I've included a possible solution.

Regards,
Gabor

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 6025eb4..60ec964 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -519,14 +519,18 @@ static int synaptics_set_mode(struct psmouse *psmouse)
        struct synaptics_data *priv = psmouse->private;

        priv->mode = 0;
-       if (priv->absolute_mode)
+
+       if (priv->absolute_mode) {
                priv->mode |= SYN_BIT_ABSOLUTE_MODE;
-       if (priv->disable_gesture)
+               if (SYN_CAP_EXTENDED(priv->capabilities))
+                       priv->mode |= SYN_BIT_W_MODE;
+       }
+
+       if (!SYN_MODE_WMODE(priv->mode) && priv->disable_gesture)
                priv->mode |= SYN_BIT_DISABLE_GESTURE;
+
        if (psmouse->rate >= 80)
                priv->mode |= SYN_BIT_HIGH_RATE;
-       if (SYN_CAP_EXTENDED(priv->capabilities))
-               priv->mode |= SYN_BIT_W_MODE;

        if (synaptics_mode_cmd(psmouse, priv->mode))
                return -1;
@@ -1280,6 +1284,10 @@ static ssize_t
synaptics_set_disable_gesture(struct psmouse *psmouse,
                return len;

        priv->disable_gesture = value;
+
+       if (SYN_MODE_WMODE(priv->mode))
+               return len;
+
        if (value)
                priv->mode |= SYN_BIT_DISABLE_GESTURE;
        else
