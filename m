From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Mon, 25 Feb 2013 14:09:22 +0100
Message-ID: <CANq1E4QR42NyPe=SZGCpHL7Mzcic9YYxXG3v=G+WV9oNq+34oQ@mail.gmail.com>
References: <CAG_cf+dOuB-Xi9zDdXguj9S_-PpB98wi2v1LqbR7msPD+DSwgA@mail.gmail.com>
	<alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz>
	<alpine.LNX.2.00.1302251403250.2128@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:64425 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab3BYNKA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 08:10:00 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so1388947eek.41
        for <linux-input@vger.kernel.org>; Mon, 25 Feb 2013 05:09:59 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1302251403250.2128@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, David Herrmann <dh.herrmann@googlemail.com>, Linux Input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>

Hi Jiri

On Mon, Feb 25, 2013 at 2:03 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 18 Feb 2013, Jiri Kosina wrote:
>
>> > Change-Id: I737f6fc15911134b51273acf8d3de92fa5cc0f85
>>
>> Hi,
>>
>> thanks for finally proceeding on this front.
>>
>> Please provide your Signed-off-by line; without that, the patch can't be
>> accepted.
>
> Andrew, please ... ?

I got the new PATCH with the sign-off. Maybe you missed it?

Subject: [PATCH 1/3] HID: Separate struct hid_device's driver_lock
into two locks.
Date:	Mon, 18 Feb 2013 09:20:21 -0800
Message-Id: <1361208023-11500-2-git-send-email-andrew-vger@gizmolabs.org>

Cheers
David
