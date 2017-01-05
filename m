From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Remove DRIVER_LICENSE?
Date: Thu, 5 Jan 2017 10:24:56 +0100
Message-ID: <20170105092456.GB15702@mail.corp.redhat.com>
References: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com>
 <CAE_wzQ975aiGGdF78bXxqOTNFg-p3HUOsxicq_a1OS8NcdJROw@mail.gmail.com>
 <CAE_wzQ8SdhAUv1TLzKE_gt1qgb9SuPJt30m2pyw01kTE4gqbRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754644AbdAEJZH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 04:25:07 -0500
Content-Disposition: inline
In-Reply-To: <CAE_wzQ8SdhAUv1TLzKE_gt1qgb9SuPJt30m2pyw01kTE4gqbRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Grant Grundler <grundler@google.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Jan 04 2017 or thereabouts, Dmitry Torokhov wrote:
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
> >
> > Sounds good to me.

No objections on my side.

Cheers,
Benjamin
