From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/2] xen pvfb: Para-virtual framebuffer,	keyboard and
 pointer driver
Date: Fri, 22 Feb 2008 14:31:55 -0800
Message-ID: <47BF4D5B.5020509@goop.org>
References: <871w76ejdg.fsf@pike.pond.sub.org>	<87skzmd4qc.fsf@pike.pond.sub.org> <47BDDF97.7070001@goop.org> <8763whbiy8.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:42265 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758587AbYBVWfM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Feb 2008 17:35:12 -0500
In-Reply-To: <8763whbiy8.fsf@pike.pond.sub.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Armbruster <armbru@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com

Markus Armbruster wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>
>   
>> Markus Armbruster wrote:
>>     
>>> This is a pair of Xen para-virtual frontend device drivers:
>>> drivers/video/xen-fbfront.c provides a framebuffer, and
>>> drivers/input/xen-kbdfront provides keyboard and mouse.
>>>   
>>>       
>> Unless they're actually inter-dependent, could you post this as two
>> separate patches?  I don't know anything about these parts of the
>> kernel, so it would be nice to make it very obvious which changes are
>> fb vs mouse/keyboard.
>>     
>
> I could do that do that, but the intermediate step (one driver, not
> the other) is somewhat problematic: the backend in dom0 needs both
> drivers, and will refuse to complete device initialization unless
> they're both present.
>   

That's OK.  In that case keep them together.

    J
