From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Thu, 17 Dec 2015 10:53:29 +0100
Message-ID: <20151217095329.GJ16026@mail.corp.redhat.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
 <20151216092858.GP1762@lahna.fi.intel.com>
 <alpine.LNX.2.00.1512161416350.9922@cbobk.fhfr.pm>
 <CAOhV88NnD9Q=BEA2QFxianmyW07n8oQEBSPoMoU+F7ZuKgsNXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47435 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbbLQJxe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 04:53:34 -0500
Content-Disposition: inline
In-Reply-To: <CAOhV88NnD9Q=BEA2QFxianmyW07n8oQEBSPoMoU+F7ZuKgsNXw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Dec 16 2015 or thereabouts, Nish Aravamudan wrote:
> Hi Jiri,
> 
> On Wed, Dec 16, 2015 at 5:18 AM, Jiri Kosina <jikos@kernel.org> wrote:
> > On Wed, 16 Dec 2015, Mika Westerberg wrote:
> >
> >> > [Apologies for the resend, didn't realize I hadn't changed my GMail settings
> >> > to not use HTML.]
> >> >
> >> > I have recently purchased a Lenovo Yoga 900 and most everything is working
> >> > with a slightly modified 4.4-rc5 (https://lkml.org/lkml/2015/11/30/441 applied
> >> > to enable the touchpad itself), I am seeing two issues:
> >> >
> >> > 1) On suspend/resume, the touchpad is non-functional. A `modprobe -r i2c-hid;
> >> >  modprobe i2c-hid` "fixes" it.
> >> >
> >> > The kernel emits:
> >> >
> >> > i2c_hid i2c-SYNA2B29:00: failed to reset device.
> >> > dpm_run_callback(): i2c_hid_resume+0x0/0xc0 [i2c_hid] returns -61
> >> > PM: Device i2c-SYNA2B29:00 failed to resume: error -61
> >> >
> >> > During the resume. So perhaps this is a timing issue (given that once
> >> > resumed, the
> >> > module reload does work?).
> >>
> >> Linus noticed this as well and Jiri suggested the below patch which
> >> seemed to fix the issue (although it increased resume time a bit).
> >>
> >> I was supposed to get one Lenovo Yoga 900 here to debug this issue but
> >> I'm still waiting for it (sloow big corporation bureaucracy takes some
> >> time to get things purchased outside).
> >>
> >> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> >> index 55d8f9d..52dd03a0 100644
> >> --- a/drivers/hid/i2c-hid/i2c-hid.c
> >> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> >> @@ -1121,10 +1121,16 @@ static int i2c_hid_resume(struct device *dev)
> >>       struct i2c_client *client = to_i2c_client(dev);
> >>       struct i2c_hid *ihid = i2c_get_clientdata(client);
> >>       struct hid_device *hid = ihid->hid;
> >> -     int wake_status;
> >> +     int wake_status, tries = 3;
> >>
> >>       enable_irq(ihid->irq);
> >> -     ret = i2c_hid_hwreset(client);
> >> +
> >> +     do {
> >> +             ret = i2c_hid_hwreset(client);
> >> +             if (ret)
> >> +                     msleep(1000);
> >> +     } while (tries-- > 0 && ret);
> >> +
> >>       if (ret)
> >>               return ret;
> >
> > As a possible alternative, please test the patch above on top of for-next
> > branch of
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> >
> > It contains 64bebefcf3 ("HID: enable hid device to suspend/resume
> > asynchronously") and knowing whether that changes something might be
> > interesting datapoint as well.
> 
> What should I be looking for to be different wrt. that tree? Should I
> not see the failure to reset the device? Or would it be (relatively)
> speedier than the stock kernel?
> 

Basically, does the resume time gets better? Linus experienced something
like 9 secs of resume before this patch, and now I hope it should be
saner (the touchpad might still be a little bit long to respond).

Also, we have a bug report concerning this laptop and it looks like the
i2c controller needs to be updated (see
https://bugzilla.redhat.com/show_bug.cgi?id=1275718).

I am not entirely sure why those on the rhbz needs to update the i2c
controller while you don't have to, but it may also be worth checking if
the i2c patch series mentioned in this rhbz (comment #20) fixes by itself
the resume issue (without Jiri's patch).

Cheers,
Benjamin
