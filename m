From: Gabor Balla <gaborwho@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Fri, 21 Aug 2015 00:42:13 +0200
Message-ID: <CAMmwwr-7dR7oOCbxpUuZhFnzh5LJ5gGECowfrjs-jjFz-h9isA@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:33284 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbHTWmP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 18:42:15 -0400
Received: by lbcue2 with SMTP id ue2so2525200lbc.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 15:42:13 -0700 (PDT)
In-Reply-To: <CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Dmitry,

I've prepared another possible fix, that checks the current mode for Wmode bit.

Regards,
Gabor

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 6025eb4..7ec72a6 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -519,15 +519,19 @@ static int synaptics_set_mode(struct psmouse *psmouse)
        struct synaptics_data *priv = psmouse->private;

        priv->mode = 0;
+
        if (priv->absolute_mode)
                priv->mode |= SYN_BIT_ABSOLUTE_MODE;
-       if (priv->disable_gesture)
-               priv->mode |= SYN_BIT_DISABLE_GESTURE;
+
        if (psmouse->rate >= 80)
                priv->mode |= SYN_BIT_HIGH_RATE;
+
        if (SYN_CAP_EXTENDED(priv->capabilities))
                priv->mode |= SYN_BIT_W_MODE;

+       if (!SYN_MODE_WMODE(priv->mode) && priv->disable_gesture)
+               priv->mode |= SYN_BIT_DISABLE_GESTURE;
+
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
