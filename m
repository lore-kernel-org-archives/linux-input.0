From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 02/30] HID: wacom: store the type in wacom->shared for
 INTUOSHT and INTUOSHT2
Date: Mon, 18 Jul 2016 16:54:38 +0200
Message-ID: <20160718145438.GO4663@mail.corp.redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
 <1468425977-4819-3-git-send-email-benjamin.tissoires@redhat.com>
 <CAF8JNhKGgr_p=gbHLtLycPM2zf5zF01C-xMra8j3eBoyOCHH9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbcGROyp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 10:54:45 -0400
Content-Disposition: inline
In-Reply-To: <CAF8JNhKGgr_p=gbHLtLycPM2zf5zF01C-xMra8j3eBoyOCHH9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Jul 14 2016 or thereabouts, Ping Cheng wrote:
> On Wed, Jul 13, 2016 at 9:05 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > The type is never set but we check for it in wacom_wireless_irq().
> 
> Type was assigned in wacom_wireless_work [1] before we moved code
> around. It somehow failed to get into wacom_parse_and_register. The
> value was only assigned once on stylus interface. It was unnecessary
> to assign it again on touch interface since it is a shared value.
> Maybe that was the reason it missed its "flight"?

Yeah, sorry I have seen that my patch removed it a while ago and that no
one actually reported it as an issue.

> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/drivers/hid/wacom_sys.c?id=2546dacd3e0e48c40bbb99caf01455f1ade9bb24
> 
> > It looks like this is a big hack from the beginning, so fill in the gap
> > only.
> 
> Yeah, wireless is a dynamic connection. We can not tell which tablet
> model is going to be connected before it is paired. But, the dongle is
> always the same. That's the tricky part.
> 
> > Untested.
> 
> Aaron tested it. So, your code is safe ;).
> 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> The whole set is
> 
> Acked-by: Ping Cheng <pingc@wacom.com>
> 

Thanks!

Cheers,
Benjamin

> Thanks for your effort!
> 
> Ping
> 
> > ---
> >
> > No changes in v2
> > ---
> >  drivers/hid/wacom_sys.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 499cc82..9e283aa 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -1720,9 +1720,10 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> >                 error = hid_hw_open(hdev);
> >
> >         if ((wacom_wac->features.type == INTUOSHT ||
> > -           wacom_wac->features.type == INTUOSHT2) &&
> > +            wacom_wac->features.type == INTUOSHT2) &&
> >             (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)) {
> > -                       wacom_wac->shared->touch_input = wacom_wac->touch_input;
> > +               wacom_wac->shared->type = wacom_wac->features.type;
> > +               wacom_wac->shared->touch_input = wacom_wac->touch_input;
> >         }
> >
> >         return 0;
> > --
> > 2.5.5
> >
