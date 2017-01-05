From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Remove DRIVER_LICENSE?
Date: Thu, 5 Jan 2017 11:19:18 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701051118450.28985@cbobk.fhfr.pm>
References: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com> <CAE_wzQ975aiGGdF78bXxqOTNFg-p3HUOsxicq_a1OS8NcdJROw@mail.gmail.com> <CAE_wzQ8SdhAUv1TLzKE_gt1qgb9SuPJt30m2pyw01kTE4gqbRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762551AbdAEKyS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 05:54:18 -0500
In-Reply-To: <CAE_wzQ8SdhAUv1TLzKE_gt1qgb9SuPJt30m2pyw01kTE4gqbRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Grant Grundler <grundler@google.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>

On Wed, 4 Jan 2017, Dmitry Torokhov wrote:

> [ let's add a few people ]
> 
> On Wed, Jan 4, 2017 at 10:12 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
> > On Wed, Jan 4, 2017 at 9:58 AM, Grant Grundler <grundler@google.com> wrote:
> >> I'm researching MODULE_LICENSE uses/declarations and AFAICT
> >> DRIVER_LICENSE is only obfuscating the programatically declared
> >> license. e.g.:
> >>
> >> drivers/hid/hid-core.c:#define DRIVER_LICENSE "GPL"
> >> drivers/hid/hid-core.c:MODULE_LICENSE(DRIVER_LICENSE);
> >> drivers/hid/usbhid/usbmouse.c:#define DRIVER_LICENSE "GPL"
> >> drivers/hid/usbhid/usbmouse.c:MODULE_LICENSE(DRIVER_LICENSE);
> >> drivers/hid/usbhid/usbkbd.c:#define DRIVER_LICENSE "GPL"
> >> drivers/hid/usbhid/usbkbd.c:MODULE_LICENSE(DRIVER_LICENSE);
> >> drivers/hid/wacom.h:#define DRIVER_LICENSE "GPL"
> >> drivers/hid/wacom_sys.c:MODULE_LICENSE(DRIVER_LICENSE);
> >>
> >> Any objection to removing those uses in drivers/hid?

Nope, let's do it. Grant, will you send me a patch?

-- 
Jiri Kosina
SUSE Labs

