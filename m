From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Date: Fri, 8 Jan 2010 09:50:33 -0700
Message-ID: <a3581fd32d39b5e86aba9ded88bd5f46.squirrel@intranet.cs.nmsu.edu>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
    <20100108083020.GB3696@core.coreip.homeip.net>
    <20100108163655.GA8328@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.cs.nmsu.edu ([128.123.64.3]:44071 "EHLO mail.cs.nmsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab0AHQvM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jan 2010 11:51:12 -0500
In-Reply-To: <20100108163655.GA8328@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz

Pavel Machek wrote:
> Hi!
>
>> > +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
>>
>> What this attribute is for?
>
> Actually, all the new files this added need to be documented.
> 									Pavel
>

Which is better? A hid-g13.txt file added to Documentation/ or comments in
the driver itself?

Thanks,

---

Rick


