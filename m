From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] autocentering support for Logitech Force 3D Pro
Date: Wed, 20 May 2009 20:32:28 +0300
Message-ID: <4A143EAC.2000505@gmail.com>
References: <bb829a0b0905081244j36d069bfre73eba5d170494b3@mail.gmail.com> <alpine.LNX.2.00.0905111705540.22712@wotan.suse.de> <bb829a0b0905110913o1a1c20hb73c7ba0f3905bd5@mail.gmail.com> <alpine.LNX.2.00.0905151607240.22712@wotan.suse.de> <20090516005012.GA9564@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:44385 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbZETRcp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 13:32:45 -0400
In-Reply-To: <20090516005012.GA9564@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, =?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP?= =?UTF-8?B?0YjQvtCy?= <sergey.belyashov@gmail.com>, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, May 15, 2009 at 04:08:52PM +0200, Jiri Kosina wrote:
>> On Mon, 11 May 2009, ?????? ??????? wrote:
>>
>>>    Of course I agree.
>> I have applied the autocentering support patch for 0x286, thanks.
>>
>>>    How about axes information in EVIOCGBIT(EV_FF,...)?
>> Anssi, Dmitry, what do you think?
>>
> 
> I'd say no... Can we guarantee that all stated FF effects would be
> always applicable to every one of the ABS events types returned by
> EVIOCGBIT(EV_FF,...)?

I agree with no.

-- 
Anssi Hannula
