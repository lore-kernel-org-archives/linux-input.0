From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad
 button mapping for the Caroline Chromebook.
Date: Thu, 26 Apr 2018 09:42:18 -0700
Message-ID: <20180426164218.GA162443@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws>
 <20180425225734.GD200812@dtor-ws>
 <ff623f6afb4e7910f3bb6d211f0f187f@vittgam.net>
 <CABXOdTeh3yLtsWxUCWFdpQNQReAmVDnuJh+T07X=YB3dq=uG1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABXOdTeh3yLtsWxUCWFdpQNQReAmVDnuJh+T07X=YB3dq=uG1Q@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, "# v4 . 10+" <stable@vger.kernel.org>, nick@shmanahar.org, Benson Leung <bleung@chromium.org>, Salvatore Bellizzi <lkml@seppia.net>, Guenter Roeck <groeck@chromium.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 26, 2018 at 06:45:32AM -0700, Guenter Roeck wrote:
> On Wed, Apr 25, 2018 at 10:37 PM, Vittorio Gambaletta (VittGam) <
> linuxbugs@vittgam.net> wrote:
> 
> > Hello,
> >
> > On 26/04/2018 00:57:34 CEST, Dmitry Torokhov wrote:
> > > On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
> > >> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam)
> > wrote:
> > >> > This patch adds the correct platform data information for the Caroline
> > >> > Chromebook, so that the mouse button does not get stuck in pressed
> > state
> > >> > after the first click.
> > >> >
> > >> > The Samus button keymap and platform data definition are the correct
> > >> > ones for Caroline, so they have been reused here.
> > >> >
> > >> > v2: updated patch offset after 20180409 changes.
> > >> >
> > >> > Cc: stable@vger.kernel.org
> > >> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> > >> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> > >> >
> > >>
> > >> Applied, thank you.
> > >>
> > >> > ---
> > >> >
> > >> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > >> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > >> > @@ -3035,6 +3035,15 @@
> > >> >            .driver_data = samus_platform_data,
> > >> >    },
> > >> >    {
> > >> > +          /* Samsung Chromebook Pro */
> > >> > +          .ident = "Samsung Chromebook Pro",
> > >> > +          .matches = {
> > >> > +                  DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> > >
> > > I've been alerted that shipping BIOS has vendor not capitalized; where
> > > did you get the firmware that has vendor all capitals?
> >
> > Upstream coreboot and mrchromebox's coreboot, which do support loading
> > Linux
> > natively or with UEFI, both use capitalized GOOGLE as DMI System Vendor
> > as far as I know.
> >
> > By the way, the shipping BIOS (coreboot customized by Google) does not
> > support
> > mainline Linux natively (eg. without seabios and nasty tricks), but only
> > Chromium OS, which for Caroline is an old 3.something fork of Linux, so
> > this
> > patch does not really apply to Chromium OS or to Linux running on shipping
> > BIOS.
> >
> > Can you provide details or a pointer to it ? The mainline kernel boots
> fine for me (with a ChromeOS distribution), with the exception of the
> Google/GOOGLE problem.
> 
> 
> > Anyway if I recall correctly, the DMI System Vendor should be GOOGLE in
> > Google's coreboot for Caroline too, but I'm not 100% sure and cannot check
> > right now.
> >
> >
> FWIW, the DMI system vendor is "Google"  in my Caroline. I'll dig up
> configuration files later today - maybe it was changed to "GOOGLE" at some
> point and I have an old Bios in my system.

I believe all shipping BIOSes use "Google" as vendor, as it is what is
specified in src/mainboard/google/Kconfig::MAINBOARD_VENDOR and our
configs/build scripts do not override it.

I do not know why we have this difference.

> 
> Thanks,
> Guenter
> 
> By the way please note that this is the DMI System Vendor and not the DMI
> > BIOS version string, which indeed starts with "Google_" in the shipping
> > BIOS
> > (but not in coreboot, see f56db262e46d3368ee4e5c9e19797853cab382cd).

Hmm, I just tried checking out tree from
https://review.coreboot.org/coreboot.git and do not see this commit:

dtor@dtor-ws:~/coreboot $ git show f56db262e46d3368ee4e5c9e19797853cab382cd
fatal: bad object f56db262e46d3368ee4e5c9e19797853cab382cd
dtor@dtor-ws:~/coreboot $ git log --oneline -1 HEAD
82d0f91420 (HEAD -> master, origin/master, origin/HEAD) soc/intel/apollolake: enable exception handling in every stage for glk      

Anyway, if you are overriding the shipping BIOS, then please adjust
coreboot to use device-tree compatible bindings (via PRP0001 HID and
_DSD properties - you can check out bindings for PENH device in Caroline
to see how they can be used). This way we would not need to breed DMI
quirks.

Thanks.

-- 
Dmitry
