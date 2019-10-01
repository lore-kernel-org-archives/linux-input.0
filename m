From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] HID: hyperv: Add the support of hibernation
Date: Tue, 1 Oct 2019 14:40:23 -0400
Message-ID: <20191001184023.GC8171@sasha-vm>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
 <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190927120513.GM8171@sasha-vm>
 <PU1P153MB01698048162343130F34DAE0BF830@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB01698048162343130F34DAE0BF830@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: Jiri Kosina <jikos@kernel.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Sun, Sep 29, 2019 at 05:44:09PM +0000, Dexuan Cui wrote:
>> From: Sasha Levin <sashal@kernel.org>
>> Dexuan, I've been silently ignoring your patches for the past few weeks
>> for the same reason as Jiri has mentioned. I'll pick them all up once
>> the 5.4 merge window closes in a few days.
>
>Thanks, Sasha!
>
>BTW, I'll post a v2 for this patch, as IMO I may be able to get rid of the
>mousevsc_pm_notify in this patch by disabling the channel callback
>in the suspend function.

Okay, I'm ignoring this patch for now then.

--
Thanks,
Sasha
