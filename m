From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Fri, 9 Dec 2016 15:36:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org> <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com> <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com> <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com> <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Thu, 8 Dec 2016, Rob Herring wrote:

> > And if tomorrow there is Elan device that is drop-in compatible (same 
> > connector, etc) with Wacom i2c-hid, will you ask for Elan-specific 
> > binding? Atmel? Weida? They all need to be powered up ultimately.
> 
> Yes, I will. 

What advantage does that bring?

> That in no way means the OS driver has to know about each and every one. 
> If they can all claim compatibility with Wacom (including power 
> control), then they can have a Wacom compatible string too. Or you can 
> just never tell me that there's a different manufacturer and I won't 
> care as long you don't need different control. But soon as a device 
> needs another power rail, GPIO or different timing, then you'd better 
> have a new compatible string.

Again, I simply don't understand what advantage does the aproach you are 
trying to use bring.

HID over I2C is a generic protocol. Sure, we need to have quirks for 
device-specific bugs, and in such cases enumerate particular devices. But 
we don't need DT for that at all.

-- 
Jiri Kosina
SUSE Labs
