From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] HID: hyperv: Add the support of hibernation
Date: Fri, 27 Sep 2019 08:05:13 -0400
Message-ID: <20190927120513.GM8171@sasha-vm>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
 <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: Jiri Kosina <jikos@kernel.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 27, 2019 at 05:42:31AM +0000, Dexuan Cui wrote:
>> From: Jiri Kosina <jikos@kernel.org>
>> Sent: Thursday, September 26, 2019 6:23 AM
>> To: Dexuan Cui <decui@microsoft.com>
>>
>> On Thu, 26 Sep 2019, Jiri Kosina wrote:
>>
>> > > > This patch is basically a pure Hyper-V specific change and it has a
>> > > > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
>> > > > Implement
>> > > > suspend/resume for VSC drivers for hibernation"), which is on Sasha
>> Levin's
>> > > > Hyper-V tree's hyperv-next branch [ ... snipped ...]
>> > > >
>> > > > I request this patch should go through Sasha's tree rather than the
>> > > > input subsystem's tree.
>> > > >
>> > > > Hi Jiri, Benjamin, can you please Ack?
>> > >
>> > > Hi Jiri, Benjamin,
>> > > Can you please take a look at the patch?
>> >
>> > Hi Dexuan,
>> >
>> > I am planning to process it once 5.4 merge window is over and thus hid.git
>> > is open again for 5.5 material.
>>
>> Ah, now I see you asked for this go through hyperv tree. For that, feel
>> free to add
>> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
>> Jiri Kosina
>
>Thanks for the Ack, Jiri!
>
>I have a bunch of patches, including this one, to support Linux VM's hibernation
>when the VM runs on Hyper-V. I just feel it would be better for all of them to
>go through the Hyper-V tree. :-)

Thank Dexuan, Jiri,

Dexuan, I've been silently ignoring your patches for the past few weeks
for the same reason as Jiri has mentioned. I'll pick them all up once
the 5.4 merge window closes in a few days.

--
Thanks,
Sasha
