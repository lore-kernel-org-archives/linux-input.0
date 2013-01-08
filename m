From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based probe
Date: Tue, 8 Jan 2013 16:53:42 +0530
Message-ID: <CAKohponFeYgjC6qbNNWJ-mv0_7z=vDbZv1Bi0psBRnM5dLugxg@mail.gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
	<20130108094134.GA21994@gmail.com>
	<201301081044.14876.marex@denx.de>
	<201301081048.38149.marex@denx.de>
	<CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
	<20130108111104.GF21994@gmail.com>
	<CAKohpomiS+UFzgiJaQbm8aZVPY0jeYhm1k7Yndk50z8=K4LvGQ@mail.gmail.com>
	<50EC007F.1090301@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61231 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131Ab3AHLXn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 06:23:43 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so241529oag.33
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 03:23:42 -0800 (PST)
In-Reply-To: <50EC007F.1090301@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>, vipul kumar samar <vipulkumar.samar@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>

On 8 January 2013 16:48, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> I think we can do it in the gpio chip driver inthe function
> xxx_gpio_irq_set_type().
> When you register any irq and if this callback is available from gpio chip
> driver then this will get called. and so the setting the pi to input mode as
> well as putting the pin in GPIO mode can be done here.  This is what we are
> doing it in gpio-tegra driver.

Hmm... So, the initial question was, is somebody setting gpio in input mode?
There were no bugs reported, it was just a query. As most of the stuff would
work as per my earlier explanation.

But yes, your suggestion makes sense too.. I would rather do it in the gpiolib
routine instead of adding this in every driver.

@Linus/Grant: What do you say?
