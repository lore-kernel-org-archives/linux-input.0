From: Steffen Barszus <steffenbpunkt@googlemail.com>
Subject: Re: [PATCH 1/1] Input: ati_remote - extend keytable for medion remotes
Date: Fri, 1 Jul 2011 16:01:46 +0200
Message-ID: <BANLkTikTwgTZ1X-m1q+zBESk4zUo39Osxg@mail.gmail.com>
References: <20110418104108.GA4876@atlantis.wh2.tu-dresden.de.de>
	<20110418104547.GB4876@atlantis.wh2.tu-dresden.de.de>
	<20110525163204.GD22517@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62784 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab1GAOBr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2011 10:01:47 -0400
In-Reply-To: <20110525163204.GD22517@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Anssi Hannula <anssi.hannula@iki.fi>

2011/5/25 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Jan,
>
> On Mon, Apr 18, 2011 at 12:45:47PM +0200, Jan Losinski wrote:
>> This extends the ati_remote to support multiple keytables. The table
>> will be selected with the productId of the device.
>>
>> It also provides a table for the medion rf remote control that enables
>> all buttons on it.
>>
>
> I am not a big fan of static keymaps in kernel drivers and would much
> more prefer driver supporting adjusting keymaps via EVIOCSKEYCODE
> ioctls. Unfortunately ati_remote key handling code is kind of involved
> and I am not sure what is the best way of wiring it up.
>
> I believe Anssi Hannula (CCed) mentioned that he has a version of
> ati_remove ported to rc-core infrastructure that supports such
> remapping. Anssi, could you tell me what is the status of that driver?
> Is it usable with rc-core?
>

That would be cool - being a remote it might be the right framework.

Until then this patch might improve the situation.
