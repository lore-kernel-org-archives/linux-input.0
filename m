From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Commit *driver core: emit uevents when device is bound to a
 driver* causes regression
Date: Fri, 6 Apr 2018 11:26:00 -0700
Message-ID: <CAKdAkRRufjoF9Wp5haCv=5rF52UhFe5u-yXsd7DRuDz8LLjaUQ@mail.gmail.com>
References: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
 <20180406131820.GA4555@kroah.com> <22ee8cb0-5793-6ad6-d8e0-3e83a8c1361c@molgen.mpg.de>
 <20180406132720.GA16189@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406132720.GA16189@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>, Michael Tokarev <mjt@tls.msk.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Ben Caradoc-Davies <ben@transient.nz>, it+linux-input@molgen.mpg.de
List-Id: linux-input@vger.kernel.org

On Fri, Apr 6, 2018 at 6:27 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 06, 2018 at 03:24:39PM +0200, Paul Menzel wrote:
>> Dear Greg,
>>
>>
>> On 04/06/18 15:18, Greg Kroah-Hartman wrote:
>> > On Fri, Apr 06, 2018 at 02:20:40PM +0200, Paul Menzel wrote:
>>
>> > > Commit 1455cf8 (driver core: emit uevents when device is bound to a
>> > > driver) [1], introduced in Linux 4.14-rc1, causes a regression in user
>> > > space.
>> > >
>> > > After disconnecting USB devices, they are still shown as plugged in [2][3].
>> > >
>> > > > I seem to be having a similar issue, but with an iPhone X using USB
>> > > > to provide internet access. Even after the phone is disconnected, it
>> > > > still shows up as "loaded active plugged". The only way to fix this
>> > > > is to reboot or use a different USB port.
>> > >
>> > > `git bisect` shows that commit 1455cf8 (driver core: emit uevents when
>> > > device is bound to a driver) is at fault [4].
>> > >
>> > > As user space should not break with newer Linux kernels, do you know what to
>> > > do about that or can you think of a fix?
>> >
>> > I thought we fixed this with follow-on patches, are you sure you are
>> > using the latest 4.14.y kernel that has been released?
>>
>> Here we are using Linux 4.14.30. We can try newer versions next week.
>
> Ah, no, 4.14.30 should be fine.
>
> I saw the patch listed in the debian bug report, so this only happens
> for the MTP type devices?  That was a really odd "filter" that it was
> trying to use before.
>
> So this is only for userspace programs, and one specifically?  And for
> only one type of device?  What device, MTP devices?

So looking at reports, gvfs is fixed, upowerd simply uses g_warning()
for actions it does nto understand and I'll send a patch lowering this
to g_debug(); what else is having trouble with the new actions?

Thanks.

-- 
Dmitry
