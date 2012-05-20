From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
Date: Sun, 20 May 2012 12:40:14 +0200
Message-ID: <CANq1E4R_6ByuBALh0z9gxQzy5ZrT4-MY=6RqrcaVFgK0owjtxw@mail.gmail.com>
References: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMabAxO9fVN2DM=5xPJAVk_is3QoS1=+TGZPJAbY3TYHMQ@mail.gmail.com>
	<CANq1E4QaRHtGxt3d=Z2mvqAFhTY2zid20GGNZ2ZzHjStGepc+A@mail.gmail.com>
	<alpine.LNX.2.00.1205101218030.31253@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41608 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2ETKkQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 06:40:16 -0400
In-Reply-To: <alpine.LNX.2.00.1205101218030.31253@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>, linux-input@vger.kernel.org, marcel@holtmann.org, claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org

Hi Jiri

On Thu, May 10, 2012 at 12:19 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 3 May 2012, David Herrmann wrote:
>
>> > Thanks for your work, David. I'll test and review this new version.
>> > Did you find out the what is the problem when passing BUS_BLUETOOTH on
>> > the 'bus' field of the create request?
>>
>> I've spent some time looking into that but I haven't found the
>> problem, yet. Maybe Jiri can comment here.
>
> This should now all be handled correctly using the hid-generic mechanism.
> If you still see any problems with this (currently in linux-next, more
> precisely 'device-groups' branch in hid.git), please let me know.

That is working correctly now. Do you have any update on this patch?
There is no time pressure in merging it but I would like to get some
feedback what you are thinking about it so I can continue working on
it.

If you like I can resend it split into multiple patches. Let me know
of any problems with it.

> --
> Jiri Kosina
> SUSE Labs

Regards
David
