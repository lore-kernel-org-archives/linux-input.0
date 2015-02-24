From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Tue, 24 Feb 2015 13:27:51 +0200
Message-ID: <54EC6037.7000903@gmail.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com> <54E45A82.7090706@gmail.com> <20150218200417.GC5928@mail.corp.redhat.com> <54E5CEE9.1050909@gmail.com> <20150223224433.GB28675@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46418 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbBXL15 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 06:27:57 -0500
In-Reply-To: <20150223224433.GB28675@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/24/2015 12:44 AM, Benjamin Tissoires wrote:
> On Feb 19 2015 or thereabouts, Nikolai Kondrashov wrote:
>> On 02/18/2015 10:04 PM, Benjamin Tissoires wrote:
>>> On Feb 18 2015 or thereabouts, Nikolai Kondrashov wrote:
> [snipped]
>>>
>>> OK, will respin the patches for your out of the tree driver.
>>
>> Thanks a lot, Benjamin!
>>
>
> OK, so after a little bit of struggle, I think we need to work both
> upstream and on the out of the tree driver. Most of the current patches
> in the out of the tree driver can be included right now and there is no
> need to make hundreds of tests for these.
>
> If you don't mind, I'll post them tomorrow with the follow up of the
> patches I know will not break the tablets. Then, we can sync on the
> digimend tree and ask users to test the "abstract buttons events"
> reporting mode. It will help me and will also speed up the process of
> having everything included sooner.
>
> How does that sound?

Sure, go ahead and I'll help as much as I can.

Thanks, Benjamin!

Nick
