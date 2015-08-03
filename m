From: Reilly Grant <reillyg@chromium.org>
Subject: Re: [PATCH] HID: use generic driver for ThingM blink(1) if !CONFIG_HID_THINGM
Date: Mon, 3 Aug 2015 09:52:46 -0700
Message-ID: <CAEmk=MbQZR6dF=WUDU-KF8iY9w3siyfiYMh+PFL_K=bASnpA6A@mail.gmail.com>
References: <1438024626-36448-1-git-send-email-reillyg@chromium.org>
	<20150802071341.GE32270@amd>
	<CAEmk=MYatwhrgMv5XC2V-NDwioBeoGC=PgYCh6bc8TtBBUwPAQ@mail.gmail.com>
	<alpine.LNX.2.00.1508031124400.925@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35885 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbbHCQwq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 12:52:46 -0400
Received: by igbij6 with SMTP id ij6so58014908igb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 09:52:46 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1508031124400.925@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

If the software is using usbdevice_fs, no, it can simply detach the
kernel driver. If the software is using hidraw then this blacklist
becomes the issue because even if you unload the special driver the
generic HID driver won't load. Is there a mechanism in the HID
subsystem for drivers to build on top of the generic one instead of
replacing it?


On Mon, Aug 3, 2015, 2:25 AM Jiri Kosina <jkosina@suse.com> wrote:
>
> On Sun, 2 Aug 2015, Reilly Grant wrote:
>
> > There is existing user space software (not just mine, also from the
> > manufacturer) that does not use the special driver and instead uses hidraw
> > or usbdevice_fs to control the device. LED class driver support for this
> > device is useful but should be optional.
>
> Is there any problem for the userspace software to unbind the kernel
> driver first?
>
> --
> Jiri Kosina
> SUSE Labs
