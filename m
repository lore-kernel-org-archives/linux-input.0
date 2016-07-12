From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 22/27] HID: wacom: EKR: attach the power_supply on first
 connection
Date: Tue, 12 Jul 2016 11:29:01 +0200
Message-ID: <20160712092901.GH4663@mail.corp.redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
 <1467729563-23318-23-git-send-email-benjamin.tissoires@redhat.com>
 <CAEoswT0inHAzo4pP8sBaXpMR_iqUG_U=kdGagAu_m8DybMMDzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56891 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbcGLJ3H (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 05:29:07 -0400
Content-Disposition: inline
In-Reply-To: <CAEoswT0inHAzo4pP8sBaXpMR_iqUG_U=kdGagAu_m8DybMMDzA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Jul 08 2016 or thereabouts, Aaron Armstrong Skomra wrote:
> On Tue, Jul 5, 2016 at 7:39 AM, Benjamin Tissoires <
> benjamin.tissoires@redhat.com> wrote:
> 
> > Or Gnome complains about an empty battery.
> >
> > Hi Benjamin,
> 
> I tested this series on the 24HD, 21UX2, Intuos P&T (CTH-680), and with 2
> EKRs.

I somehow missed this email. Sorry for the late answer.

> 
> When I attach (by USB wire) a wireless capable tablet with the rechargeable
> battery and wireless module connected inside the tablet, I get the same
> momentary 0% battery notification from gnome (see attached upower output).

Yes, I saw that, but I think it's not a regression. It's the way it's
already working now (from what I can see), and so it would be nice to
be fixed, but I didn't in this series.

> 
> Aside from that
> 
> Tested-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Thanks!

But given Peter's comments regarding grouping, I think I'll need you to
redo the tests on the 24HD and 21UX2 with the next series as the initial
kernel implementation of LEDs needs to be reverted, or libwacom will
fail :(

Cheers,
Benjamin

> 
> Best,
> Aaron
> 
> 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/hid/wacom_sys.c | 36 ++++++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 04f5c75..1d79215 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -1917,6 +1917,10 @@ static void wacom_remote_destroy_one(struct wacom
> > *wacom, unsigned int index)
> >         remote->remotes[index].registered = false;
> >         spin_unlock_irqrestore(&remote->remote_lock, flags);
> >
> > +       if (remote->remotes[index].battery.battery)
> > +               devres_release_group(&wacom->hdev->dev,
> > +
> > &remote->remotes[index].battery.bat_desc);
> > +
> >         if (remote->remotes[index].group.name)
> >                 devres_release_group(&wacom->hdev->dev,
> >                                      &remote->remotes[index]);
> > @@ -1926,6 +1930,7 @@ static void wacom_remote_destroy_one(struct wacom
> > *wacom, unsigned int index)
> >                         remote->remotes[i].serial = 0;
> >                         remote->remotes[i].group.name = NULL;
> >                         remote->remotes[i].registered = false;
> > +                       remote->remotes[i].battery.battery = NULL;
> >                         wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
> >                 }
> >         }
> > @@ -1982,11 +1987,6 @@ static int wacom_remote_create_one(struct wacom
> > *wacom, u32 serial,
> >         if (error)
> >                 goto fail;
> >
> > -       error = __wacom_initialize_battery(wacom,
> > -
> > &remote->remotes[index].battery);
> > -       if (error)
> > -               goto fail;
> > -
> >         remote->remotes[index].registered = true;
> >
> >         devres_close_group(dev, &remote->remotes[index]);
> > @@ -1998,6 +1998,28 @@ fail:
> >         return error;
> >  }
> >
> > +static int wacom_remote_attach_battery(struct wacom *wacom, int index)
> > +{
> > +       struct wacom_remote *remote = wacom->remote;
> > +       int error;
> > +
> > +       if (!remote->remotes[index].registered)
> > +               return 0;
> > +
> > +       if (remote->remotes[index].battery.battery)
> > +               return 0;
> > +
> > +       if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
> > +               return 0;
> > +
> > +       error = __wacom_initialize_battery(wacom,
> > +
> >  &wacom->remote->remotes[index].battery);
> > +       if (error)
> > +               return error;
> > +
> > +       return 0;
> > +}
> > +
> >  static void wacom_remote_work(struct work_struct *work)
> >  {
> >         struct wacom *wacom = container_of(work, struct wacom,
> > remote_work);
> > @@ -2028,8 +2050,10 @@ static void wacom_remote_work(struct work_struct
> > *work)
> >                 serial = data.remote[i].serial;
> >                 if (data.remote[i].connected) {
> >
> > -                       if (remote->remotes[i].serial == serial)
> > +                       if (remote->remotes[i].serial == serial) {
> > +                               wacom_remote_attach_battery(wacom, i);
> >                                 continue;
> > +                       }
> >
> >                         if (remote->remotes[i].serial)
> >                                 wacom_remote_destroy_one(wacom, i);
> > --
> > 2.5.5
> >
> >

> [wacom@localhost ~]$ upower -d
> Device: /org/freedesktop/UPower/devices/mouse_wacom_battery_7
>   native-path:          wacom_battery_7
>   power supply:         no
>   updated:              Thu 07 Jul 2016 01:55:12 PM PDT (1 seconds ago)
>   has history:          yes
>   has statistics:       yes
>   mouse
>     present:             yes
>     rechargeable:        yes
>     state:               discharging
>     warning-level:       critical
>     percentage:          0%
>     icon-name:          'battery-caution-symbolic'
>   History (charge):
>     1467924912	0.000	unknown
>     1467924886	96.000	charging
>     1467924880	0.000	unknown
>   History (rate):
>     1467924912	0.000	unknown
>     1467924880	0.000	unknown
> 
> Device: /org/freedesktop/UPower/devices/DisplayDevice
>   power supply:         no
>   updated:              Thu 07 Jul 2016 12:09:09 PM PDT (6364 seconds ago)
>   has history:          no
>   has statistics:       no
>   unknown
>     warning-level:       none
>     icon-name:          ''
> 
> Daemon:
>   daemon-version:  0.99.4
>   on-battery:      no
>   lid-is-closed:   no
>   lid-is-present:  no
>   critical-action: PowerOff
> [wacom@localhost ~]$ upower -d
> Device: /org/freedesktop/UPower/devices/mouse_wacom_battery_7
>   native-path:          wacom_battery_7
>   power supply:         no
>   updated:              Thu 07 Jul 2016 01:55:18 PM PDT (3 seconds ago)
>   has history:          yes
>   has statistics:       yes
>   mouse
>     present:             yes
>     rechargeable:        yes
>     state:               charging
>     warning-level:       none
>     percentage:          96%
>     icon-name:          'battery-full-charging-symbolic'
>   History (charge):
>     1467924918	96.000	charging
>     1467924912	0.000	unknown
>     1467924886	96.000	charging
>     1467924880	0.000	unknown
>   History (rate):
>     1467924912	0.000	unknown
>     1467924880	0.000	unknown
> 
> Device: /org/freedesktop/UPower/devices/DisplayDevice
>   power supply:         no
>   updated:              Thu 07 Jul 2016 12:09:09 PM PDT (6372 seconds ago)
>   has history:          no
>   has statistics:       no
>   unknown
>     warning-level:       none
>     icon-name:          ''
> 
> Daemon:
>   daemon-version:  0.99.4
>   on-battery:      no
>   lid-is-closed:   no
>   lid-is-present:  no
>   critical-action: PowerOff
> 

