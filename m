From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 3 Aug 2011 20:51:07 +0100
Message-ID: <CAMLZHHQNMTgx6NyWsE5zkc95L-i78DYd=KqxJcx1pDaVcLxZQQ@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
	<CAMLZHHQAjarobktUFiZF7aEVvLuaaAFSBuzrMj4pT_67BFssjA@mail.gmail.com>
	<20110803193814.GA17944@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57625 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab1HCTvI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 15:51:08 -0400
Received: by gwaa12 with SMTP id a12so682091gwa.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 12:51:07 -0700 (PDT)
In-Reply-To: <20110803193814.GA17944@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

On Wed, Aug 3, 2011 at 8:38 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I believe we can and do mark devices such as USB as wakeup capable on
> other arches, you do not have control here. That is why I am uneasy with
> doing this in input core.

That's possible, but do note that the latest iteration of the patch
only looks at the wakeup capability of the struct input_device. It is
unlikely that another part of the kernel marks it as wakeup-capable
without taking these considerations into account.

It is more likely that, in the USB case, the wakeup field of the
struct usb_device is marked wakeup capable. With Alan's ACPI case
earlier in the discussion, this was true: we found that only the ACPI
device gets marked as wakeup-capable/wakeup-enabled, and not the input
device or even the i8042/serio devices, even though it is implementing
(some form of) keyboard wakeup.

Anyway, I'll look at implementing it according to how you suggested,
which wouldn't involve such wide-reaching changes.

> Is there any keys that are not autorepeating. For example regular
> (non-OLPC) laptops usually do not repeat suspend and other special keys.
> In fact, they quite often forget to send release events for them ;)

I just tested, and all of our keys autorepeat in that fashion. Even
the odd keys like "rotate" and "change language". I guess that makes
us irregular ;)

Daniel
