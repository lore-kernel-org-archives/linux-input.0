From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from
 matrix lines
Date: Sun, 30 Jun 2013 14:03:07 +0200
Message-ID: <20130630120307.GB24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-9-git-send-email-gsi@denx.de>
 <51C4C87B.3050300@wwwdotorg.org>
 <20130622100052.GH24305@book.gsilab.sittig.org>
 <51C8D599.2010706@wwwdotorg.org>
 <20130628075240.GU24305@book.gsilab.sittig.org>
 <51CD9F3E.9060003@wwwdotorg.org>
 <20130628182556.GB21589@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59822 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3F3MDR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 08:03:17 -0400
Content-Disposition: inline
In-Reply-To: <20130628182556.GB21589@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, devicetree-discuss@lists.ozlabs.org, Chao Xie <xiechao.mail@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 28, 2013 at 11:25 -0700, Dmitry Torokhov wrote:
> 
> On Fri, Jun 28, 2013 at 08:35:42AM -0600, Stephen Warren wrote:
> > On 06/28/2013 01:52 AM, Gerhard Sittig wrote:
> > > 
> > > [ late reply, just catching up with the backlog ]
> > > 
> > > On Mon, Jun 24, 2013 at 17:26 -0600, Stephen Warren wrote:
> > >>
> > >> [ ... sparse matrices, not all columns/rows populated ... ]
> > 
> > >> On some Tegra boards, there end up
> > >> being rather tri-angular keymaps, where key positions (0, 0), (0, 1),
> > >> (0, 2), (1, 1), (1, 2), (2, 2) end up being used. In this scenario,
> > >> detailed investigation of the keymap would reveal:
> > >>
> > >> * Only scan columns 0..2
> > >> * For column 0, scan rows 0..2
> > >> * For column 1, scan rows 1..2
> > >> * For columm 2, scan row 2.
> > > 
> > > That's another question I had.  So far I was concerned with just
> > > polling or scanning the relevant columns, while all the rows for
> > > a given column were queried (as the driver always used to do).
> > > 
> > > Now you raise the question of whether rows should get queried as
> > > well depending on whether "a key may sit there".  It wasn't the
> > > exact question I raised, but I added a comment to the spot where
> > > input subsystem events get generated:  Is the driver expected to
> > > emit events for matrix positions where no key map entry exists?
> > 
> > I would assume there is no need to, but I don't know for sure. Perhaps
> > Dmitry can answer that?
> 
> It really depends whether the driver can absolutely be sure that the key
> is not there or if it might be. Because keymaps are configurable from
> userspace the driver should not make this decision based on keymap
> itself.
> 
> When you scan a matrix and come upon the "pressed key" condition, you
> supposed to emit EV_MSC/MSC_SCAN, followed by appropriate EV_KEY/KEY_*.
> Normally the "keys that aren't there" generate KEY_RESERVED events that
> are simply dropped by input core (cause it is easier to implement).
> MSC_SCAN events, however, reach the userspace intact.

OK, so I understand that
- filtering events based on the keymap entry being present would
  be inappropriate, the driver MUST emit key press events even if
  no key code is mapped to that position (especially since keymap
  entries may get modified at runtime)
- it's perfectly appropriate for a driver to assume that _any_
  intersection in the matrix _may_ carry a key, and scan for
  changes on that position, to derive input events (this is what
  the current implementation of the matrix driver does)
- it's an _option_ whether the theoretically possible set of key
  positions further gets reduced to some "really physically
  present" and thus "to get scanned only" set, which currently
  isn't done and isn't mandatory, as in theory absent keys cannot
  lead to changes and thus should never result in input events

So optionally reducing the set of "to get scanned" positions is
some kind of micro-optimization (depending on the cost of GPIO
access, or in the polling scenario depending on how many columns
are empty).


My patch did not introduce the filter with new keywords, it just
made the existing driver use an existing DT parse routine which
scans for already documented properties of the keymap helper.
This simple approach assumes that the populated set always is in
the range from 0 .. N-1, sparse layouts beyond that simple
approach are possible and get processed correctly in the driver,
but cannot get described in the device tree.  Which still results
in non-optimized but correct behaviour.

Finer grained control beyond what my patch addresses would be
possible but remain an option for later improvement (if desire is
big enough to describe non-square layouts or sparse layouts where
the gaps are in any arbitrary position).

> Hope this helps.

Yes, your response answers a question that I raised elsewhere in
the form of a TODO comment, that now has become obsolete.  I will
reword it to not raise the question, but to mention that emitting
input events for key positions even in the absence of a key code
is not just desirable but actually required.

Thank you!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
