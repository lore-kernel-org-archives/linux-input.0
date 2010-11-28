From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sun, 28 Nov 2010 09:28:15 +0100
Message-ID: <4CF2129F.40301@euromail.se>
References: <4CEE6D2A.9040408@euromail.se> <4CEE6EE8.4060805@gmail.com> <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com> <4CF0BC13.2010800@gmail.com> <20101127083229.GA28745@core.coreip.homeip.net> <4CF0C69D.9080904@gmail.com> <20101127091533.GA27213@core.coreip.homeip.net> <4CF0D35B.4030807@gmail.com> <20101127233901.GA29981@core.coreip.homeip.net> <20101128080110.GD14499@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:35191 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751720Ab0K1I3b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 03:29:31 -0500
In-Reply-To: <20101128080110.GD14499@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

>

> How about the following?
> 

>
> Input: document struct input_absinfo
>
> Add documentation for struct input_absinfo that is used in EVIOCGABS
> and EVIOCSABS ioctl and specify units of measure used for reporting
> resolution for an axis.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---

Very nice, thank you.

Acked-by: Henrik Rydberg <rydberg@euromail.se>
