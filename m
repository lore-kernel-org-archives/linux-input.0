From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: Make sure the HID device is opened on resume
Date: Mon, 24 Jul 2017 21:28:22 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707242127300.4705@cbobk.fhfr.pm>
References: <20170723011509.23651-1-lyude@redhat.com>  <CAHp75VcZxAEr+ARw0U1nxtXR1fgWrQ1w=dhpZbm+DRiDbwajYA@mail.gmail.com> <1500918313.6243.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754483AbdGXT21 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 15:28:27 -0400
In-Reply-To: <1500918313.6243.1.camel@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 24 Jul 2017, Lyude Paul wrote:

> > > So, call hid_hw_open() in rmi_post_resume() so we make sure that
> > > the
> > > device is alive before we try talking to it.
> > > 
> > > This fixes RMI device suspend/resume over HID.
> > > -       int ret;
> > > +       int ret = 0;
> > 
> > What's the point?
> So that we can use the same out: label at the end of the function that
> calls hid_hw_close() to return success. This being said though I just
> realized that setting ret will initialize it to 0 anyway, so I guess
> this can be dropped

Andy's point was that hid_hw_open() is obviously re-initializing the ret 
before its first use as a return value, so there is no need to initialize 
it at a declaration time.

-- 
Jiri Kosina
SUSE Labs

