From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up
 system after s2idle
Date: Fri, 17 Aug 2018 10:04:19 +0200
Message-ID: <CAJZ5v0jWZYJ9V8xJ9vy+VDC2ysbwU=hRZC6G3VJSGDsWaj_xpw@mail.gmail.com>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
 <73029405.6ZXyByzer1@aspire.rjw.lan> <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
 <1631276.bMiRmflJ7r@aspire.rjw.lan> <CAD8Lp45F1aDB64_oPg8jqiG3HmM=efQoDGdioX4f365NXoummQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp45F1aDB64_oPg8jqiG3HmM=efQoDGdioX4f365NXoummQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chris Chiu <chiu@endlessm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 17, 2018 at 4:29 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Aug 6, 2018 at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> 'echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup' can get the
> >> keyboard wake up the system as expected. We considered to work out a DMI
> >> based quirk for this. But based on the information that EC would not signal SCI
> >> event for WiskyLake models, we'd like to know if there's any generic solution?
> >> Maybe a 'udev' rule to identify WiskyLake NoteBook then enable the keyboard
> >> wake up?
> >
> > A udev rule sounds like a good idea to me.
>
> What would the udev rule look like though?
>
> Match for Intel CPU generation (WhiskyLake) and laptop chassis type
> and then enable i8042 wakeups? While that seems like the most accurate
> reflection of the situation which we are seeing across multiple
> vendors, it doesn't feel right and seems unlikely to be accepted by
> systemd upstream.
>
> In previous designs, pressing a key while the system was in S3 sleep
> would cause a SCI interrupt due to the firing of the EC GPE, which
> effectively meant that keyboard wakeups were on by default and could
> not be disabled. Also USB keyboards have wakeups on by default (see
> usbhid_start()). Just these new platforms have this
> unfortunate/accidental behaviour change...
>
> Would it make sense to turn i8042 wakeups on by default on the kernel
> side? I don't know if any particular conditions are applied, but that
> would appear to be the default Win10 behaviour here.

Yes, it would, but that might prevent some systems from suspending at
all in theory if there are keyboard interrupts on them occurring
during system-wide suspend, for example.

Otherwise, it would just be a matter of calling device_wakeup_enable()
at init time for the keyboard port (as long as you know which one of
them is the keyboard).
