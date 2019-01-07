From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Elantech Touchpad: Fix Elantech touchpad and trackpoint
 for Lenovo ThinkPad notebooks.
Date: Mon, 7 Jan 2019 09:05:07 +0100
Message-ID: <CAO-hwJLW2rqz+SOPULTY=a51AeACNYNnePcUvuA0WGidvn8Nqg@mail.gmail.com>
References: <20181228175327.14863-1-kaelinphilipp@gmail.com> <F09EA46C-73C3-48A8-9105-F4DE55D7FBB6@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <F09EA46C-73C3-48A8-9105-F4DE55D7FBB6@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Philipp Kaelin <kaelinphilipp@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Kai-Heng,

On Sun, Jan 6, 2019 at 10:44 AM Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Benjamin,
>
> > On Dec 29, 2018, at 1:53 AM, Philipp Kaelin <kaelinphilipp@gmail.com> wrote:
> >
> > Initial situation:
> > - The touchpad of a Lenovo ThinkPad L580 doesn't work with newer kernel versions eg. 4.20
> > - It used to work on earlier versions eg. 4.14
> >
> > Cause:
> > - The elantech driver was adapted in to support SMBus wich not all firmware versions
> >  of the elantech firmware support. The SMBus is used as default.
> >
> > Solution:
> > - Previously a blacklist was introduced for devices which doesn't support the access using SMBus.
> >  The ThinkPad P52 and P72 have already been fixed by adding it to such a blacklist in a prevois patch.
> >  The exact same solution fixed also the issue on the mentioned ThinkPad L580.
> >
> > Change:
> > 1) The firmware id of the ThinkPad L580 was added to this blacklist.
> > 2) To not have a half baked solution the information which firmware versions are using the same driver
> >   and therefore most probably have all the same issue was extracted from the Lenovo Windows driver package.
> >   All these firmware versions are now also added to the blacklist.
>
> I actually have a reversed situation:
> I’d like to make Elantech touchpad defaults to SMBus on some platforms, but the firmware version does not match to ETP_NEW_IC_SMBUS_HOST_NOTIFY().
>
> Use whitelist is obviously a bad idea so I’d like to know do you have any better approach in mind?

TL;DR: I think there is no other solution than using a whitelist.

Well, that's not entirely true. There is a bit in the old touchpads
that says if it can be used by an other bus (I2C, SMBus or something
else). But the problem is that those touchpads have been around for a
quite a long time, and blindly switching them to SMBus would likely
introduce regressions on old hardware we don't want to support
anymore.

I chose to only enable the new ones because I thought it would prevent
me for having to deal with many issues, and you can see the result. At
least, all of those machines are from the latest generation (or
previous generation) so it doesn't seem to be a bad idea to try to fix
them.

So I'd say for the old touchpads that do not have
ETP_NEW_IC_SMBUS_HOST_NOTIFY(), we should likely stick with a well
defined whitelist so we can control the damages.

Cheers,
Benjamin
