From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 00/13] HID: add support of Logitech touchpads and special devices
Date: Tue, 28 Oct 2014 16:05:43 -0400
Message-ID: <CAN+gG=GET=FLmte9kQOtS+x=HPaTdgEu4HxuydHXBx1GZksNRw@mail.gmail.com>
References: <1412097515-17241-1-git-send-email-benjamin.tissoires@redhat.com>
	<alpine.LNX.2.00.1410011016160.26311@pobox.suse.cz>
	<20141001131008.GB18756@mail.corp.redhat.com>
	<CAG_cf+fYGATBL9Sgvvp7CaScP112fiqiyuR0gBdkS-424S3Kog@mail.gmail.com>
	<alpine.LNX.2.00.1410031308360.14259@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36550 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaJ1UFo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 16:05:44 -0400
In-Reply-To: <alpine.LNX.2.00.1410031308360.14259@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

On Fri, Oct 3, 2014 at 7:09 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 2 Oct 2014, Andrew de los Reyes wrote:
>
>> I've tested these patches successfully on a Chromebook Pixel with the
>> following devices:
>>
>> - T650 touchpad
>> - TK820 keyboard/touchpad
>> - Original WTP touchpad
>>
>> I also tested a touch mouse and as expected it continued to function
>> as a plain USB mouse. The TK820 was indeed broken into two devices,
>> with autorepeat enabled for the keyboard only. The other two devices
>> behaved as expected with no perceived regressions.
>>
>> In short, from a functionality perspective I'm happy with these
>> patches. I will let others discuss code structure.
>
> Thank you. Can I use
>
>         Tested-by: Andrew de los Reyes <andrew-vger@gizmolabs.org>
>
> once / if I am merging this patchset?
>

I am pretty sure this is not required too, but I am raising this one
again in Jiri's pile of things to review.
Sorry Jiri, I did not forget about it :)

Cheers,
Benjamin
