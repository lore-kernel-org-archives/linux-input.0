From: Brian Swetland <swetland@google.com>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 08:33:38 -0700
Message-ID: <a55d774e0907150833g494dc91dxe7695543b61b2e50@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <20090714175201.GB14661@dtor-d630.eng.vmware.com>
	 <20090715134855.GB2538@elf.ucw.cz>
	 <20090715152702.GB21611@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:41893 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbZGOPdm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 11:33:42 -0400
In-Reply-To: <20090715152702.GB21611@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Wed, Jul 15, 2009 at 8:27 AM, Dmitry
Torokhov<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jul 15, 2009 at 03:48:55PM +0200, Pavel Machek wrote:
>> On Tue 2009-07-14 10:52:12, Dmitry Torokhov wrote:
>> >
>> > ABS_HAT is pretty unusual for a touchscreen...
>>
>> It is trying to do something useful for multitouch. People actually
>> use multitouch on HTC dream. I guess I can strip it from version being
>> merged...
>
> What about converting it to emit ABS_MT_* events added specifically
> for the multitouch protocol?

I believe at the time the driver was written, those events did not
exist.  If the input framework has more appropriate events for the
"2nd finger" (which is how synaptics represents MT on this panel), we
should definitely switch to them.

Brian
