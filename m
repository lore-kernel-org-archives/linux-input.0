From: Ryan Bourgeois <bluedragonx@gmail.com>
Subject: Re: [PATCH] MacBook Pro Retina Keyboard Support
Date: Tue, 10 Jul 2012 10:31:07 -0500
Message-ID: <CAMUYeofVY-2f8OzG8fSZ3Vusg+2ek==P79fQdOiTh6DF4V+-bw@mail.gmail.com>
References: <20120709084534.GA4347@polaris.bitmath.org>
	<alpine.LNX.2.00.1207101147260.19366@pobox.suse.cz>
	<20120710100609.GA4314@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40076 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab2GJPbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 11:31:09 -0400
Received: by weyx8 with SMTP id x8so86365wey.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jul 2012 08:31:08 -0700 (PDT)
In-Reply-To: <20120710100609.GA4314@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tue, Jul 10, 2012 at 5:06 AM, Henrik Rydberg <rydberg@bitmath.se> wrote:
> On Tue, Jul 10, 2012 at 11:48:00AM +0200, Jiri Kosina wrote:
>> On Mon, 9 Jul 2012, Henrik Rydberg wrote:
>>
>> > Please keep the patch message clear of things you do not want to end
>> > up in the git log. Also, if you could manage to get an Originally-by:
>> > or Tested-by from the right person, that would be splendid.
>>
>> Also, Ryan, the patch has been corrupted (line-wrapping), likely by your
>> mail client, so I can't apply it as-is.
>>
>> Could you please fix that up, and resend?
>
> Since it seemed reasonable to add the mouse-ignore lines to the same
> patch, I fixed up the patch in the process and resent yesterday.
>
> Thanks,
> Henrik

Thanks, Henrik. I wasn't aware of the mouse ignore changes. I had
written and tested the keyboard patch before I discovered the patches
on the OpenSUSE forums. I had not tested the trackpad changes myself
which is why I did not include them. I've been fiddling around with
the hybrid graphics support so I haven't run an X session on the
laptop yet.

-Ryan
