From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/3] HID: core: move the dynamic quirks handling in core
Date: Wed, 14 Jun 2017 14:41:32 +0200
Message-ID: <20170614124132.GC5085@mail.corp.redhat.com>
References: <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm>
 <20170614082441.5270-1-benjamin.tissoires@redhat.com>
 <20170614082441.5270-2-benjamin.tissoires@redhat.com>
 <CAHp75VfGV2n8wXgL9i+45Sw7JmmKgiwpARi=+V5qeRZuzc+BtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23005 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbdFNMlk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 08:41:40 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VfGV2n8wXgL9i+45Sw7JmmKgiwpARi=+V5qeRZuzc+BtQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, USB <linux-usb@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Jun 14 2017 or thereabouts, Andy Shevchenko wrote:
> On Wed, Jun 14, 2017 at 11:24 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > usbhid has a list of dynamic quirks in addition to a list of static quirks.
> > There is not much USB specific in that, so move this part of the module
> > in core so we can have one central place for quirks.
> 
> 
> Wouldn't be better to resend with -M -C applied?

Good point. Actually, I need to use 10% of tolerance (-M1) to get git
detect the rename :/

Patch following shortly.

Cheers,
Benjamin
