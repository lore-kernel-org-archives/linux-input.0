From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH] HID: add ThingM blink(1) USB LED support
Date: Mon, 21 Jan 2013 12:14:01 -0500 (EST)
Message-ID: <1329559360.389477.1358788441066.JavaMail.root@mail.savoirfairelinux.com>
References: <alpine.LNX.2.00.1301211714520.8266@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:47482 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab3AUROH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 12:14:07 -0500
In-Reply-To: <alpine.LNX.2.00.1301211714520.8266@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

> hid-blink sounds too generic to me, taking into account that this is
> not
> 'generic HID blinking' framework, but rather a specific device driver
> for
> a particular device.
> 
> So something like hid-thingm-blink sounds more reasonable to me.

Ok, I'll name the file hid-thingm-blink1.c instead.
Should I keep the Kconfig macro CONFIG_BLINK1 or CONFIG_THINGM_BLINK1
sounds better?

> Linux Kernel is being shipped under GPL v2, without "or any later"
> clause
> added. So I am afraid I can't merge the code with this license.

No problem, I'll change the clause.

Thanks,
Vivien
