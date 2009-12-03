From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Thu, 3 Dec 2009 00:21:21 -0800
Message-ID: <20091203082120.GL9121@core.coreip.homeip.net>
References: <1259826317-18809-26-git-send-email-corentincj@iksaif.net> <1259826317-18809-27-git-send-email-corentincj@iksaif.net> <1259826317-18809-28-git-send-email-corentincj@iksaif.net> <1259826317-18809-29-git-send-email-corentincj@iksaif.net> <1259826317-18809-30-git-send-email-corentincj@iksaif.net> <1259826317-18809-31-git-send-email-corentincj@iksaif.net> <1259826317-18809-32-git-send-email-corentincj@iksaif.net> <1259826317-18809-33-git-send-email-corentincj@iksaif.net> <20091203075404.GK9121@core.coreip.homeip.net> <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61670 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZLCIVT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 03:21:19 -0500
Content-Disposition: inline
In-Reply-To: <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Dec 03, 2009 at 09:12:52AM +0100, Corentin Chary wrote:
> On Thu, Dec 3, 2009 at 8:54 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Dec 03, 2009 at 08:45:16AM +0100, Corentin Chary wrote:
> >> This keycode could be used in a lot of platform specific drivers.
> >> For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
> >> drivers (bt/wl: off/off, on/off, off/on, on/on).
> >>
> >> Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
> >> are rarely used.
> >>
> >
> > Is there any application support for such cycling? IOW does anyone cares
> > to do such cycling?
> 
> On Asus laptops (both asus and eeepc) the Fn+F2 key cycle
> (bluetooth/wlan: on/on, on/off, off/on, off/off) on windows.
> On Linux, it only produces a KEY_WLAN keycode.
> 

I understand this. I guess the question is whether people working on
system infrastructure (dbus, Networkmanager, etc) care about having such
functionality on Linux? The reason I am asking is that we added all
KEY_WIMAX and so on defines but I am not usre if anyone wants them.

-- 
Dmitry
