From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v1] input: tegra-kbc: Add Function keymap.
Date: Wed, 9 Feb 2011 09:21:36 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A0080B7@HQMAIL03.nvidia.com>
References: <1297198584-4282-1-git-send-email-riyer@nvidia.com>
 <20110209084948.GB7256@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:13506 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab1BIRVp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Feb 2011 12:21:45 -0500
In-Reply-To: <20110209084948.GB7256@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "olofj@chromium.org" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

> >  	KEY(6, 0, KEY_MINUS),
> >  	KEY(6, 1, KEY_0),
> > @@ -125,6 +131,12 @@ static const u32 tegra_kbc_default_keymap[] = {
> >  	KEY(6, 5, KEY_K),
> >  	KEY(6, 6, KEY_COMMA),
> >  	KEY(6, 7, KEY_M),
> > +	KEY(6, 9, KEY_SLASH),
> > +	KEY(6, 10, KEY_6),
> > +	KEY(6, 11, KEY_5),
> > +	KEY(6, 12, KEY_3),
> > +	KEY(6, 13, KEY_2),
> > +	KEY(6, 15, KEY_0),
> >
> >  	KEY(7, 1, KEY_EQUAL),
> >  	KEY(7, 2, KEY_RIGHTBRACE),
> > @@ -143,6 +155,10 @@ static const u32 tegra_kbc_default_keymap[] = {
> >  	KEY(11, 3, KEY_SEMICOLON),
> >  	KEY(11, 4, KEY_SLASH),
> >  	KEY(11, 5, KEY_DOT),
> > +	KEY(11, 9, KEY_KPASTERISK),
> > +	KEY(11, 11, KEY_KPMINUS),
> > +	KEY(11, 12, KEY_KPPLUS),
> > +	KEY(11, 13, KEY_DOT),
> >
> >  	KEY(12, 0, KEY_F10),
> >  	KEY(12, 1, KEY_F9),
> > @@ -152,6 +168,7 @@ static const u32 tegra_kbc_default_keymap[] = {
> >  	KEY(12, 5, KEY_UP),
> >  	KEY(12, 6, KEY_PRINT),
> >  	KEY(12, 7, KEY_PAUSE),
> > +	KEY(12, 13, KEY_VOLUMEUP),
> >
> >  	KEY(13, 0, KEY_INSERT),
> >  	KEY(13, 1, KEY_DELETE),
> > @@ -160,6 +177,11 @@ static const u32 tegra_kbc_default_keymap[] = {
> >  	KEY(13, 5, KEY_RIGHT),
> >  	KEY(13, 6, KEY_DOWN),
> >  	KEY(13, 7, KEY_LEFT),
> > +	KEY(13, 11, KEY_HOME),
> > +	KEY(13, 12, KEY_END),
> > +	KEY(13, 13, KEY_BRIGHTNESSDOWN),
> > +	KEY(13, 14, KEY_VOLUMEDOWN),
> > +	KEY(13, 15, KEY_BRIGHTNESSUP),
> >
> >  	KEY(14, 0, KEY_F11),
> >  	KEY(14, 1, KEY_F12),
> > @@ -169,6 +191,9 @@ static const u32 tegra_kbc_default_keymap[] = {
> >  	KEY(14, 5, KEY_F3),
> >  	KEY(14, 6, KEY_1),
> >  	KEY(14, 7, KEY_F7),
> > +	KEY(14, 8, KEY_NUMLOCK),
> > +	KEY(14, 9, KEY_SCROLLLOCK),
> > +	KEY(14, 10, KEY_MUTE),
> >
> >  	KEY(15, 0, KEY_ESC),
> >  	KEY(15, 1, KEY_GRAVE),
> > @@ -178,6 +203,7 @@ static const u32 tegra_kbc_default_keymap[] = {
> >  	KEY(15, 5, KEY_F2),
> >  	KEY(15, 6, KEY_CAPSLOCK),
> >  	KEY(15, 7, KEY_F6),
> > +	KEY(15, 12, KEY_QUESTION),
> 
> Not KEY_SLASH or similar?
> 
> --
> Dmitry

Actually in this keyboard layout that key indeed maps to KEY_QUESTION and not KEY_SLASH.
Is that unexpected.

Regards
Rakesh
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
