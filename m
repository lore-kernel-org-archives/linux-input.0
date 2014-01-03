From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Another ALPS touchpad
Date: Fri, 03 Jan 2014 15:39:42 -0800
Message-ID: <5612072.Tm4gq8bhLq@dtor-d630.eng.vmware.com>
References: <20140103045915.GB30008@whitehail.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36286 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbaACXjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jan 2014 18:39:47 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so16375354pab.39
        for <linux-input@vger.kernel.org>; Fri, 03 Jan 2014 15:39:46 -0800 (PST)
In-Reply-To: <20140103045915.GB30008@whitehail.bostoncoop.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: Dylan Paul Thurston <dpthurst@indiana.edu>, linux-input@vger.kernel.org

On Thursday, January 02, 2014 11:59:15 PM Dylan Paul Thurston wrote:
> I just bought a HP Revolve 810 G1 laptop. (This is a convertible
> ultrabook, normally sold with Windows 8.) The touchpad seems to be
> another ALPS touchpad, not yet recognized by the kernel; I tried the
> Debian package of 3.12 and linux-next-20131224 compiled from
> source. Without the proper driver, it is unusuably sensisitive,
> registering clicks when my hands are well away from the touchpad.
> The relevant line from dmesg is
> 
> [    2.776630] psmouse serio4: alps: Unknown ALPS touchpad: E7=73 03 0a,
> EC=88 b3 18
> 
> Should I try hacking drivers/input/mouse/alps.c to see if one of the
> existing protocols works?

Tommy, Yunkang,

Do you have anything in works to support this new model? Or it is
not an ALPS device at all?

Thanks!

-- 
Dmitry
