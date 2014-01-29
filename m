From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big enough
Date: Wed, 29 Jan 2014 09:36:30 +0100
Message-ID: <CANq1E4TW+GU=oaW0tXb=Tun9HMtr26u-PC3H6BsLot560ANgog@mail.gmail.com>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com>
	<3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org>
	<CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com>
	<alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
	<CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com>
	<alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz>
	<alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:53508 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaA2Igb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 03:36:31 -0500
In-Reply-To: <alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

Hi

On Tue, Jan 28, 2014 at 9:53 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 7 Jan 2014, Jiri Kosina wrote:
>
>> > > So doing kzalloc(rsize, GFP_ATOMIC) in the HID-core for now, and copying
>> > > the buffer around, seems like only viable solution for now, with the
>> > > outlook of removing this ugliness once hid-core honors 'size' properly.
>> >
>> > Should I resend the patches and move it to hid_input_report() for now?
>> > Or are you getting something in yourself?
>>
>> Due to various reasons I will not have access to any testing HW for the
>> upcoming 2-3 days, so if you can cook something up in that timeframe, it'd
>> be appreciated.
>>
>> Otherwise I'll be working on it by the end of this week.
>
> David,
>
> just got back to this, finally ... did you have time to work on this at
> all, or should I just start from scratch?

Sorry, no. Fosdem is this weekend and I needed to get my code ready
for that. But I'll finally have time again next week.

Thanks
David
