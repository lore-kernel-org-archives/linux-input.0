From: Sundar <sunder.svit@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Fri, 15 Oct 2010 21:34:53 +0530
Message-ID: <AANLkTin=nbO-bciv14o4PRQSizpCKyf-+e8xo3fdMu+P@mail.gmail.com>
References: <Pine.LNX.4.44L0.1010140946030.1645-100000@iolanthe.rowland.org>
	<201010142100.58496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36499 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab0JOQEy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 12:04:54 -0400
Received: by iwn35 with SMTP id 35so1056946iwn.19
        for <linux-input@vger.kernel.org>; Fri, 15 Oct 2010 09:04:54 -0700 (PDT)
In-Reply-To: <201010142100.58496.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Fri, Oct 15, 2010 at 12:30 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
>>
>> There could be a new attribute file, or we could use a blank line
>> written to autosuspend_delay_ms for this purpose. =A0Either way, the
>> result would be to call pm_runtime_suspend. =A0If the device is idle=
,
>> merely awaiting the timer expiration for a scheduled suspend or
>> autosuspend, this would cause it to suspend immediately.
>

I personally think the blank line method is fine :). But yes, if we get
to hear something more from the Meego guys, then it would be more
better to fit everyone in.

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
