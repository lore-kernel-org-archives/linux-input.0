From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Fri, 5 Aug 2011 16:24:07 +0100
Message-ID: <CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46639 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab1HEPYI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Aug 2011 11:24:08 -0400
Received: by yxj19 with SMTP id 19so1513863yxj.19
        for <linux-input@vger.kernel.org>; Fri, 05 Aug 2011 08:24:08 -0700 (PDT)
In-Reply-To: <20110803184332.GA17880@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

Hi Dmitry,

On Wed, Aug 3, 2011 at 7:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Instead of wiring it all through input core could we contain this in
> atkbd and hgpk by registering pm_notifiers and ignoring certain requests
> from input/serio cores during system state transition on OLPC only?

I've started looking at this, but my first problem is that when the
input layer asks atkbd to turn off LEDs, atkbd schedules a workqueue
item to undertake this work. However, as there is no synchronization,
this work only seems to get executed during or after system resume.
This makes it hard to catch with such a scheme. Any ideas?

Daniel
