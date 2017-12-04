From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] HID: asus: Add product-id for the T100TAF and T100HA
 keyboard docks
Date: Mon, 4 Dec 2017 09:24:36 +0100
Message-ID: <3c8f0915-4273-0821-c4c3-3cf088d8bbea@redhat.com>
References: <20171126154010.954-1-hdegoede@redhat.com>
 <20171127083531.GD30708@mail.corp.redhat.com>
 <47b2d7b2-c24b-2705-5be6-9c100d0ed4c0@redhat.com>
 <nycvar.YFH.7.76.1712010954120.11505@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1712010957160.11505@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753203AbdLDIYl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 4 Dec 2017 03:24:41 -0500
In-Reply-To: <nycvar.YFH.7.76.1712010957160.11505@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi,

On 01-12-17 09:58, Jiri Kosina wrote:
> On Fri, 1 Dec 2017, Jiri Kosina wrote:
> 
>>> I'm afraid it is probably the first reason and not the second reason,
>>> when I was working on Linux webcam support one of the issues was that in
>>> many Asus laptops the webcam module is mounted upside down and thus sends
>>> an upside-down picture. I asked via via if Asus internally had a list
>>> of which webcams are upside down, the answer was: no. Asus simply maintains
>>> a hacked-together driver-repository per model laptop, in which they
>>> put hacks until the driver works for that model.
>>
>> Man, the world is sick :)
>>
>> I am unhappily (not because of you, but because of ASUS) applying to
>> for-4.15/upstream-fixes. Thanks,
> 
> Actually from the log and from the base you chose to put the patch on top
> I understand that you feel it's okay to have this for 4.16, so I am
> applying it for 4.16 to minimize conflict amount due to quirk handling
> revamp.

Ack, given that this turned out to be a bit more involved fix then
I thought at first I aimed it at 4.16.

Regards,

Hans
