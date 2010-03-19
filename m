From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Input: implement sysrq as an input handler
Date: Fri, 19 Mar 2010 13:06:41 -0300
Message-ID: <20100319160641.GC16743@khazad-dum.debian.net>
References: <20100317061952.GA19789@core.coreip.homeip.net>
 <20100319000043.GC12017@khazad-dum.debian.net>
 <20100319000931.GA5671@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46922 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751323Ab0CSQGp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Mar 2010 12:06:45 -0400
Content-Disposition: inline
In-Reply-To: <20100319000931.GA5671@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason Wessel <jason.wessel@windriver.com>

On Thu, 18 Mar 2010, Dmitry Torokhov wrote:
> On Thu, Mar 18, 2010 at 09:00:43PM -0300, Henrique de Moraes Holschuh wrote:
> > Any chance of the user being able to avoid the SysRQ events getting to the
> > handle, e.g. by opening the input device in exclusive mode or something like
> > that?
> 
> Yes, it is a possible to suppress SysRq by grabbing an input device.
> This possibility exisst with the current implementation too though -
> after all legacy keyboard driver implemented as an input handler as
> well.
> 
> ... or am I answering a question different from the one you asked? ;)

No, that's exactly what I wanted to know.

What about SAK?  That thing *has* to be untrappable.

Even for the SysRQ debug events, I'd feel better if we could have a class of
system input handlers that cannot be suppressed to use for these things.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
