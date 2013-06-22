From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from
 matrix lines
Date: Sat, 22 Jun 2013 12:00:52 +0200
Message-ID: <20130622100052.GH24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-9-git-send-email-gsi@denx.de>
 <51C4C87B.3050300@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:37126 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab3FVKBC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jun 2013 06:01:02 -0400
Content-Disposition: inline
In-Reply-To: <51C4C87B.3050300@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Fri, Jun 21, 2013 at 15:41 -0600, Stephen Warren wrote:
> 
> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> 
> > +The driver assumes that all interconnections of the matrix can potentially
> > +contain a button, and will submit scan and key code events to the input
> > +subsystem.  By default the keypad matrix dimenstions are automatically
> > +derived from the GPIO pin specifications.  Optionally device tree
> > +information can override the keypad matrix dimension data, e.g. when not
> > +all of the potentially available physical connections are used to create
> > +the logical keypad matrix.
> 
> Ignoring the binary encoding in the next patch, why would someone ever
> define more row GPIOs that there are rows (or similarly for columns)?
> 
> On its own, I don't think this patch is needed.

Well, the keypad's property (remember the layering between keypad
and keymap) has already been there, I just made the matrix keypad
driver actually use the keymap's DT parse call.

Regarding the usefulness of the patch in the absence of binary
encodings which only later get introduced:  I can't tell how much
of a stretch it's going to get perceived as, but I suggested
this:

A .dtsi may specify the GPIO pins for a keypad attachment (say,
the SoC's or module's "potential to drive a matrix", the physical
perspective), while boards' .dts files may specify the keymap and
its specific layout (the logical matrix description).

Not populating logical lines of the matrix will hardly influence
the scan time as status changes were detected, and it won't
generate key events where interconnects are missing.  But it
might be desirable to not iterate over empty lines when polling
is used to detect changes.  Polling was introduced in an earlier
part of the series, and allows for reliable detection of multi
key press events.  So sparse matrices are useful without binary
encodings as well.

> Now, if you add binary encoding, I can see that you might have say 3 row
> GPIOs but only say 6 rows even though there are 8 combinations of row
> GPIO values. If that is the situation this patch is intended to cover,
> the changes here should be introduced as part of, and only applicable
> to, the binary encoding patch instead.

I feel that although binary encoding was what I needed in the
end, all the other steps taken to get there (except for the last
one with the encoding) are of benefit for others as well.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
