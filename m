From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] input: tegra-kbc: Add Function keymap.
Date: Tue, 15 Feb 2011 10:54:50 -0800
Message-ID: <20110215185450.GB19688@core.coreip.homeip.net>
References: <1297198584-4282-1-git-send-email-riyer@nvidia.com>
 <20110209084948.GB7256@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080B7@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46091 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab1BOSzA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 13:55:00 -0500
Received: by iwn9 with SMTP id 9so471131iwn.19
        for <linux-input@vger.kernel.org>; Tue, 15 Feb 2011 10:54:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D03165A0080B7@HQMAIL03.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "olofj@chromium.org" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

On Wed, Feb 09, 2011 at 09:21:36AM -0800, Rakesh Iyer wrote:
> > >
> > >  	KEY(15, 0, KEY_ESC),
> > >  	KEY(15, 1, KEY_GRAVE),
> > > @@ -178,6 +203,7 @@ static const u32 tegra_kbc_default_keymap[] = {
> > >  	KEY(15, 5, KEY_F2),
> > >  	KEY(15, 6, KEY_CAPSLOCK),
> > >  	KEY(15, 7, KEY_F6),
> > > +	KEY(15, 12, KEY_QUESTION),
> > 
> > Not KEY_SLASH or similar?
> > 
> Actually in this keyboard layout that key indeed maps to KEY_QUESTION and not KEY_SLASH.
> Is that unexpected.
> 

So it is a dedicated key for a question mark? KEY_QUESTION is not really
that although we could re-purpose it (the USB keyboard that is currently
using this keycode most likely wants KEY_HELP or similar).

Is there a picture of physical keypad somewhere?

-- 
Dmitry
