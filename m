From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [REGRESSION] panic with Wacom One Tablet on 4.4.x kernel
Date: Fri, 25 Mar 2016 15:35:07 +0100
Message-ID: <CAN+gG=G=cBVw2_xMfcddYuLEs=SHBccD3Q1jGG0XFyz4PbSb7w@mail.gmail.com>
References: <56E9D929.70101@redhat.com>
	<CAF8JNhKJLzvj=Xe8ibNCJ6-U9fJqjHFzg0uibFTBSxR4t-AmXA@mail.gmail.com>
	<alpine.LNX.2.00.1603241530370.3656@cbobk.fhfr.pm>
	<alpine.LNX.2.00.1603241534210.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36244 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbcCYOfJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2016 10:35:09 -0400
In-Reply-To: <alpine.LNX.2.00.1603241534210.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Laura Abbott <labbott@redhat.com>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, Mar 24, 2016 at 3:37 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Thu, 24 Mar 2016, Jiri Kosina wrote:
>
>> > Yes, please provide a bisect report so we get a clue.
>> >
>> > I do not have a "Wacom One". I have a Wacom Bamboo Pen, which goes
>> > through the same code base as "Wacom One". I tested kernel 4.4.4. I
>> > don't see the issue.
>>
>> Laura, do we have any result from the bisect please?
>
> BTW seems like wacom_get_report() got EPIPE and bailed out.
>
> We used to retry on EPIPE before aef3156d72. Would it make sense to retest
> with that commit reverted?

Well, the problem is the device exposes a useless interface that
behaves like it should be working, but there are no sensors connected
to it. I wouldn't be surprised if the device just complains when we
are pocking at it when we should not.

>
> Could be that the device is for some reason causing only temporary EPIPE
> that eventually gets fixed over time.
>
> I still don't exactly see how that'd cause the null pointer dereference
> later, but retval handling wacom_get_report() might possibly need some
> loving care as well, looking quickly at the code. But that still needs to
> be investigated.

See the patch I just sent. The difference from a HID point of view
between a Bamboo Pen+Touch and a Bamboo ONE is null. However, the
Bamboo ONE has no sensors connected to the Pad and Touch interface,
and generates some spurious events. Given that all the protocol is
hardcoded in the driver, wacom.ko tries to access the pad input node
but there was none because the device is marked as "Pen only".

The solution is to actually detect the Pen only devices and check that
the HID report descriptor matches a Pen only (or detect touch+pad
interface, like I did). This was, we just don't care about the events
on the not-used interface and everybody lives happily ever after.

Cheers,
Benjamin
