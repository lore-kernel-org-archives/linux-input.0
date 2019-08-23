From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
Date: Fri, 23 Aug 2019 17:32:24 +0200
Message-ID: <CAO-hwJLQT6Oj2mvDTtQsOHLOTLFeB=_e6ZQZVj2tz92CZUU17A@mail.gmail.com>
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
 <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
 <e6014a01-1094-9ec7-9b37-2abdf70e305f@pedrovanzella.com> <CAO-hwJ+=dAyFnUfiPSmiGpzYTj=9BPDdeKQOY7UoCOvwQ5CH7Q@mail.gmail.com>
 <3c37ccc992d7979358e8472fbf52a583c6e1068f.camel@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c37ccc992d7979358e8472fbf52a583c6e1068f.camel@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Bastien Nocera <hadess@hadess.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 23, 2019 at 4:48 PM Filipe Laíns <lains@archlinux.org> wrote:
>
> On Fri, 2019-08-23 at 16:32 +0200, Benjamin Tissoires wrote:
> > The problem I have with quirks, and that I explained to Filipe on IRC
> > is that this is kernel ABI. Even if there is a very low chance we have
> > someone using this, re-using the same drv_data bit in the future might
> > break someone's device.
>
> But we can reserve those bits. I don't expect there to be a ton of
> devices that need to be quirked, so using the remaining bits should be
> perfectly fine. Do you agree?

Nope. If the code is not ready for upstream, it should not be included.

Cheers,
Benjamin
