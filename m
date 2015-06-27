From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH v4] i8042: Add debug_kbd option
Date: Sat, 27 Jun 2015 22:35:43 +0200
Message-ID: <20150627203543.GA31870@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:57527 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbF0Ufp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Jun 2015 16:35:45 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Chandler Paul <cpaul@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

[no In-Reply-To header - lkml.org "headers" is broken ATM]

> +
> +static bool i8042_debug_kbd;
> +module_param_named(debug_kbd, i8042_debug_kbd, bool, 0600);
> +MODULE_PARM_DESC(i8042_kbd, "Turn i8042 kbd debugging output on or off
> (requires i8042.debug=1)");

seems inconsistent:
i8042_debug_kbd != debug_kbd != i8042_kbd
While the first two seem perfectly fine,
"i8042_kbd" sounds like a build error or similar to me, on the severity front.

(grepping kernel tree drivers/ on quick glance
does not seem to show any naming deviations in the MODULE_PARM_DESC area)


> "Turn i8042 kbd debugging output on or off (requires i8042.debug=1)"
should be improved to
  "Turn i8042 kbd debugging output on (requires i8042.debug=1)"
(it *is* default-off)
The point is that it
(at least now that it reached current implementation version?)
merely *enables* additional output,
it does *not* actively *disable* (veto)
something which may have been default-enabled elsewhere.


Also, since this is about "special" situations only
(many standard situations already have this output enabled),
it should be worded to somehow include this "special" enabling.

Also, I'd prefer to also see the *reason*
for it being default-disabled in modinfo output.

Also, "i8042" is useless (since completely scope-superfluous) information
(this *is* i8042 driver)

So perhaps wording in total could be something like
"Turn kbd debugging output unconditionally on (may reveal sensitive data)"
or possibly best
"Unconditional enable (may reveal sensitive data) of normally sanitize-filtered kbd data traffic log"

and in combination:
"[DESCRIPTION] (pre-condition: i8042.debug=1 enabled)"

"kbd debugging output"
could be shortened to
"kbd debug log"

So, a final suggestion might be:
"Unconditional enable (may reveal sensitive data) of normally sanitize-filtered kbd data traffic debug log [pre-condition: i8042.debug=1 enabled]"


And given that this description is now completely different,
one might choose to rename debug_kbd variable
to something more specific, too
("debug_full" / "debug_data" / "debug_traffic"?).


> +	i8042.debug_kbd [HW] Enable printing of interrupt data from the
> KBD port
> +			     (disabled by default, requires that
> i8042.debug=1
> +			     be enabled)
is not correct - code implementation definitely conveys
that it needs to be "*and* requires"
(especially since current wording strongly suggests that
*while it's default-disabled*,
i8042.debug_kbd will be implicitly enabled once i8042.debug=1 is available,
which is wrong).

Perhaps write it as something like
"and as pre-condition requires i8042.debug=1 to be enabled too".



Definitely very good to see this (quote) "big problem" corrected!

Thanks,

Andreas Mohr
