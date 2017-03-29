From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Wed, 29 Mar 2017 16:03:06 +1000
Message-ID: <20170329060306.GA31345@jelly>
References: <7964888d-05dd-b109-973a-e0503884e2e2@leemhuis.info>
 <20170313131356.GH4378@mail.corp.redhat.com>
 <20170313131537.GI4378@mail.corp.redhat.com>
 <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
 <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
 <86d9e1c0-8e2b-acdd-64a1-774fc7a4d778@synaptics.com>
 <CAN+gG=Eak7oCXPiwR+NPT12pcx45qeYojemxauepdyyFgdShEA@mail.gmail.com>
 <4685193c-1512-44ad-bfde-1455becb9db4@synaptics.com>
 <20170320050009.GA20783@jelly>
 <f23fbe37-d611-163f-9f1b-79771cbfa368@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:64826 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbdC2GDb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 02:03:31 -0400
Content-Disposition: inline
In-Reply-To: <f23fbe37-d611-163f-9f1b-79771cbfa368@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jason Ekstrand <jason@jlekstrand.net>, Cameron Gutman <aicommander@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thorsten Leemhuis <linux@leemhuis.info>, Jiri Kosina <jikos@kernel.org>, Nick Dyer <nick@shmanahar.org>, Christopher Heiny <cheiny@synaptics.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Mar 28, 2017 at 06:50:44PM -0700, Andrew Duggan wrote:
> On 03/19/2017 10:00 PM, Peter Hutterer wrote:
> > On Fri, Mar 17, 2017 at 12:23:36PM -0700, Andrew Duggan wrote:
> > > On 03/17/2017 09:57 AM, Benjamin Tissoires wrote:
> > > > On Wed, Mar 15, 2017 at 2:19 AM, Andrew Duggan <aduggan@synaptics.com> wrote:
> > > > > On 03/13/2017 10:10 PM, Cameron Gutman wrote:
> > > > > > On 03/13/2017 06:35 PM, Andrew Duggan wrote:
> > > > > > > On 03/13/2017 06:15 AM, Benjamin Tissoires wrote:
> > > > > > > > [Resending, forgot to add Jiri in CC]
> > > > > > > > 
> > > > > > > > On Mar 13 2017 or thereabouts, Benjamin Tissoires wrote:
> > > > > > > > > On Mar 13 2017 or thereabouts, Thorsten Leemhuis wrote:
> > > > > > > > > > Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
> > > > > > > > > > > Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13
> > > > > > > > > > > 9343's
> > > > > > > > > > > Synaptics touchpad and dropping some errors into dmesg. Here are the
> > > > > > > > > > > messages that seem RMI-related:
> > > > > > > > > > > 
> > > > > > > > > > > rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader
> > > > > > > > > > > version
> > > > > > > > > > > rmi4_f34: probe of rmi4-00.fn34 failed with error -22
> > > > > > > > > > > rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
> > > > > > > > > > > product: TM3038-001, fw id: 1832324
> > > > > > > > > > > input: Synaptics TM3038-001 as
> > > > > > > > > > > /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
> > > > > > > > > > > hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse
> > > > > > > > > > > [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
> > > > > > > > > > FWIW, I get this on my XPS 13 DE (9360) with 4.11-rc1:
> > > > > > > > > > 
> > > > > > > > > > input: SynPS/2 Synaptics TouchPad as
> > > > > > > > > > /devices/platform/i8042/serio1/input/input6
> > > > > > > > > > rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader
> > > > > > > > > > version
> > > > > > > > > > rmi4_f34: probe of rmi4-00.fn34 failed with error -22
> > > > > > > > > > rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
> > > > > > > > > > product: TM3038-003, fw id: 2375007
> > > > > > > > > > input: Synaptics TM3038-003 as
> > > > > > > > > > 
> > > > > > > > > > /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
> > > > > > > > > > hid-rmi 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse
> > > > > > > > > > [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> > > > > > > > > > 
> > > > > > > > > > > […]
> > > > > > > > > > > Compared to hid-multitouch, the RMI stack seems to have completely
> > > > > > > > > > > broken
> > > > > > > > > > > palm rejection and introduced some random jumpiness during fine
> > > > > > > > > > > pointing
> > > > > > > > > > > motions. I don't know if these issues are caused by the above errors
> > > > > > > > > > > or
> > > > > > > > > > > are a separate issue.
> > > > > > > The error about the bootloader version not being recognized just means
> > > > > > > that updating the firmware is not supported on this touchpad. It is only the
> > > > > > > F34 firmware update functionality which is failing to load. The palm
> > > > > > > rejection and jumps are not related to this error.
> > > > > > > 
> > > > > > Maybe that code path should be changed to not make as much noise when it
> > > > > > runs
> > > > > > on known unsupported hardware. Something like the attached patch?
> > > > > > 
> > > > > > > Looking at how hid-multitouch handles palms it looks like palms should
> > > > > > > not be reported as active when calling input_mt_report_slot_state(). I'm
> > > > > > > setting the tool type to MT_TOOL_PALM when the firmware determines that a
> > > > > > > contact is a palm. But, that does not seem to be sufficient enough to have
> > > > > > > the palms filtered out. After some quick testing it looks like the change
> > > > > > > below will restore palm rejection similar to that provided by
> > > > > > > hid-multitouch.
> > > > > > > 
> > > > > > It looks like your email client ate the tabs, but if I apply the change
> > > > > > myself it seems to fix the palm rejection regression for me.
> > > > > > 
> > > > > > Tested-by: Cameron Gutman <aicommander@gmail.com>
> > > > > Sorry, I was short on time and just copied the diff into the email. I'll
> > > > > submit a proper patch soon with your tested-by included. Thanks for testing.
> > > > > 
> > > > > 
> > > > I just pointed out this patch (well the actual submission) to Jason
> > > > (Cc-ed). Given that there is no proper handling of MT_TOOL_PALM yet in
> > > > userspace, I thought it was the easiest way.
> > > > However, it seems that this doesn't enhance the jumps and just make it worse.
> > > I was assuming that the jumps and palm rejection where two separate issues.
> > > But, the palm rejection patch makes things worse?
> > > 
> > > > Is there anything we can do to fix it (besides temporary disabling the
> > > > automatic loading of hid-rmi)?
> > > I do not have a fix for the jumps yet. My next step is to file a bug against
> > > libinput or the kernel. I used evemu-record to capture a log with jumps, but
> > > when I play it back with a different userspace input stack with an older
> > > version of libinput I do not see the jumps. I see the jumps on Fedora 25
> > > with libinput 1.6.3 vs Ubuntu 16.10 with libinput 1.4.3 with X). Or at least
> > > the jumps are not as significant. But, its possible there is an issue with
> > > how the events are being reported which is incorrect and confusing libinput.
> > > The X and Y coordinates being reported by the firmware seem correct and I
> > > haven't found a problem yet. I thought a bug would be a better place to
> > > collect evemu-record logs and compare.
> > fwiw, there's a fairly easy way to quickly check libinput for changes and
> > that's by having the gtk3-headers installed at configure time and then
> > running sudo ./tools/event-gui to visualize the movement (Esc quits)
> > 
> > That tool uses libinput data directly to draw pointer motion etc, so it's a
> > way to quickly bisect to where changes happen. Without anything else to go
> > on, I'd say it's the new touchpad acceleration code from libinput 1.5 - the
> > max accel factor has changed so depending on the speed of the jumps, you can
> > now get stronger pointer movement.
> > 
> > Cheers,
> >     Peter
> 
> I have been looking into this on and off and I found a couple things, but
> nothing conclusive yet. I think Peter is right that versions of libinput 1.5
> and later do make the jump more pronounced. But, the new acceleration code
> my simply be amplifying the jumps. I went ahead and filed a libinput bug
> since the jumps are more significant in newer versions of libinput and I
> attached some evemu-record logs.
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=100436
> 
> I also spent time looking into the kernel drivers to see if they were
> causing or contributing to the jumps. One of the things that I tried was
> calling rmi_irq_fn() from a workqueue instead of calling
> generic_handle_irq(). Originally, we were using a workqueue before interrupt
> handling was added to the rmi core. I also tried moving the call to
> generic_handle_irq() to a workqueue. In both cases the jumps seemed to
> disappear or at least be reduced. I looked through the irq handling code and
> I did not see anything which should cause an issue. The only difference
> between irq thread and the workqueue that I could think of is that the irq
> thread runs at a higher priority. But, I didn't really see much of a
> difference between the timing of the events in the evemu-record logs.
> 
> At this point I am still not sure if the issue is that the events are being
> reported incorrectly by the kernel or if the new touchpad acceleration code
> in libinput is just not handling the events correctly. I would appreciate
> any suggestions. I'm not sure how much time we have left before we need to
> decide if we need to go back to hid-multitouch or not.

TLDR: input data is (often) in steps in stead of diagonal motion. libinput
amplifies those steps when pointer acceleration kicks in. See the long
analysis in the bug linked above for more detail.

I wish the data was better but I suspect it can't be, so we'll have to work
around this in libinput (averaging of deltas or something like that).

Cheers,
   Peter

> > > Hopefully, this will end up being a quick fix in the kernel and we can get
> > > it applied to 4.11 without having to hold off on disabling hid-rmi for PTPs.
> > > 
> > > Andrew
> > > 
> > > > Cheers,
> > > > Benjamin
> > > > 
> > > > > > > > > > Just to confirm: I noticed "jumpiness during fine pointing motions" as
> > > > > > > > > > well since switching to 4.11-rc.
> > > > > > > One of my test systems is a XPS 13 9343 and I have not really seen any
> > > > > > > jumpiness. But, based on the data I am seeing that if I lift my finger and
> > > > > > > place it again in a short period of time the first event or so will be at
> > > > > > > the location of the previous contact. Then it will switch over to the
> > > > > > > current location. When switching over to hid-multitouch I was unable to
> > > > > > > reproduce this behavior. This definitely could be the source of the jumps.
> > > > > > > 
> > > > > > The jumpiness definitely happens without lifting my finger, but I'm
> > > > > > willing
> > > > > > to test any patch you think would improve the situation. Moving one finger
> > > > > > slowly in a figure-8 across my touchpad shows the issue clearly for me.
> > > > > > The
> > > > > > small variations in speed of my finger due to the friction on the trackpad
> > > > > > get magnified to relatively large jumpy pointer movements on screen. It
> > > > > > seems much more noticeable in diagonal movements than completely vertical
> > > > > > or horizontal movements.
> > > > > > 
> > > > > > Regards,
> > > > > > Cameron
> > > > > > 
> > > > > > ---
> > > > > > diff --git a/drivers/input/rmi4/rmi_f34v7.c
> > > > > > b/drivers/input/rmi4/rmi_f34v7.c
> > > > > > index 56c6c39..1291d9a 100644
> > > > > > --- a/drivers/input/rmi4/rmi_f34v7.c
> > > > > > +++ b/drivers/input/rmi4/rmi_f34v7.c
> > > > > > @@ -1369,9 +1369,9 @@ int rmi_f34v7_probe(struct f34_data *f34)
> > > > > >           } else if (f34->bootloader_id[1] == 7) {
> > > > > >                   f34->bl_version = 7;
> > > > > >           } else {
> > > > > > -               dev_err(&f34->fn->dev, "%s: Unrecognized bootloader
> > > > > > version\n",
> > > > > > -                               __func__);
> > > > > > -               return -EINVAL;
> > > > > > +               dev_info(&f34->fn->dev, "%s: Unsupported bootloader
> > > > > > version: %u\n",
> > > > > > +                               __func__, f34->bootloader_id[1]);
> > > > > > +               return -ENODEV;
> > > > > >           }
> > > > > >           memset(&f34->v7.blkcount, 0x00, sizeof(f34->v7.blkcount));
> > > > > 
> 
