From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH v2] HID: add ThingM blink(1) USB RGB LED support
Date: Tue, 22 Jan 2013 09:15:30 -0500 (EST)
Message-ID: <118417672.210985.1358864130303.JavaMail.root@mail.savoirfairelinux.com>
References: <alpine.LNX.2.00.1301221443320.20374@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:50022 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3AVOPb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2013 09:15:31 -0500
In-Reply-To: <alpine.LNX.2.00.1301221443320.20374@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


> > The vendor's name is "ThingM" and the product's name is "blink(1)",
> > not "blink".
> > Given that, would you prefer to keep "blink(1)::1234", or would it
> > rather be
> > "thingm-blink1::1234" (avoiding parenthesis)?
> > 
> > I ask the same question for the driver name, which is actually
> > "blink(1)".
> 
> Actually, for HID bus drivers, we are mostly following the convention
> of
> having just the vendor name in the driver, see hid-microsoft,
> hid-logitech, etc.
> 
> So it'd make most sense to me to name the driver hid-thingm, and in
> case
> it is driving blink(1) device (no other devices will be driven by it
> currently), let it create /sys/class/leds/blink1...

Ok, makes sense to me!

Thanks,
Vivien
