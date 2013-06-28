From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from
 matrix lines
Date: Fri, 28 Jun 2013 09:52:40 +0200
Message-ID: <20130628075240.GU24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-9-git-send-email-gsi@denx.de>
 <51C4C87B.3050300@wwwdotorg.org>
 <20130622100052.GH24305@book.gsilab.sittig.org>
 <51C8D599.2010706@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40850 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab3F1Hwp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 03:52:45 -0400
Content-Disposition: inline
In-Reply-To: <51C8D599.2010706@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>


[ late reply, just catching up with the backlog ]

On Mon, Jun 24, 2013 at 17:26 -0600, Stephen Warren wrote:
> 
> [ ... sparse matrices, not all columns/rows populated ... ]
> 
> Looking at this from the approach of the keymap data: Why does the DT
> need to say "these columns are used" or "these rows are used"? That data
> is already available from a simple search of the keymap for the various
> row-/column-IDs. Let the driver or keymap parser calculate the set of
> valid rows/columns when the keymap is installed. With this approach, you
> could even get far more optimal.

I agree that this reduces pain for .dts authors, which is a very
good thing.  They need to provide the key map anyway, and the set
of interconnections in the matrix can thus get determined
programmatically.  Data overhead should be acceptable given the
maximum matrix dimensions of 32x32.  I'll look into this ...

> On some Tegra boards, there end up
> being rather tri-angular keymaps, where key positions (0, 0), (0, 1),
> (0, 2), (1, 1), (1, 2), (2, 2) end up being used. In this scenario,
> detailed investigation of the keymap would reveal:
> 
> * Only scan columns 0..2
> * For column 0, scan rows 0..2
> * For column 1, scan rows 1..2
> * For columm 2, scan row 2.

That's another question I had.  So far I was concerned with just
polling or scanning the relevant columns, while all the rows for
a given column were queried (as the driver always used to do).

Now you raise the question of whether rows should get queried as
well depending on whether "a key may sit there".  It wasn't the
exact question I raised, but I added a comment to the spot where
input subsystem events get generated:  Is the driver expected to
emit events for matrix positions where no key map entry exists?
OTOH was my further reasoning that in theory the keymap shall
reflect the hardware implementation, so users should not be able
to press keys which don't have a corresponding key map entry.
And switching or modifying key maps from software shall cope with
the fact when "raw keys" get reported which don't carry a code.

Enter the above row/column filter based on the keymap:  Only
controlling those pins where interconnections have a keymap entry
(an operation that's cheap) reduces access to GPIOs (which may or
may not be expensive in "abolute" terms, but certainly is more
expensive than a keymap check), and eliminiates the issue of
emitting events which lack codes.  Sounds like the appropriate
solution to the problem.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
