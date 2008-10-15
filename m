From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: usbhid_set_leds problems
Date: Wed, 15 Oct 2008 09:13:32 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810150912500.26779@jikos.suse.cz>
References: <20081015041346.GE4710@cs181140183.pp.htv.fi> <20081015050557.GB20183@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:32936 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751789AbYJOHNe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2008 03:13:34 -0400
In-Reply-To: <20081015050557.GB20183@cs181140183.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 15 Oct 2008, Adrian Bunk wrote:

> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function `bright_probe':
> > drivers/hid/hid-bright.c:38: undefined reference to `usbhid_set_leds'
> > drivers/hid/hid-bright.c:38: undefined reference to `usbhid_set_leds'
> > drivers/built-in.o: In function `dell_probe':
> > drivers/hid/hid-dell.c:41: undefined reference to `usbhid_set_leds'
> > drivers/hid/hid-dell.c:41: undefined reference to `usbhid_set_leds'
> > drivers/built-in.o: In function `lg_probe':
> > drivers/hid/hid-lg.c:252: undefined reference to `usbhid_set_leds'
> > drivers/hid/hid-lg.c:252: more undefined references to `usbhid_set_leds' follow
> > ...
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > And I'm not sure commit 6edfa8dc33803a49ad936ead9840e453bee6ca3b
> > (HID: move reset leds quirk) was a good idea at all since I don't
> > see cases like HID_DELL=y, CONFIG_USB_HID=m could now work at all.
> Scrap that mail, I shouldn't send patches before the first cup of tea...
> I just found the actual problem.

Hmm, so what was the culprit actually? The build error shouldn't be there.

Thanks,

-- 
Jiri Kosina
SUSE Labs
