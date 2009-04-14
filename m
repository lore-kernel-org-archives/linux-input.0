From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Tue, 14 Apr 2009 09:45:13 -0700
Message-ID: <200904140945.14652.dmitry.torokhov@gmail.com>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com> <200904131931.24009.dmitry.torokhov@gmail.com> <49E4B678.9030508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755681AbZDNQqB@vger.kernel.org>
In-Reply-To: <49E4B678.9030508@rtr.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday 14 April 2009 09:14:48 Mark Lord wrote:
> Dmitry Torokhov wrote:
> > Hi Mark,
> >
> > On Wednesday 08 April 2009 10:28:09 Mark Lord wrote:
> >> Dmitry,
> >>
> >> I briefly had access to a Twinhan remote control (for Mythtv et al.)
> >> and cobbled something together quickly to make it work.
> >>
> >> But I really don't understand the new hid/input stuff,
> >> so this is undoubtedly a total abomination to your eyes. :)
> >
> > Actually HID is Juri's baby so let's see what he says ;). From my POV
> > we need to update keymap to make it emit proper codes instead of Myth
> > specific ones, but that is a lesser issue.
>
> ..
>
> That's one thing I haven't figured out:  how to make this compatible
> with the userspace intput-kbd interface for loading new key maps and stuff.
>

You will need to convert your patch into proper hid_driver and
implement drv->input_mapping() method instead of overriding emitted
events. Then, once HID core is aware about proper mapping, normal
EVIOCGKEYCODE/EVIOCSKEYCODE will work and will allow adjusting
keymap from user space.

I think if you take drivers/hid/hid-belkin.c as a template the
conversion will take you no time.

-- 
Dmitry
