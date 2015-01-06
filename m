From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-replay captured data
Date: Tue, 6 Jan 2015 09:16:37 -0500
Message-ID: <CAN+gG=FHhCRRbNBJ7XH=a=rnYum-BLW8JcpqFJJaHPyPc+P0bg@mail.gmail.com>
References: <20150106111652.hwprplncqocwo0w0@webmail.fib.upc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61815 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbbAFOQh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 09:16:37 -0500
Received: by mail-qa0-f48.google.com with SMTP id k15so13945310qaq.21
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 06:16:37 -0800 (PST)
In-Reply-To: <20150106111652.hwprplncqocwo0w0@webmail.fib.upc.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: josep.sanchez.ferreres@est.fib.upc.edu
Cc: linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>

On Tue, Jan 6, 2015 at 5:16 AM,  <josep.sanchez.ferreres@est.fib.upc.edu> wrote:
> Hello!
>
> I'm not sure about what you meant by using evemu-record to record
> the data from hidraw3. As far as I know evemu-record is only able to
> record from the /dev/input interfaces right? If you meant hid-replay, I
> wasn't able to get any data from hidraw3.

Sorry, I meant hid-replay.
I need the output of the very first lines when you open the device.
There must be 3 lines at least, one starting with R:, one with I: and
one with N:
And yes, I know no events will be sent, but I need the output still.

Cheers,
Benjamin

PS: please use "reply-all" when replying to a thread to keep the
people involved in the loop.

>
> Could you please provide a more detailed explanation so I can get the data?
>
> Thank you very much!
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
