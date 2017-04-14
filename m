From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] Input: ar1021 - do not force raising edge IRQ trigger
Date: Fri, 14 Apr 2017 09:33:09 +0200
Message-ID: <CAH9NwWe8MUCBg7v894pf1q52vWDCKf7mng4MfD0gThDy_zz+1g@mail.gmail.com>
References: <20170413234923.GA38321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36204 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdDNHdb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Apr 2017 03:33:31 -0400
In-Reply-To: <20170413234923.GA38321@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Martin Kepplinger <martin.kepplinger@ginzinger.com>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, LKML <linux-kernel@vger.kernel.org>

2017-04-14 1:49 GMT+02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> We should not be forcing edge triggered interrupt, but rather let platform
> decide the kind of trigger it needs to use. Also, the driver is not quite
> safe with regard to edge-triggered interrupts as it does not try to kick
> the controller after requesting/enabling IRQ.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-By: Christian Gmeiner <christian.gmeiner@gmail.com>

greets
--
Christian Gmeiner, MSc

https://www.youtube.com/user/AloryOFFICIAL
https://soundcloud.com/christian-gmeiner
