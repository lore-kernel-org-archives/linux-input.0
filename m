From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Mon, 28 Nov 2011 22:33:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
 <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39447 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab1K1VdH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Nov 2011 16:33:07 -0500
In-Reply-To: <4ECCB38A.8000503@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On Wed, 23 Nov 2011, Jeremy Fitzhardinge wrote:

> Some HID devices, such as my Bluetooth mouse, report their battery
> strength as an event.  Rather than passing it through as a strange
> absolute input event, this patch registers it with the power_supply
> subsystem as a battery, so that the device's Battery Strength can be
> reported to usermode.
> 
> The battery appears in sysfs names
> /sys/class/power_supply/hid-<UNIQ>-battery, and it is a child of the
> battery-containing device, so it should be clear what it's the battery of.
> 
> Unfortunately on my current Fedora 16 system, while the battery does
> appear in the UI, it is listed as a Laptop Battery with 0% charge (since
> it ignores the "capacity" property of the battery and instead computes
> it from the "energy*" fields, which we can't supply given the limited
> information contained within the HID Report).
> 
> Still, this patch is the first step.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

Thanks Jeremy, I am going to queue this for 3.3.

-- 
Jiri Kosina
SUSE Labs
