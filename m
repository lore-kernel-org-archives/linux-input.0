From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Mon, 10 Sep 2012 16:35:46 -0400
Message-ID: <87ehm9mx99.fsf@gmail.com>
References: <20120814103553.GF23370@arianrhod.panaceas.james.local> <87mx1xxy1y.fsf@gmail.com> <20120814160519.GC12473@artemis.panaceas.org> <87ipckwvp4.fsf@gmail.com> <87sjbnzau7.fsf@gmail.com> <502E756C.4080509@dahetral.com> <87zk5ta1qv.fsf@gmail.com> <504B3F49.9020601@dahetral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52087 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab2IJUfx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 16:35:53 -0400
Received: by vcbfy27 with SMTP id fy27so1968200vcb.19
        for <linux-input@vger.kernel.org>; Mon, 10 Sep 2012 13:35:53 -0700 (PDT)
In-Reply-To: <504B3F49.9020601@dahetral.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dturvene <dturvene@dahetral.com>
Cc: James <james@madingley.org>, Ignacio Casal Quinteiro <nacho.resa@gmail.com>, linux-input@vger.kernel.org

dturvene <dturvene@dahetral.com> writes:

> On 08/17/2012 01:04 PM, Ben Gamari wrote:
snip
> Hi Ben, etc. -
>
> I just got back to looking at the Alps driver on a Dell IR15 N5110. I 
> was using Virtualbox but switched to Qemu (1.1.1) based on your 
> progress, patched the ps2.c and acpi-dsdt.dsl (making sure to build the 
> hex  file included in acpi.c .)  I'm running vista as the guest OS, 
> which normally loads a generic ps/2 driver.  The Alps touchpad works and 
> ps2 events are being logged.  When I try to install the Alps driver, it 
> fails because (I guess) qemu has a preconfigured notion of what hardware 
> is running.  I'm trying to figure out how to configure qemu to detect 
> the real ALPS touchpad.
>
> I welcome from the community and you any ideas for qemu to detect the 
> alps touchpad.
>
If the D6430 is any indication, it seems the driver likely only checks
the DSDT. Are you certain you modified this correctly to reflect your
machine? You'll need to carefully compare the DSDT of your machine and
that of Qemu. Given that James was the one to initially crack this one,
he might have some more concrete advice.

Cheers,

- Ben

