From: simon@mungewell.org
Subject: Re: [PATCH] HID: Add support for pressure sensitive buttons
Date: Tue, 15 Nov 2011 12:10:54 -0500
Message-ID: <345d84857ccc04c9a413afeba8e2fe8e.squirrel@host171.canaca.com>
References: <1321304314-17424-1-git-send-email-sean@mess.org>
    <alpine.LNX.2.00.1111151523500.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50098 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab1KORLC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 12:11:02 -0500
In-Reply-To: <alpine.LNX.2.00.1111151523500.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sean Young <sean@mess.org>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org


>> +	report->field[0]->value[2] = 1; /* if this field is 0, then pressure
>> +		buttons won't be reported as digital button presses any more */

Hi all,
I may have missed earlier conversations around this subject, but is this
something we really want? I mean if a pressure sensitive button reports
both digital and analogue values at the HID level, shouldn't we pass both
onto userland.

Many games and applications may be coded to only see one or the other, and
break with usage of a controller which masks one or the other.

As an example SpeedDreams (racing car simulator) has configurable inputs
which sense what is pressed during the calibration process. It prefers to
use buttons for simple things (ie. turn lights on/off) and axis for
'analogue' things (ie brake/accel).

Until recently these functions could not be mixed; If a controller
presents all it's buttons as axis (and not additionally as buttons) then
none of them would have been usable in game.

SpeedDreams recently 'learnt' to treat axis for button functions, but
requires an additional calibration stage to determine which range of axis
value represents a simple control. This schema is not (/can not be)
perfect, and has some issues.

In the case where a controller is both a button and axis it can choose
which to use for the control, depending on the control.... please don't
take than away from it/me... :-)

In summary - please don't mask buttons where axis are also available, it
will break many user land applications.

Simon.

