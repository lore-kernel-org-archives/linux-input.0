From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: asus: Fix special function keys on T200TA
Date: Thu, 11 Jan 2018 15:21:59 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801111521040.11852@cbobk.fhfr.pm>
References: <20180105110919.30399-1-hdegoede@redhat.com> <20180105110919.30399-2-hdegoede@redhat.com> <CAO-hwJKyO+fWno7OaHBdki3pmCr183wh4NexkjYa73Jqi_ni7g@mail.gmail.com> <aea8b618-0e9a-8516-fb6a-d3409b361edf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933639AbeAKOWB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 Jan 2018 09:22:01 -0500
In-Reply-To: <aea8b618-0e9a-8516-fb6a-d3409b361edf@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, 11 Jan 2018, Hans de Goede wrote:

> >> Just like on the T100TA the T200TA HID descriptors for the 0xff32
> >> Asus vendor usage page need a small fixup. But on the T200TA the HID
> >> descriptors are larger because they have descrriptors for one more
> >> (unused) HID report appended.
> >>
> >> Extend the T100TA descriptor fixup to also check for the T200TA's
> >> descriptors size.
> > 
> > Sigh, both are:
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks. Jiri, what is the status of these ?

Over past weeks I have been completely swamped in the Meltdown/Spectre 
happines.

I hope to resume merging HID patches any time soon.

Sorry for the delays,

-- 
Jiri Kosina
SUSE Labs

