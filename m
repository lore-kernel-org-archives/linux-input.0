From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Sun, 6 Dec 2009 09:21:12 +0100
Message-ID: <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com>
References: <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
	 <20091203075404.GK9121@core.coreip.homeip.net>
	 <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
	 <20091206065829.GI5340@wrars-comp.wrarsdomain>
	 <20091206071751.GD14651@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f197.google.com ([209.85.212.197]:44032 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbZLFIVG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 03:21:06 -0500
In-Reply-To: <20091206071751.GD14651@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrey Rahmatullin <wrar@altlinux.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Dec 6, 2009 at 8:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Dec 06, 2009 at 11:58:29AM +0500, Andrey Rahmatullin wrote:
>> On Thu, Dec 03, 2009 at 09:12:52AM +0100, Corentin Chary wrote:
>> > >> This keycode could be used in a lot of platform specific drivers.
>> > >> For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
>> > >> drivers (bt/wl: off/off, on/off, off/on, on/on).
>> > >>
>> > >> Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
>> > >> are rarely used.
>> > > Is there any application support for such cycling? IOW does anyone cares
>> > > to do such cycling?
>> > On Asus laptops (both asus and eeepc) the Fn+F2 key cycle
>> > (bluetooth/wlan: on/on, on/off, off/on, off/off) on windows.
>> > On Linux, it only produces a KEY_WLAN keycode.
>> Default eee901's Xandros cycles and even shows an OSD with BT and WLAN
>> state images.
>>
>
> You are describing the visible result. Whether it is done as a custom
> policy to KEY_WLAN presses or utilizes a separate key definition - is
> not known.
Old xandros builds use the acpi event.
New builds have switched to eeepc-laptop (based on my 2.6.30
backport), so they may use an input event (KEY_WLAN).

> Anyway, we got the response form wireless developers and infrastructure
> people and thyy do not care about having a new defintion so I guess that
> settles it.
Yep

-- 
Corentin Chary
http://xf.iksaif.net
