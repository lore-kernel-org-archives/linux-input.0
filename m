From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Mon, 12 Jun 2017 13:40:07 +0200
Message-ID: <20170612134007.2e5e2772@kitsune.suse.cz>
References: <20170528114758.52b619f2@neko>
        <20170528175540.GA8094@dtor-ws>
        <20170607185351.5fcd91df@kitsune.suse.cz>
        <20170607171622.GE13116@dtor-ws>
        <20170607211737.01888f04@kitsune.suse.cz>
        <20170607231303.GB29224@jelly>
        <20170608151842.71b59dad@kitsune.suse.cz>
        <20170608230752.GA4254@jelly>
        <CAKdAkRSho0vBDZ5az+JJ=x7_c1paZb=C6=bVKp4sqNEHB7twvA@mail.gmail.com>
        <20170609133953.1e7221a8@kitsune.suse.cz>
        <20170610020021.GA10528@m72e.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57617 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751718AbdFLLkK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Jun 2017 07:40:10 -0400
In-Reply-To: <20170610020021.GA10528@m72e.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, 10 Jun 2017 12:00:22 +1000
Peter Hutterer <peter.hutterer@who-t.net> wrote:

> On Fri, Jun 09, 2017 at 01:39:53PM +0200, Michal Suchánek wrote:
> > On Thu, 8 Jun 2017 16:18:28 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >   
> > > On Thu, Jun 8, 2017 at 4:07 PM, Peter Hutterer
> > > <peter.hutterer@who-t.net> wrote:  
> > > > On Thu, Jun 08, 2017 at 03:18:42PM +0200, Michal Suchánek
> > > > wrote:    
> > > >> This is what evtest reports about my keyboard:
> > > >>
> > > >> Select the device event number [0-12]: 2
> > > >> Input driver version is 1.0.1
> > > >> Input device ID: bus 0x3 vendor 0x413c product 0x2107 version
> > > >> 0x111 Input device name: "DELL Dell USB Entry Keyboard"
> > > >> Supported events:
> > > >>   Event type 0 (EV_SYN)
> > > >>   Event type 1 (EV_KEY)
> > > >>     Event code 1 (KEY_ESC)
> > > >>     Event code 2 (KEY_1)
> > > >>     Event code 3 (KEY_2)
> > > >>     Event code 4 (KEY_3)
> > > >> ...
> > > >>     Event code 193 (KEY_F23)
> > > >>     Event code 194 (KEY_F24)
> > > >>     Event code 240 (KEY_UNKNOWN)
> > > >>     Event code 272 (BTN_LEFT)
> > > >>     Event code 273 (BTN_RIGHT)
> > > >>     Event code 274 (BTN_MIDDLE)
> > > >>   Event type 4 (EV_MSC)
> > > >>     Event code 4 (MSC_SCAN)
> > > >>   Event type 17 (EV_LED)
> > > >>     Event code 0 (LED_NUML) state 1
> > > >>     Event code 1 (LED_CAPSL) state 0
> > > >>     Event code 2 (LED_SCROLLL) state 0
> > > >>     Event code 3 (LED_COMPOSE) state 0
> > > >>     Event code 4 (LED_KANA) state 0
> > > >> Key repeat handling:
> > > >>   Repeat type 20 (EV_REP)
> > > >>     Repeat code 0 (REP_DELAY)
> > > >>       Value    250
> > > >>     Repeat code 1 (REP_PERIOD)
> > > >>       Value     33
> > > >> Properties:    
> > > >
> > > > looks like it's not tagged as ID_INPUT_MOUSE by the default udev
> > > > rules because for that we need x/y axes (either relative for
> > > > real mice or absolute ones for the VMWare USB mouse). This
> > > > keyboard only has buttons though. So it gets ID_INPUT_KEYBOARD
> > > > for the keys, but no ID_INPUT_MOUSE.
> > > >
> > > > Google isn't overly forthcoming on "DELL Dell USB Entry
> > > > Keyboard" but the few pictures I can find all point to a
> > > > keyboard that doesn't have any physical mouse buttons at all.
> > > > Does yours have buttons? Can you post a picture of it somewhere?
> > > >    
> > > 
> > > Michal is using udev/hwdb to replace some of the keys on his
> > > keyboard to generate BTN_RIGHT/BTN_MIDDLE trying to achive the
> > > same end result as with mac_hid. It is not the default keyboard
> > > behavior. Having another custom udev rule to mark the device as
> > > ID_INPUT_MOUSE is a fair requirement in this case I think.
> > >   
> > 
> > Which is done in different place, and uses device matching with
> > completely different patterns. So for this to work reasonably either
> > 
> >  - all devices should have all capabilities by default
> >  - the capabilities should be detected based on the events actually
> >    available on the device
> > 
> > And if my keyboard actually claimed to have relative axis because of
> > some great firmware engineering on the manufacturer's part and I
> > found how to remove them in hwdb it would not take effect either.  
> 
> https://github.com/systemd/systemd/blob/master/rules/50-udev-default.rules.in
> calls input-id which sets the ID_INPUT_* tags. If you modify the
> capabilities after that happens, you need to call input-id again to
> get updated udev properties.

rules/50-udev-default.rules.in:SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", IMPORT{builtin}="usb_id", IMPORT{builtin}="hwdb --subsystem=usb"
rules/50-udev-default.rules.in:SUBSYSTEM=="input", ENV{ID_INPUT}=="", IMPORT{builtin}="input_id"
rules/50-udev-default.rules.in:ENV{MODALIAS}!="", IMPORT{builtin}="hwdb --subsystem=$env{SUBSYSTEM}"
rules/60-evdev.rules:IMPORT{builtin}="hwdb --subsystem=input --lookup-prefix=evdev:", \
rules/60-evdev.rules:ENV{ID_INPUT_KEY}=="?*", DRIVERS=="atkbd", \
rules/60-evdev.rules:  IMPORT{builtin}="hwdb 'evdev:atkbd:$attr{[dmi/id]modalias}'", \
rules/60-evdev.rules:KERNELS=="input*", IMPORT{builtin}="hwdb 'evdev:name:$attr{name}:phys:$attr{phys}:ev:$attr{capabilities/ev}:$attr{[dmi/id]modalias}'", \
rules/60-evdev.rules:KERNELS=="input*", IMPORT{builtin}="hwdb 'evdev:name:$attr{name}:$attr{[dmi/id]modalias}'", \
rules/60-persistent-input.rules:ENV{ID_INPUT_KEYBOARD}=="?*", ENV{.INPUT_CLASS}="kbd"
rules/60-persistent-input.rules:ENV{ID_INPUT_MOUSE}=="?*", ENV{.INPUT_CLASS}="mouse"
rules/60-persistent-input.rules:ENV{ID_INPUT_TOUCHPAD}=="?*", ENV{.INPUT_CLASS}="mouse"
rules/60-persistent-input.rules:ENV{ID_INPUT_TABLET}=="?*", ENV{.INPUT_CLASS}="mouse"
rules/60-persistent-input.rules:ENV{ID_INPUT_JOYSTICK}=="?*", ENV{.INPUT_CLASS}="joystick"
rules/60-sensor.rules:  IMPORT{builtin}="hwdb 'sensor:modalias:$attr{modalias}:$attr{[dmi/id]modalias}'", \
rules/60-sensor.rules:SUBSYSTEM=="input", ENV{ID_INPUT_ACCELEROMETER}=="1", SUBSYSTEMS=="acpi", \
rules/60-sensor.rules:  IMPORT{builtin}="hwdb 'sensor:modalias:acpi:$attr{hid}:$attr{[dmi/id]modalias}'", \
rules/60-sensor.rules:SUBSYSTEM=="input", ENV{ID_INPUT_ACCELEROMETER}=="1", SUBSYSTEMS=="platform", \
rules/60-sensor.rules:  IMPORT{builtin}="hwdb 'sensor:modalias:platform:$id:$attr{[dmi/id]modalias}'", \
rules/70-mouse.rules:ENV{ID_INPUT_MOUSE}=="", GOTO="mouse_end"
rules/70-mouse.rules:        IMPORT{builtin}="hwdb 'mouse:$env{ID_BUS}:v$attr{id/vendor}p$attr{id/product}:name:$attr{name}:'", \
rules/70-mouse.rules:        IMPORT{builtin}="hwdb 'mouse:$env{ID_BUS}:v$attr{id/vendor}p$attr{id/product}:name:$attr{name}:'", \
rules/70-mouse.rules:        IMPORT{builtin}="hwdb 'mouse:ps2::name:$attr{device/name}:'", \
rules/70-touchpad.rules:ENV{ID_INPUT}=="", GOTO="touchpad_end"
rules/70-touchpad.rules:ENV{ID_INPUT_TOUCHPAD}=="", GOTO="touchpad_end"
rules/70-touchpad.rules:        IMPORT{builtin}="hwdb 'touchpad:$env{ID_BUS}:v$attr{id/vendor}p$attr{id/product}:name:$attr{name}:'", \

Looking at the occurences of hwdb and ID_INPUT moving the call to
input_id from rules/50-udev-default.rules to a
separate file 60-input-id.rules would make it possible to put fixups in
60-evdev.rules hwdb calls and the 60-persistent-input.rules that depend
on the settings would come after as well as the mouse and
touchpad-specific rules.

> 
> There is no kernel facility to handle devices that change
> capabilities at runtime. We discussed this a short while ago (search
> for SYN_CONFIG) but it's ... tricky.

I do not really want to change capabilities at any random moment. I
want the capabilities set up at add time. Presumably re-triggering the
device with udevadm will make it possible to update the capabilities
for devices that are built-in or impractical to remove.

Thanks

Michal
