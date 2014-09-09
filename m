From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Tue, 9 Sep 2014 12:37:02 +0200
Message-ID: <CAMsZVf_Pe6r1AiM-5e-tewJaTESSNG3M6rbh8FT0AszkfswAdw@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409091141340.5523@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:54482 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319AbaIIKhD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Sep 2014 06:37:03 -0400
Received: by mail-qc0-f170.google.com with SMTP id r5so17558206qcx.29
        for <linux-input@vger.kernel.org>; Tue, 09 Sep 2014 03:37:02 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1409091141340.5523@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

I have seen reports for Gigabyte Osmium, Corsair Vengeance K-series
and QPAD MK-series. There are probably more. The reason I chose to not
make it a quirk specific to some specific hardware is that it feels
more like a general problem caused by the fact the there are two HID
key codes mapped to a single Linux key code.

On Tue, Sep 9, 2014 at 11:42 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 9 Sep 2014, Fredrik Hallenberg wrote:
>
>> Hi, time for a bump on this one.
>
> Do you have any idea how common this pattern is? How many keyboards have
> you encountered doing this?
>
> I hate to be polluting generic code with such strange quirks ... we've
> spent quite some time factoring those out to specific drivers.
> So knowing how commong this is could be helpful in deciding how to handle
> this.
>
> Thanks.
>
> --
> Jiri Kosina
> SUSE Labs
