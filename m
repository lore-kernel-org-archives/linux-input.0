From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Driver for Logitech M560
Date: Thu, 9 Apr 2015 13:35:07 -0400
Message-ID: <CAN+gG=Hhp8AiUgnDAC3Nda-rdVgJHg7Rgs1e9HajAws-_-L+Cw@mail.gmail.com>
References: <5404C6F4.1000800@inwind.it>
	<CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>
	<5409F740.9000706@inwind.it>
	<20150409144154.36fbce15dcdf4556544ee8a7@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34639 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613AbbDIRfI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Apr 2015 13:35:08 -0400
Received: by qkgx75 with SMTP id x75so132005616qkg.1
        for <linux-input@vger.kernel.org>; Thu, 09 Apr 2015 10:35:07 -0700 (PDT)
In-Reply-To: <20150409144154.36fbce15dcdf4556544ee8a7@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Goffredo Baroncelli <kreijack@inwind.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Dario Righelli <drighelli@gmail.com>

Hi Antonio,

On Thu, Apr 9, 2015 at 8:41 AM, Antonio Ospite <ao2@ao2.it> wrote:
> On Fri, 05 Sep 2014 19:47:44 +0200
> Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
>> On 09/03/2014 11:36 PM, Benjamin Tissoires wrote:
>> > Hi Goffredo,
>> >
>> > On Mon, Sep 1, 2014 at 3:20 PM, Goffredo Baroncelli <kreijack@inwind.it> wrote:
>> >> Hi Benjamin,
>> >>
>> >> following the Nestor suggestion, I rewrote the driver for the
>> >> mouse Logitech M560 on the basis of your work (branch "for-whot").
>> >
>> > Just for the record. This branch is located here:
>> > https://github.com/bentiss/hid-logitech-dj/tree/for-whot and I
>> > *really* need to finish this work so that everything can go upstream
>> > :(
>>
>
> Hi Benjamin, any news about upstreaming this work?

The hidpp / raw touchpad mode is already upstream since the v3.19 kernel. \o/

We just need to port Goffredo's changes now and push them too.
There has been some differences since this branch was published. The
main is that there is no more special subdrivers in several files,
everything is handled in hidpp. I think the logic behind is somewhat
the same so it should not be too much a problem to do the work.

Cheers,
Benjamin

>
>> :-) For me this is not a problem. I solved my issue (I made a dkms
>> package for this mouse), but I want to share my effort..
>>
>
> Goffredo, is this the latest version of your dkms-enabled external
> module?
> https://github.com/kreijack/hid-logitech-dj/tree/m560-dkms
>
> Thanks,
>    Antonio
>
> --
> Antonio Ospite
> http://ao2.it
>
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
