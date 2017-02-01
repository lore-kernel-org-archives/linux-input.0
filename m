From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: add Asus macrokey support for Asus "Republic of
 Gamers" laptop
Date: Wed, 1 Feb 2017 09:18:52 +0100
Message-ID: <20170201081852.GA31658@mail.corp.redhat.com>
References: <1481546578-40703-1-git-send-email-chiu@endlessm.com>
 <20161213081632.GC13907@mail.corp.redhat.com>
 <CAD8Lp46eSzFTEF2VbOHESBHRPOQ0UWO34-DNQYkkwWNKT9kf9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD8Lp46eSzFTEF2VbOHESBHRPOQ0UWO34-DNQYkkwWNKT9kf9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>, Jiri Kosina <jikos@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Jan 31 2017 or thereabouts, Daniel Drake wrote:
> Hi Benjamin,
> 
> On Tue, Dec 13, 2016 at 2:16 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > On Dec 12 2016 or thereabouts, Chris Chiu wrote:
> >> ROG means ASUS "Republic of Gamers" laptops. The input device info
> >> also represents itself as "ASASTeK COMPUTER INC. ROG MacroKey". It
> >> uses special HID_USAGE code for function keys. This commit remap the
> >> special code to standard keycode for function keys handling. It's
> >> verified on GL553VD/VE, GL753VD/VE.
> >>
> >> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> >> Reported-by: Yukai Li <yukaili@gmail.com>
> >> ---
> >
> > Hi Chris,
> >
> > there is no real point of having a separate driver from hid-asus. The
> > HID tree prefer to group drivers by vendors, so these keyboards should
> > be supported through hid-asus.
> 
> Thanks for the feedback. We will submit a new version soon.
> 
> Just to confirm, hid-asus currently depends on I2C_HID. The new
> devices being quirked now are USB devices. With this patch should we
> now update it to depend on I2C_HID && USB_HID?
> 

Actually you can remove the I2C_HID dependency entirely (and not add one
for USB_HID). In the Kconfig, the modules are already guarded by a
"if HID", and there is nothing transport specific in hid-asus as far as
I can tell.

Note: we should also probably clean up the Kconfig once again and remove
all the "depends on HID" for those that are guarded by the if statement.

Cheers,
Benjamin
