From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Sat, 5 Dec 2009 23:17:52 -0800
Message-ID: <20091206071751.GD14651@core.coreip.homeip.net>
References: <1259826317-18809-27-git-send-email-corentincj@iksaif.net> <1259826317-18809-28-git-send-email-corentincj@iksaif.net> <1259826317-18809-29-git-send-email-corentincj@iksaif.net> <1259826317-18809-30-git-send-email-corentincj@iksaif.net> <1259826317-18809-31-git-send-email-corentincj@iksaif.net> <1259826317-18809-32-git-send-email-corentincj@iksaif.net> <1259826317-18809-33-git-send-email-corentincj@iksaif.net> <20091203075404.GK9121@core.coreip.homeip.net> <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com> <20091206065829.GI5340@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091206065829.GI5340@wrars-comp.wrarsdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Rahmatullin <wrar@altlinux.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Dec 06, 2009 at 11:58:29AM +0500, Andrey Rahmatullin wrote:
> On Thu, Dec 03, 2009 at 09:12:52AM +0100, Corentin Chary wrote:
> > >> This keycode could be used in a lot of platform specific drivers.
> > >> For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
> > >> drivers (bt/wl: off/off, on/off, off/on, on/on).
> > >>
> > >> Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
> > >> are rarely used.
> > > Is there any application support for such cycling? IOW does anyone cares
> > > to do such cycling?
> > On Asus laptops (both asus and eeepc) the Fn+F2 key cycle
> > (bluetooth/wlan: on/on, on/off, off/on, off/off) on windows.
> > On Linux, it only produces a KEY_WLAN keycode.
> Default eee901's Xandros cycles and even shows an OSD with BT and WLAN
> state images.
> 

You are describing the visible result. Whether it is done as a custom
policy to KEY_WLAN presses or utilizes a separate key definition - is
not known.

Anyway, we got the response form wireless developers and infrastructure
people and thyy do not care about having a new defintion so I guess that
settles it.

-- 
Dmitry
