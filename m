From: Gregor Riepl <onitake@gmail.com>
Subject: Re: atmel_mxt_ts maxtouch.cfg firmware ?
Date: Fri, 12 Feb 2016 18:16:49 +0100
Message-ID: <56BE1381.7020402@gmail.com>
References: <CAB=NE6UWaTv1EN1XPByMucW2Ftv9G9GtOauR9uQTsWb+N8z7wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33361 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbcBLRQw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 12:16:52 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so71186877wme.0
        for <linux-input@vger.kernel.org>; Fri, 12 Feb 2016 09:16:51 -0800 (PST)
Received: from ?IPv6:2001:4b28:1:201:843d:50c8:7258:6bdc? ([2001:4b28:1:201:843d:50c8:7258:6bdc])
        by smtp.googlemail.com with ESMTPSA id w144sm3231393wmd.8.2016.02.12.09.16.50
        for <linux-input@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Feb 2016 09:16:50 -0800 (PST)
In-Reply-To: <CAB=NE6UWaTv1EN1XPByMucW2Ftv9G9GtOauR9uQTsWb+N8z7wg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

> And that Atmel provides such firmwaere in .enc form. Is this firmware
> optional? If so why? If it gives me a few bells and whistles, what are
> they ? Can we just put the firmware into the linux-firmware tree? If
> not, why not.
> 
> Can the firmware be open sourced? If not why not? [0]

I can only speak from experience with Silead TS controller firmware, but the
most likely reason why one can't simply add the fw to linux-firmware or
open-source it, is that it mainly contains device-specific calibration data.
This means that you need a different file for every single device.

If the controller, DT or DSDT don't give you any hints to reliably identify
which exact firmware you need, then there's not much you can do. Perhaps
device quirks.

Maybe this doesn't apply to the Atmel chips, but I really suspect it does.

(Sorry for only posting to linux-input, I'm not subscribed to the other lists)
