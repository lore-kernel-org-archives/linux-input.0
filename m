From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from
 matrix lines
Date: Fri, 28 Jun 2013 11:25:56 -0700
Message-ID: <20130628182556.GB21589@core.coreip.homeip.net>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-9-git-send-email-gsi@denx.de>
 <51C4C87B.3050300@wwwdotorg.org>
 <20130622100052.GH24305@book.gsilab.sittig.org>
 <51C8D599.2010706@wwwdotorg.org>
 <20130628075240.GU24305@book.gsilab.sittig.org>
 <51CD9F3E.9060003@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43780 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab3F1S0C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 14:26:02 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so2748323pab.22
        for <linux-input@vger.kernel.org>; Fri, 28 Jun 2013 11:26:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51CD9F3E.9060003@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Fri, Jun 28, 2013 at 08:35:42AM -0600, Stephen Warren wrote:
> On 06/28/2013 01:52 AM, Gerhard Sittig wrote:
> > 
> > [ late reply, just catching up with the backlog ]
> > 
> > On Mon, Jun 24, 2013 at 17:26 -0600, Stephen Warren wrote:
> >>
> >> [ ... sparse matrices, not all columns/rows populated ... ]
> 
> >> On some Tegra boards, there end up
> >> being rather tri-angular keymaps, where key positions (0, 0), (0, 1),
> >> (0, 2), (1, 1), (1, 2), (2, 2) end up being used. In this scenario,
> >> detailed investigation of the keymap would reveal:
> >>
> >> * Only scan columns 0..2
> >> * For column 0, scan rows 0..2
> >> * For column 1, scan rows 1..2
> >> * For columm 2, scan row 2.
> > 
> > That's another question I had.  So far I was concerned with just
> > polling or scanning the relevant columns, while all the rows for
> > a given column were queried (as the driver always used to do).
> > 
> > Now you raise the question of whether rows should get queried as
> > well depending on whether "a key may sit there".  It wasn't the
> > exact question I raised, but I added a comment to the spot where
> > input subsystem events get generated:  Is the driver expected to
> > emit events for matrix positions where no key map entry exists?
> 
> I would assume there is no need to, but I don't know for sure. Perhaps
> Dmitry can answer that?

It really depends whether the driver can absolutely be sure that the key
is not there or if it might be. Because keymaps are configurable from
userspace the driver should not make this decision based on keymap
itself.

When you scan a matrix and come upon the "pressed key" condition, you
supposed to emit EV_MSC/MSC_SCAN, followed by appropriate EV_KEY/KEY_*.
Normally the "keys that aren't there" generate KEY_RESERVED events that
are simply dropped by input core (cause it is easier to implement).
MSC_SCAN events, however, reach the userspace intact.

Hope this helps.

-- 
Dmitry
