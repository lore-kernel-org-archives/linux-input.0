From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Thu, 1 Mar 2012 08:55:23 -0500
Message-ID: <CAKON4Ozcui=fo1vTd70s5Mye2n-9YS+ys74Kyozrn-jrdP6RQg@mail.gmail.com>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
	<CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
	<CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
	<1330609674.2398.18.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59752 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759326Ab2CANzY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 08:55:24 -0500
Received: by wejx9 with SMTP id x9so365335wej.19
        for <linux-input@vger.kernel.org>; Thu, 01 Mar 2012 05:55:23 -0800 (PST)
In-Reply-To: <1330609674.2398.18.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Eric Paris <eparis@parisplace.org>, linux-input@vger.kernel.org

I don't know why Logitech called the middle button Button0 instead
Button2 like every other mouse in the world. To fix it in udev you'd
need to create a way to map Button0 up to Button1-6 which are
understood by X.

Or is there some way to make X act on Button0 that I don't know about?

Another way to fix it in udev would be to capture the USB commands
Windows sends to it that reprograms it from button0 to button2. Then
send it that command from udev.

-- 
Jon Smirl
jonsmirl@gmail.com
