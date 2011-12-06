From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Tue, 06 Dec 2011 09:10:18 -0800
Message-ID: <4EDE4C7A.1010802@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz> <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com> <4ED90E6D.8090402@goop.org> <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com> <4ED9BDF8.3010600@goop.org> <CAD2FfiE-rg-1bMmVpYzBhnQcBMKKKO4WPnu0bvx+pvdFnpARrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:54214 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab1LFRZw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Dec 2011 12:25:52 -0500
In-Reply-To: <CAD2FfiE-rg-1bMmVpYzBhnQcBMKKKO4WPnu0bvx+pvdFnpARrQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On 12/06/2011 01:56 AM, Richard Hughes wrote:
> On 3 December 2011 06:13, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> The only functional change I made from Daniel's patch is keeping the power_supply type as BATTERY rather
>> than USB.
> How is upower supposed to know that the device is:
>
> a) a mouse
> b) not powering the computer
>
> Any ideas welcome. I suppose we could look at the hid device, but this
> seems like a hack. Thanks.

(CC power_supply maintainers: the discussion is how to represent
power_supplies for self-powered HID devices like wireless mice.)

I've been thinking about this.  I think the obvious fix is that the
power_supply should have a link to the root of the device tree it
powers.   So the system battery and line power should point to the root,
whereas a battery powered device would point to itself.
Something like  HID UPS would appear to be in the middle of the USB
devices, but actually powers the whole machine (or more).

In other words, the power_supply device is the management interface for
the power supply, and it appears in the device tree wherever it was
detected, but that location only has a vague and implicit relationship
with the hardware it actually powers; it needs another attribute to
explicitly denote that information.

And if the device being pointed to is a mouse, then upower knows its
powering a mouse.

I'll look at putting together a patch to see if my suggestion makes any
sense in practice.

Thanks,
    J
