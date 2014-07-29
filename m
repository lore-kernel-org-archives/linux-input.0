From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 00/12] HID: Convert UHID to new HID transport-layer
Date: Tue, 29 Jul 2014 21:03:52 +0200
Message-ID: <CANq1E4S-U0jk27QT2n15Br34jNJt6g30Fb4GwkKXRboTcVzDRg@mail.gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
	<alpine.LNX.2.00.1407292100150.16390@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:62305 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbaG2TDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 15:03:53 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so99037iec.11
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 12:03:52 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1407292100150.16390@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Tue, Jul 29, 2014 at 9:00 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 29 Jul 2014, David Herrmann wrote:
>
>> Hi
>>
>> When Benjamin cleanup up the transport layer, he left UHID mostly unconverted
>> due to ABI issues. I promised to take a look, so here're the patches.
>>
>> Most of the patches are fairly straightforward. Comments welcome. I tested an
>> old uhid-sample.c build and it still works, so I think I didn't break
>> backwards-compatibility.
>
> I will definitely take a look, but I can't promise I will be able to
> finish a review in time for 3.17.
>
> If you find this a severe issue, please let me know.

No time-pressure at all. Take your time.

Thanks
David
