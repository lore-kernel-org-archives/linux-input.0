From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: quirk ALWAYS_POLL needed with an unexpectedly high number of mice
Date: Fri, 27 Mar 2015 12:09:55 -0400
Message-ID: <CAN+gG=GNL2HiQFDrHs_SUSL+iyOtv92SRpqJMBYHOXDaaE5uSg@mail.gmail.com>
References: <1427448571.5783.41.camel@suse.de>
	<CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com>
	<1427463666.5783.55.camel@suse.de>
	<alpine.LNX.2.00.1503271609120.6781@pobox.suse.cz>
	<1427471969.26270.7.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34924 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbbC0QJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 12:09:56 -0400
Received: by qgh3 with SMTP id 3so121898296qgh.2
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 09:09:55 -0700 (PDT)
In-Reply-To: <1427471969.26270.7.camel@chaos.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oneukum@suse.de>, Johan Hovold <johan@kernel.org>, linux-input <linux-input@vger.kernel.org>

On Fri, Mar 27, 2015 at 11:59 AM, Jean Delvare <jdelvare@suse.de> wrote=
:
> Le Friday 27 March 2015 =C3=A0 16:10 +0100, Jiri Kosina a =C3=A9crit =
:
>> On Fri, 27 Mar 2015, Oliver Neukum wrote:
>> > Keeping things as is is fine by me but then I will need to add a l=
ot of
>> > quirky devices.
>>
>> I am still surprised that all of a sudden there is such a large flow=
 of
>> new devices that need it, and we didn't have a single one a few mont=
hs
>> ago.
>>
>> Given the fact that this all is being reported by single entitty, is=
 it a
>> possibility that they have some other faulty HW instead? Such as the=
 HUB
>> suspending at random incorrect points in time?
>
> I agree, I start wondering if maybe we've been barking up the wrong t=
ree
> since the beginning. I very much would like to know if all these
> "faulty" mouses would be so faulty when used on a different system.
>

Hmm... it looks like it's not host dependent unfortunately. We have a
(private) bug report for RHEL 6 where a customer wants to use the
following mouse:
http://www.compsource.com/pn/2MOUSEU1L/Keytronics-228/

I bought one and was able to reproduce the need for the quirk on
various systems.

Plus I noticed that if the mouse is raised over the surface (so the
sensor does not report anything), the bug does not appear.

So, to me, the USB output queue is full given that it is not polled by
the host and the chip within the USB mouse decides to
disconnect/reconnect to empty the queue. So nothing host specific.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
