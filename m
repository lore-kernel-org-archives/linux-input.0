From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 22:56:42 +0530
Message-ID: <5d5443650907151026y670087fesa3022e37f68e2d8@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <20090714175201.GB14661@dtor-d630.eng.vmware.com>
	 <20090715134855.GB2538@elf.ucw.cz>
	 <20090715152702.GB21611@dtor-d630.eng.vmware.com>
	 <a55d774e0907150833g494dc91dxe7695543b61b2e50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:38129 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbZGOR0n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 13:26:43 -0400
In-Reply-To: <a55d774e0907150833g494dc91dxe7695543b61b2e50@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Hi Brian,

On Wed, Jul 15, 2009 at 9:03 PM, Brian Swetland<swetland@google.com> wr=
ote:
> On Wed, Jul 15, 2009 at 8:27 AM, Dmitry
> Torokhov<dmitry.torokhov@gmail.com> wrote:
>> On Wed, Jul 15, 2009 at 03:48:55PM +0200, Pavel Machek wrote:
>>> On Tue 2009-07-14 10:52:12, Dmitry Torokhov wrote:
>>> >
>>> > ABS_HAT is pretty unusual for a touchscreen...
>>>
>>> It is trying to do something useful for multitouch. People actually
>>> use multitouch on HTC dream. I guess I can strip it from version be=
ing
>>> merged...
>>
>> What about converting it to emit ABS_MT_* events added specifically
>> for the multitouch protocol?
>
> I believe at the time the driver was written, those events did not
> exist. =A0If the input framework has more appropriate events for the
> "2nd finger" (which is how synaptics represents MT on this panel), we
> should definitely switch to them.
>

Yes, MT events were added recently and they are working. Please check
this demo based on MT events.

http://www.linuxfordevices.com/c/a/News/Linux-multitouch-technology-dem=
od/

Also, please confirm if polling mode is really used in some h/w
configuration, if not as said by Dmitry, we can remove it and do clean
integration with threaded irq.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
