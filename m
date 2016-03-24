From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH 0/2] hid: corsair: Driver simplification and new supported device
Date: Thu, 24 Mar 2016 16:19:28 +0100
Message-ID: <CAM4jgCp5yPeRXHukGBLKYXOJev2VbrW5H4dREb_u=AX9vER_Tg@mail.gmail.com>
References: <cover.1458744569.git.clement.vuchener@gmail.com>
	<alpine.LNX.2.00.1603241527510.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35429 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbcCXPTa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 11:19:30 -0400
In-Reply-To: <alpine.LNX.2.00.1603241527510.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

2016-03-24 15:30 GMT+01:00 Jiri Kosina <jikos@kernel.org>:
> On Wed, 23 Mar 2016, =?UTF-8?q?Cl=C3=A9ment=20Vuchener?= wrote:
>
>> So, I decided to move all USB related features in user-space (as far as
>> I know, I was the only user, but if someone is looking for a
>> replacement, I wrote a small tool available here:
>> https://github.com/cvuchener/corsair-usb-config). This simplification
>> only leaves the usage code remapping part and the driver no longer
>> depends on USB and LED subsystems. This should make the driver easier to
>> maintain or to add new supported devices.
>
> While you are performing this move, is there anything that's actually
> preventing you from doing the remapping from userspace as well?
>
> HID subsystem has for long time been providing the setkeycode() hook for
> remapping usages, and udev (well, more precisely, that s*****d thing) is
> actually shipping a lot of hw-specific remap data these days.

Thanks for the tip, is it possible to ignore some usages with this
method (done in the default case)?

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
