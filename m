From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/3] Input: synaptics - multitouch and multifinger support
Date: Sun, 10 Oct 2010 09:49:45 +0200
Message-ID: <4CB17019.7070002@euromail.se>
References: <1286549880-32580-1-git-send-email-chase.douglas@canonical.com> <s5hfwwg4p4t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:41211 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752524Ab0JJHt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Oct 2010 03:49:59 -0400
In-Reply-To: <s5hfwwg4p4t.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org

Takashi, Chase,

talk about Heinz effect. :-)

Rather than taking any of the patches, I was wondering if we could get a single
patch including all the later findings and considerations on what devices should
have the multitouch mode. Also, unless there is a really really good reason for
it, without kernel parameters. After all, these patches should only add new
functionality without regressions.

Regarding the clickpad functionality, it is similar to the macbook pads with
integrated buttons, which has been implemented in userspace.

Regarding the tracking aspect of pointer emulation, Chase is completely right,
and this is a generic problem for several drivers. Tracking a single point by
picking the closest contact is a linear problem and could easily be performed in
interrupt context. I suggest we add it directly to the synaptics driver and then
revisit the question of adding generic tracking support to the kernel. Dmitry,
how does that sound to you?

Cheers,
Henrik
