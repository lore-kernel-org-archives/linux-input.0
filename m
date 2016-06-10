From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 10 Jun 2016 15:02:20 +0100
Message-ID: <CACxGe6uoOApaHeSOgvNm-2zPFjh7kuOEgCfYdYTZ7xWqpvcu4A@mail.gmail.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
 <1465509287.24319.3.camel@linux.intel.com> <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Darren Hart <darren-P76s1CtE8BHQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 10, 2016 at 10:44 AM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Thu, Jun 9, 2016 at 10:54 PM, Srinivas Pandruvada
> <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> Hi,
>> On Thu, 2016-06-09 at 22:45 +0100, Grant Likely wrote:
>>> On Tue, May 31, 2016 at 5:27 AM, Srinivas Pandruvada
>>> <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>> >
>>> > Starting from Cherrytrail, multiple generation of Intel processors
>>> > offers
>>> > on package sensor hub. Several recent tablets, 2-in-1 convertible
>>> > laptops
>>> > are using ISH instead of external sensor hubs. This resulted in
>>> > lack of
>>> > support of sensor function like device rotation and auto backlight
>>> > adjustment. In addition, depending on the OEM implementation,
>>> > support of ISH
>>> > is required to support low power sleep states.
>>> >
>>> > The support of ISH on Linux platforms is not new. Android platforms
>>> > with
>>> > Intel SoCs had this support for a while submitted by Daniel Drubin.
>>> > This patcheset is reusing most of those changes with  clean up and
>>> > removing Android platform specific changes.
>>> Hi Srinivas,
>>>
>>> Thanks for this patch series. I've got an HP Spectre x360 G2
>>> (skylake), and I've built a 4.6.0 kernel with this driver patched in.
>>> It detects the sensors hub, and creates IIO devices under
>>> /sys/bus/iio/devices:
>>>
>>> $ ls /sys/bus/iio/devices/
>>> iio:device0  iio:device1  iio:device2  iio:device3  iio:device4
>>> iio:device5  iio:device6  iio:device7  iio:device8  iio:device9
>>> trigger0  trigger1  trigger2  trigger3  trigger4  trigger5  trigger6
>>> trigger7  trigger8  trigger9
>>>
>>> However, I haven't figured out how to test it yet. (This is the first
>>> time I'm working with IIO). Do you have any test code or test
>>> procedures to show if it is working?
>>>
>> If you use Fedora 23 (or any distro with iio-sensor-proxy with gnome
>> rotation stuff), you should be able to do screen rotation and
>> brightness using ALS.
>> Each of these folders should have some raw sysfs files
>> in_xxx_raw_xx
>>
>> You should be able to use "cat" on them.
>
> Yes, I do see the in_*_raw_* files in sysfs, and I'm able to get data
> out of them. Gnome also seems to recognize that the accelerometers are
> there because it adds a rotation lock button to the system menu.
>
> However, the events are getting through yet. It may be that I'm
> missing something in my kernel config. I'm rebuilding the kernel with
> Debian's config for the 4.5.5 kernel as a quick sanity test. I'll
> report back when I've tried.

Still no joy here on getting wired up to Gnome. The sensors exist, and
I can view the output. For example, the following shell command will
give a live view of the accelerometer settings:

while true; clear; do { for f in iio\:device*/in_accel*raw; do echo $f
`cat $f`; done }; sleep 0.25s; done

In "Laptop mode":
iio:device1/in_accel_x_raw 2184
iio:device1/in_accel_y_raw -968620
iio:device1/in_accel_z_raw -224273
iio:device3/in_accel_x_raw 5784
iio:device3/in_accel_y_raw -946324
iio:device3/in_accel_z_raw -218647

When rotated clockwise 90 degrees:
iio:device1/in_accel_x_raw 1013843
iio:device1/in_accel_y_raw 8523
iio:device1/in_accel_z_raw -12259
iio:device3/in_accel_x_raw 1012352
iio:device3/in_accel_y_raw 14487
iio:device3/in_accel_z_raw -6891

When lying flat:
iio:device1/in_accel_x_raw 6995
iio:device1/in_accel_y_raw -32824
iio:device1/in_accel_z_raw -986080
iio:device3/in_accel_x_raw 5797
iio:device3/in_accel_y_raw -31402
iio:device3/in_accel_z_raw -984732

However, Gnome isn't picking up the rotation events. I don't know
where in the stack things are falling down. I do have iio-sensor-proxy
running. Any hints on debugging this?

Yet, some stuff is working now. The keyboard (but not the trackpad)
gets disabled when folded back in tablet mode.

g.

>
> I'll also take some time and review the patch series later this afternoon.
>
> g.
>
>>
>> Thanks,
>> Srinivas
>>
>>
>>> Thanks,
>>> g.
>>>
>>> >
>>> >
>>> > This series is tested on:
>>> > - Lenovo Yoga 260 with Skylake processor
>>> > - HP Pavilion x2 detachable with Cherrytrail
>>> >
>>> > The user mode ABI is still same as external sensor hubs using Linux
>>> > IIO. So existing user mode software should still work without
>>> > change.
>>> > This series primarily brings in new HID transport used in ISH.
>>> >
>>> > This series submitted as a RFC to try on several devices. We have
>>> > received request from Linux users who wanted this support. So I
>>> > hope all
>>> > those users try and give feedback.
>>> >
>>> > Daniel Drubin (3):
>>> >   hid: intel_ish-hid: ISH Transport layer
>>> >   hid: intel-ish-hid: ipc layer
>>> >   hid: intel-ish-hid: ISH HID client driver
>>> >
>>> > Srinivas Pandruvada (1):
>>> >   Documentation: hid: Intel ISH HID document
>>> >
>>> >  Documentation/hid/intel-ish-hid.txt          |  375 +++++++++
>>> >  drivers/hid/Kconfig                          |    2 +
>>> >  drivers/hid/Makefile                         |    2 +
>>> >  drivers/hid/intel-ish-hid/Kconfig            |   27 +
>>> >  drivers/hid/intel-ish-hid/Makefile           |   20 +
>>> >  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h  |  220 +++++
>>> >  drivers/hid/intel-ish-hid/ipc/hw-ish.h       |   71 ++
>>> >  drivers/hid/intel-ish-hid/ipc/ipc.c          |  710
>>> > ++++++++++++++++
>>> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c      |  238 ++++++
>>> >  drivers/hid/intel-ish-hid/ipc/utils.h        |   65 ++
>>> >  drivers/hid/intel-ish-hid/ishtp-hid-client.c |  672
>>> > +++++++++++++++
>>> >  drivers/hid/intel-ish-hid/ishtp-hid.c        |  201 +++++
>>> >  drivers/hid/intel-ish-hid/ishtp-hid.h        |  157 ++++
>>> >  drivers/hid/intel-ish-hid/ishtp/bus.c        |  670
>>> > +++++++++++++++
>>> >  drivers/hid/intel-ish-hid/ishtp/bus.h        |   99 +++
>>> >  drivers/hid/intel-ish-hid/ishtp/client.c     | 1131
>>> > ++++++++++++++++++++++++++
>>> >  drivers/hid/intel-ish-hid/ishtp/client.h     |  196 +++++
>>> >  drivers/hid/intel-ish-hid/ishtp/dma-if.c     |  175 ++++
>>> >  drivers/hid/intel-ish-hid/ishtp/hbm.c        |  911
>>> > +++++++++++++++++++++
>>> >  drivers/hid/intel-ish-hid/ishtp/hbm.h        |  319 ++++++++
>>> >  drivers/hid/intel-ish-hid/ishtp/init.c       |   94 +++
>>> >  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  276 +++++++
>>> >  include/trace/events/intel_ish.h             |   30 +
>>> >  23 files changed, 6661 insertions(+)
>>> >  create mode 100644 Documentation/hid/intel-ish-hid.txt
>>> >  create mode 100644 drivers/hid/intel-ish-hid/Kconfig
>>> >  create mode 100644 drivers/hid/intel-ish-hid/Makefile
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
>>> >  create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
>>> >  create mode 100644 include/trace/events/intel_ish.h
>>> >
>>> > --
>>> > 1.9.1
>>> >
