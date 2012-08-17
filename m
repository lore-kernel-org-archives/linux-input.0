From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Fri, 17 Aug 2012 13:04:40 -0400
Message-ID: <87zk5ta1qv.fsf@gmail.com>
References: <20120814103553.GF23370@arianrhod.panaceas.james.local> <87mx1xxy1y.fsf@gmail.com> <20120814160519.GC12473@artemis.panaceas.org> <87ipckwvp4.fsf@gmail.com> <87sjbnzau7.fsf@gmail.com> <502E756C.4080509@dahetral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33948 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2HQREp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Aug 2012 13:04:45 -0400
Received: by vcbfk26 with SMTP id fk26so3096856vcb.19
        for <linux-input@vger.kernel.org>; Fri, 17 Aug 2012 10:04:44 -0700 (PDT)
In-Reply-To: <502E756C.4080509@dahetral.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dturvene <dturvene@dahetral.com>, James <james@madingley.org>
Cc: Ignacio Casal Quinteiro <nacho.resa@gmail.com>, linux-input@vger.kernel.org

dturvene <dturvene@dahetral.com> writes:

> Ben -
>
> I tried your fix on a Dell Inspiron 15R N5110 (I15R).  It did not work.  
> Things I noticed:
>
> 1) Consistent with prior observations, the touchpad E7 signature for it 
> is: 0x73 0x03 0x50, different than yours on the E6230.
>
Alright. Good to know.

> 2) Your alps_hw_init_v5 sequence does not work for my I15R.  I noticed 
> that the sequence enters/exits command mode a couple times. Why not 
> enter once, do the init and then exit?
>
Frankly, I didn't put much (honestly, any) time into figuring out the
meaning behind command sequence. I grabbed a dump from the VM and
implemented exactly what the Windows driver did. At that point I was
under the impression I was dealing with an entirely new protocol so it
didn't make much sense to put time into reasoning out the command
structure. Given the v3 report format is used I should revisit
this. I'll hopefully have a chance to do this this weekend. Given you
seem to recognize the command structure, you could probably do this even
faster than me. Take a stab at it if you feel so inclined. Pull requests
accepted.

> 3) When in command mode, the I15R accurately sets and retrieves 
> registers (e.g. 0x0008 returns 0x00 0x08 0x02).  When not in command 
> mode, all register reads return -1.  Oddly, the check in 
> alps_enter_command_mode is 0x73 0x01 rather than 0x88 0x07.
>
> So I think either I'm doing something wrong or I'm dealing with YAAP 
> (Yet Another ALPS Protocol).
>
Hopefully not.

> My question:  how did you get the protocol trace?  I think you said 
> previously that the drive does some direct register I/O.  I couldn't see 
> anything beyond PS/2 commands running under Virtual Box.
>
I used Seth Foreshee's method[1] under Qemu. Note that the Alps driver
for the E6230 (and, given the behavior you see, likely your machine as
well) checks for the presence of an entry in the ACPI DSDT (if not
present, the driver falls back onto generic PS/2 behavior).
Consequently, you may need to do some editing of the Qemu DSDT as
pointed out earlier in this thread by James (Message-Id:
<20120814103553.GF23370@arianrhod.panaceas.james.local>) I'm not
terribly familiar with ACPI, I'll defer to him to explain precisely how
he determined the relevant sections.

Cheers,

- Ben


[1] http://swapspace.forshee.me/2011/11/touchpad-protocol-reverse-engineering.html

