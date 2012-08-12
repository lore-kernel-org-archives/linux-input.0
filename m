From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: 3.5.1 hid_generic causes mouse locking until a button is
 clicked
Date: Sun, 12 Aug 2012 18:16:22 -0300
Message-ID: <50281d29.516eec0a.683e.1052@mx.google.com>
References: <k06dcc$u9q$1@dough.gmane.org>
	<20120812195329.2cb454c3@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42995 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2HLVQ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Aug 2012 17:16:26 -0400
Received: by ghrr11 with SMTP id r11so2506283ghr.19
        for <linux-input@vger.kernel.org>; Sun, 12 Aug 2012 14:16:26 -0700 (PDT)
In-Reply-To: <20120812195329.2cb454c3@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org

On Sun, 12 Aug 2012 19:53:29 +0200
Bruno Pr=C3=A9mont <bonbons@linux-vserver.org> wrote:

> This might be USB-autosuspend. 2 seconds seems to match the default
> delay for autosuspending USB devices.

	Hi Bruno. That's it!=20

	I raised the autosuspend value and I'm using it as a
workaround... but the default values are the same as the kernel 3.4.4
values, so something has changed:

/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/power$ cat
autosuspend*=20
2 <----- autosuspend
2000 <-- autosuspend_delay_ms

	So, if the values are the same, why the behaviour has changed
from kernel 3.4 to 3.5?

	I mean, it seems that with kernel 3.4 simply moving the mouse
would wake up the usb port and now with kernel 3.5 it only works if I
press a button.

	So, kernel 3.5 is supposed to wake up the usb port when we move
the mouse or not?

	Is there a way to restore the old behaviour from kernel 3.4?
=09
	Thanks.

--=20
Linux 3.5.1: Saber-toothed Squirrel
http://www.youtube.com/DanielFragaBR
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
