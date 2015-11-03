From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-gfrm: avoid warning for input_configured API
 change
Date: Tue, 3 Nov 2015 15:48:02 -0800
Message-ID: <20151103234802.GC29032@dtor-ws>
References: <14835877.IL6ArpWV8Q@wuerfel>
 <CAGXr9JGO_dcAuTyO2vjvbBwJ7xqcEZ1kWh7WAtxaQiKsdzr1+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34385 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbbKCXsG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 18:48:06 -0500
Content-Disposition: inline
In-Reply-To: <CAGXr9JGO_dcAuTyO2vjvbBwJ7xqcEZ1kWh7WAtxaQiKsdzr1+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 03, 2015 at 11:33:11AM -0800, Petri Gynther wrote:
> On Tue, Nov 3, 2015 at 6:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The input_configured callback was recently changed to return
> > an 'int', but the newly added driver uses the old API:
> >
> > drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> >
> > This changes the driver like the other ones.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Petri Gynther <pgynther@google.com>

Hmm, the question is how to merge this, given that one change is in
Jiri's tree and another in mine...

> 
> > Fixes: 34fc1322e7aa ("HID: hid-gfrm: Google Fiber TV Box remote controls")
> > Fixes: b2c68a2f1bab ("HID: hid-input: allow input_configured callback return errors")
> > ---
> > Found on ARM allmodconfig with yesterday's linux-next
> >
> > diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
> > index 4d7b7e7f0792..075b1c020846 100644
> > --- a/drivers/hid/hid-gfrm.c
> > +++ b/drivers/hid/hid-gfrm.c
> > @@ -88,7 +88,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
> >         return (ret < 0) ? ret : -1;
> >  }
> >
> > -static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
> > +static int gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
> >  {
> >         /*
> >          * Enable software autorepeat with:
> > @@ -96,6 +96,7 @@ static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidi
> >          * - repeat period: 100 msec
> >          */
> >         input_enable_softrepeat(hidinput->input, 400, 100);
> > +       return 0;
> >  }
> >
> >  static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >

-- 
Dmitry
