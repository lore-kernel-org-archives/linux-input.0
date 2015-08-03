From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: use generic driver for ThingM blink(1) if
 !CONFIG_HID_THINGM
Date: Mon, 3 Aug 2015 11:25:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508031124400.925@pobox.suse.cz>
References: <1438024626-36448-1-git-send-email-reillyg@chromium.org> <20150802071341.GE32270@amd> <CAEmk=MYatwhrgMv5XC2V-NDwioBeoGC=PgYCh6bc8TtBBUwPAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58491 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbbHCJZM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Aug 2015 05:25:12 -0400
In-Reply-To: <CAEmk=MYatwhrgMv5XC2V-NDwioBeoGC=PgYCh6bc8TtBBUwPAQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reilly Grant <reillyg@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2 Aug 2015, Reilly Grant wrote:

> There is existing user space software (not just mine, also from the
> manufacturer) that does not use the special driver and instead uses hidraw
> or usbdevice_fs to control the device. LED class driver support for this
> device is useful but should be optional.

Is there any problem for the userspace software to unbind the kernel 
driver first?

-- 
Jiri Kosina
SUSE Labs
