From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev3)
Date: Fri, 21 May 2010 19:49:42 +0200
Message-ID: <4BF6C7B6.2020008@euromail.se>
References: <1274457354-5570-1-git-send-email-rydberg@euromail.se> <AANLkTikBWzgRmso0oQNXcTxeExdKZORXYbIwK9CcMl85@mail.gmail.com> <4BF6B673.1080507@euromail.se> <20100521165218.GA26439@core.coreip.homeip.net> <4BF6BB43.2020405@euromail.se> <20100521172222.GB26439@core.coreip.homeip.net> <4BF6C303.7030804@euromail.se> <20100521174140.GA23155@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:45468 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754509Ab0EURt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 13:49:59 -0400
In-Reply-To: <20100521174140.GA23155@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Dmitry Torokhov wrote:
> 
> I guess this is where our disconnect lies as when I am looking at the
> event names I view all *_MT_* events as related to the multitouch
> protocol handling.
> 

Yes. It is true that slot control is MT related, but I am looking at this from
the perspective of future expansions like KEY_MT,  KEY_REL, and such, finding a
way to signal to user space which events are handled via slots. If we had
ABS_MT_SLOT, we would most likely get applications which store ABS_MT_SLOT as an
attribute of the slot together with ABS_MT_POSITION_X, ABS_MT_TOUCH_MAJOR, etc,
which is just not right. So the proposal is ABS_SLOT. May we have your verdict,
please. :-)

Henrik
