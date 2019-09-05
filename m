From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Date: Thu, 5 Sep 2019 11:11:41 -0400
Message-ID: <20190905151141.GB1616@sasha-vm>
References: <1566269763-26817-1-git-send-email-decui@microsoft.com>
 <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909041623050.31470@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1909041623050.31470@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 04, 2019 at 04:23:27PM +0200, Jiri Kosina wrote:
>On Tue, 3 Sep 2019, Dexuan Cui wrote:
>
>> > Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>> >
>> > This is a purely Hyper-V specific change.
>>
>> Hi Jiri, Benjamin,
>> Are you OK if this patch for the Hyper-V HID driver goes through the Hyper-V
>> tree maintained by Sasha Levin? It's a purely Hyper-V change, and I have
>> been using the patch for several months and there is no regression.
>
>No problem with that. Feel free to add
>
>	Acked-by: Jiri Kosina <jkosina@suse.cz>
>
>in that case.

I've queued it up for hyperv-fixes, thank you!

--
Thanks,
Sasha
