From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: evdev: avoid storing newest SYN_REPORT when
 dropping all events
Date: Tue, 29 Dec 2015 23:32:25 +0530
Message-ID: <CADYu308-H5A9RZPP=Daxbde2FXZjbWFiJXRzOSoKOmg4qUEy+Q@mail.gmail.com>
References: <1450985148-804-1-git-send-email-a.mathur@samsung.com>
	<CAKdAkRR0aiziybrsDnvNwC7qCY7vg3K4UHaWfwkZ9oX7hguQOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35938 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbbL2SC0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Dec 2015 13:02:26 -0500
In-Reply-To: <CAKdAkRR0aiziybrsDnvNwC7qCY7vg3K4UHaWfwkZ9oX7hguQOQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hello Mr. Torokhov,

On Tue, Dec 29, 2015 at 5:11 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Aniroop,
>
> On Thu, Dec 24, 2015 at 11:25 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>> The newest event can be SYN_REPORT in case of dropping all old events when
>> buffer is full, but as now there is no device data available to read so
>> lets drop SYN_REPORT as well and store only SYN_DROPPED.
>>
>
> We can not drop the SYN_REPORT event in this case as userspace needs
> it to determine if the events that are coming after SYN_DROPPED are
> part of a full packet or if they belong to a partial packet. From
> Documentation/input/event-codes.txt:
>
> * SYN_DROPPED:
>   - Used to indicate buffer overrun in the evdev client's event queue.
>     Client should ignore all events up to and including next SYN_REPORT
>     event and query the device (using EVIOCG* ioctls) to obtain its
>     current state.
>

Okay I see.

In case of buffer overrun, how about handling the partial packet case
in evdev handler itself and free evdev client from handling it ?

Normally, evdev buffer contain only full packets. But in case of dropping
events, buffer would contain a partial packet almost all times and hence
evdev client would have to handle the case of partial packet and
as documentation says, client will ignore the events until new packet
starts. So as a new protocol, after buffer overrun occurs, evdev handler
can ignore the events until SYN_REPORT occurs and then start storing
events. This way buffer will contain full packet as always and reading
would be simplified for evdev clients.
Accordingly, document can also be updated.

Please let me know your opinion about it.

Thanks and Regards,
Aniroop Mathur


> Thanks.
>
> --
> Dmitry
