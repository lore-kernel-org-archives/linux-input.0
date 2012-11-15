From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] staging: ste_rmi4: merge into the main kernel tree
Date: Thu, 15 Nov 2012 18:41:26 +0100
Message-ID: <CACRpkdZtsTpNiRBzs3rUz48AvoZ4UpcrO-4__xmsb0XezUVFtg@mail.gmail.com>
References: <20121103013623.0f3a1b28168a9a42881b0b00@tw.synaptics.com>
	<20121113201212.8550fb074e1f7cce78f29d97@tw.synaptics.com>
	<20121113175309.GA3601@polaris.bitmath.org>
	<CC51EC7B5B7F984AA566DC102237848896F62894@hkdcw-mail1.synaptics-inc.local>
	<20121114180401.GC29131@core.coreip.homeip.net>
	<CC51EC7B5B7F984AA566DC102237848896F6299E@hkdcw-mail1.synaptics-inc.local>
	<20121115064359.GA17551@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45333 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768544Ab2KORl1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Nov 2012 12:41:27 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so1111550eek.19
        for <linux-input@vger.kernel.org>; Thu, 15 Nov 2012 09:41:26 -0800 (PST)
In-Reply-To: <20121115064359.GA17551@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexandra Chin <alexandra.chin@tw.synaptics.com>, Henrik Rydberg <rydberg@euromail.se>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Mahesh Srinivasan <msrinivasan@synaptics.com>, Alex Chang <alex.chang@tw.synaptics.com>, Scott Lin <scott.lin@tw.synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>

On Thu, Nov 15, 2012 at 7:43 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> In this case you need to enumerate the benefits of this driver over
> unified driver and show why the unified driver can't be fixed.

The benefit is that the ugliness in
drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
can be avoided, as today we're unable to pass the compulsory
platform data in any sane way. I'm being told that this weak symbol
override actually does not really work... especially if there are more
than 1 I2C device on the bus :-P

Another way of fixing the staging driver usable is to add device tree
support, of course, that would decopule it completely from the
platform using it.

Yours,
Linus Walleij
