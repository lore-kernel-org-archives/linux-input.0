From: simon@mungewell.org
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Fri, 20 Jan 2012 13:50:01 -0500
Message-ID: <e79444a78f0412701e85c030f4d2b4e1.squirrel@mungewell.org>
References: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
    <2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
    <CAM1yFZ82ZqJ+DAh2fU+Lqijcm=r6DE_EmCR8OX7M7ubNRMxyyg@mail.gmail.com>
    <07591daed833aaf50ea155c918cd04e0.squirrel@mungewell.org>
    <CAM1yFZ_eD2gV-vEwQp+BmD5OJxhH7ov3hqYRUBLtNm-Cp8GLGg@mail.gmail.com>
    <747fc1e52c224cb3cc1c4b37c9de9bb7.squirrel@mungewell.org>
    <CAM1yFZ_FWMrRH6a_nW1AW6vZcmC67LNKO0rsCWc1G1KSg9Z8bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:53004 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab2ATSuC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jan 2012 13:50:02 -0500
In-Reply-To: <CAM1yFZ_FWMrRH6a_nW1AW6vZcmC67LNKO0rsCWc1G1KSg9Z8bQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: linux-input@vger.kernel.org


>> On that machine I have a kernel version '3.0+dfp' which is a patched
>> build
>> made when I was testing Michal's changes.
>
> Would you please post the link of that patch here?

It was like 8 months ago that I built it.... :-( The patches (if you need
them) are on the kernel mailing list.

> Reason - To make this wheel work on 10 computers, we'll have to compile
> the
> kernel 10 times since the old configuration will have to be copied for
> "make oldconfig".

I don't really understand why you would want to build seperately on each
machine, either grab a binary kernel RPM from the site I linked before ()
or use one machine to create your own kernel package (either RPM or just
TAR).

Does anyone really have machine specific builds these days (given disk
space is cheap and the modules system works really well)?

Simon


