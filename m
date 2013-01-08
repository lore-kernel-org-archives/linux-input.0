From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based probe
Date: Tue, 8 Jan 2013 16:17:46 +0530
Message-ID: <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
	<20130108094134.GA21994@gmail.com>
	<201301081044.14876.marex@denx.de>
	<201301081048.38149.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:34647 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab3AHKrr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 05:47:47 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so213064oag.28
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 02:47:46 -0800 (PST)
In-Reply-To: <201301081048.38149.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, vipul kumar samar <vipulkumar.samar@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

On 8 January 2013 15:18, Marek Vasut <marex@denx.de> wrote:
> Maybe I was too quick about understanding the issue at hand. So allow me a
> stupid question -- who's gonna configure the GPIO as input for it to work as IRQ
> GPIO?

Hmm.. I tried a bit, but couldn't find any such call :(
Probably an assumption is taken here. GPIO pins which are going to be used as
interrupt lines, wouldn't be getting set in output mode at all. So,
once they are put
in input mode in beginning, nobody would change it ever.

Much of gpio controllers configure gpio pins in input mode in their probe().

Maybe, there is something else :)
