From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Subject: Re: [patch 1/1] hid: Logitech G13 driver 0.0.2
Date: Wed, 6 Jan 2010 09:23:25 -0700
Message-ID: <e4857e132859fc5a73c584f1593587ba.squirrel@intranet.cs.nmsu.edu>
References: <200912220022.nBM0MMS8005004@imap1.linux-foundation.org>
    <alpine.LNX.2.00.0912230056120.3755@pobox.suse.cz>
    <20091222160307.0018bda9.akpm@linux-foundation.org>
    <alpine.LNX.2.00.0912230111010.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.cs.nmsu.edu ([128.123.64.3]:58235 "EHLO mail.cs.nmsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430Ab0AFQXj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Jan 2010 11:23:39 -0500
In-Reply-To: <alpine.LNX.2.00.0912230111010.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, dtor@mail.ru, oliver@neukum.org

Jiri Kosina wrote:
> Still, this is not the only build problem of this driver. Apparently it
> also doesn't like to be built as module (together with all the
> HID_LOGITECH stuff).
>
> drivers/hid/hid-g13.o:(.rodata+0x1e0): multiple definition of
> `__mod_hid_device_table'
> drivers/hid/hid-lg.o:(.rodata+0x540): first defined here
> ld: Warning: size of symbol `__mod_hid_device_table' changed from 552 in
> drivers/hid/hid-lg.o to 48 in drivers/hid/hid-g13.o
> drivers/hid/hid-g13.o: In function `g13_init':
> /home/jkosina/src/hid/drivers/hid/hid-g13.c:1513: multiple definition of
> `init_module'
> drivers/hid/hid-lg.o:/home/jkosina/src/hid/drivers/hid/hid-lg.c:354: first
> defined here
> drivers/hid/hid-g13.o: In function `g13_exit':
> /home/jkosina/src/hid/drivers/hid/hid-g13.c:1518: multiple definition of
> `cleanup_module'
> drivers/hid/hid-lg.o:/home/jkosina/src/hid/drivers/hid/hid-lg.c:359: first
> defined here
> make[1]: *** [drivers/hid/hid-logitech.o] Error 1
>

Even though the G13 is a Logitech device, perhaps I should break it out of
the Logitech stuff. In reality, the "Logitech" option is a bit of a
misnomer. It doesn't appear to be Logitech in general but rather Logitech
Force Feedback devices.

There's nothing in the driver that needs the Logitech force feedback code.

---

Rick


