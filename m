From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Wed, 07 Sep 2011 11:22:10 -0700
Message-ID: <4E67B652.5010406@zytor.com>
References: <4E17504F.5070806@zytor.com> <20110708204630.GA28623@core.coreip.homeip.net> <4E178320.7050401@zytor.com> <20110708223709.GB28623@core.coreip.homeip.net> <4E179033.9050806@zytor.com> <20110709003508.GC28623@core.coreip.homeip.net> <4E180BA5.4080808@zytor.com> <20110907181641.GA5678@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58689 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab1IGSWV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Sep 2011 14:22:21 -0400
In-Reply-To: <20110907181641.GA5678@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On 09/07/2011 11:16 AM, Dmitry Torokhov wrote:
> On Sat, Jul 09, 2011 at 01:04:53AM -0700, H. Peter Anvin wrote:
>> On 07/08/2011 05:35 PM, Dmitry Torokhov wrote:
>>>
>>> Input only need to do this compat stuff on read/write paths so maybe if
>>> you add plumbing similar to compat_ioctl we could switch owver to it.
>>>
>>
>> The problem is that read/write ties into a large number of system calls,
>> and input is the *only* subsystem which needs it.
>>
> 
> BTW, while listening to x32 resentation on LPC I realized that the need
> for compat tests on read/write paths in input subsystem is due to use of
> timeval in input_event structures. If x32 solved the time_t issue by
> moving to 64 bit times then input read/write should simply use native
> 64 bit operations.
> 
> That still leaves sysfs and proc business of course...
> 

I thought there were pointers, (or longs) there too.

In fact, we might have had the worst of both worlds here...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

