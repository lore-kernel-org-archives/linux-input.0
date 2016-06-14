From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Tue, 14 Jun 2016 17:08:38 +0100
Message-ID: <CACxGe6siZMA3GX=M8=07GbHsnzRzq0=dKQ8aeC_VN=9iPcc=Ew@mail.gmail.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
 <1465509287.24319.3.camel@linux.intel.com> <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
 <1465566904.10525.11.camel@linux.intel.com> <1465568791.7409.38.camel@hadess.net>
 <1465569941.10525.17.camel@linux.intel.com> <1465571076.7409.39.camel@hadess.net>
 <1465572227.24319.7.camel@linux.intel.com> <1465572452.7409.41.camel@hadess.net>
 <CACxGe6sjFHS9VaeWUY1PsJXhTW1Nvkuoqutty9oSX2Ywj+yV9g@mail.gmail.com> <1465917123.606.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35092 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbcFNQJA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 12:09:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so23499831wme.2
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2016 09:08:59 -0700 (PDT)
In-Reply-To: <1465917123.606.11.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>

On Tue, Jun 14, 2016 at 4:12 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2016-06-14 at 14:44 +0100, Grant Likely wrote:
>> On Fri, Jun 10, 2016 at 4:27 PM, Bastien Nocera <hadess@hadess.net>
>> wrote:
>> > On Fri, 2016-06-10 at 08:23 -0700, Srinivas Pandruvada wrote:
>> > > On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
>> > > > >
>> > >
>> > > [...]
>> > >
>> > > > Are there any errors when setting the triggers?
>> > > >
>> > > Is there any debug option in this service to give more verbose
>> > > output?
>> >
>> > Add:
>> > Environment="G_MESSAGES_DEBUG=all"
>> >
>> > To the service file. You should see the debug in systemctl:
>> > systemctl status iio-sensor-proxy.service
>> >
>> > Or in journalctl if there's too much data:
>> > journalctl --reverse -u iio-sensor-proxy.service
>>
>> Still no joy on the sensors. The proxy starts up and detects the
>> sensors, but I don't see any sensor events occurring:
>
> Could you try again with the current master of iio-sensor-proxy? Make
> sure to install the file in the same location as in your distro
> provided package.
>
> I've added more debug/warnings to a few cases where it would have
> silently failed in the past.
>
> In particular, I don't see any messages that would be coming out of:
> https://github.com/hadess/iio-sensor-proxy/blob/master/src/iio-buffer-utils.c#L512
>
> Could it be that the sub-directory is populated after the device is
> created in the kernel, causing a race?
>
> Either that, or the contents of the scan_elements/ directory is not the
> one expected by this code.
>
> The output of this command should us that:
> ls /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1/scan_elements

Hmmm, this is interesting. I fetched, built and ran the latest
iio-sensor-proxy. It quit with the following error. However,
immediately afterwards, I ran the Debian packaged version (1.1-1), and
the sensors started to work. Something in the latest master activates
the sensors enough for the older version to work.

To make sure it wasn't fixed by a kernel upgrade, I also rebooted and
tried again:
1) Booted system - iio-sensor-proxy.service running  --- No rotation sensing
2) # systemctl stop iio-sensor-proxy-service   --- Turn off the agent
3) # G_MESSAGES_DEBUG=all /usr/bin/iio-sensor-proxy.orig     ----
original version, still not working
4) # G_MESSAGES_DEBUG=all /usr/bin/iio-sensor-proxy.new     ----
latest master, failed with error messages
5) # G_MESSAGES_DEBUG=all /usr/bin/iio-sensor-proxy.orig     ----
original version, suddenly working

All of this was tested on Linus' latest master branch (4.7-rc3+)

Output from latest git master:

root@gladys:~# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy
** (process:9214): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
** (process:9214): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:9214): DEBUG: Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
** (process:9214): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
** (process:9214): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1

** (process:9214): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1'

** (process:9214): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1'
** (process:9214): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6

** (process:9214): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6'

** (process:9214): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6'




Full output running old, then new, then old:

Script started on Tue 14 Jun 2016 16:47:16 BST
root@gladys:/usr/sbin# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy.orig
** (process:2369): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
** (process:2369): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:2369): DEBUG: Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
** (process:2369): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
** (process:2369): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1
** (process:2369): DEBUG: Got type for in_accel_x: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Got type for in_accel_y: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Got type for in_accel_z: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for in_accel_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for in_accel_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for in_accel_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6
** (process:2369): DEBUG: Got type for in_magn_x: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Got type for in_magn_y: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Got type for in_magn_z: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Got type for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for in_magn_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for in_magn_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for in_magn_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Built channel array for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2369): DEBUG: Handling driver refcounting method
'ClaimLight' for ambient light sensor device
** (process:2369): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:2369): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:2369): DEBUG: No new data available
** (process:2369): DEBUG: No new data available
** (process:2369): DEBUG: No new data available
^C



root@gladys:/usr/sbin# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy.new
** (process:2468): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
** (process:2468): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:2468): DEBUG: Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
** (process:2468): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
** (process:2468): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1

** (process:2468): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1'

** (process:2468): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1'
** (process:2468): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6

** (process:2468): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6'

** (process:2468): WARNING **: Failed to enable any sensors for device
'/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6'



root@gladys:/usr/sbin# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy.orig
** (process:2533): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
** (process:2533): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:2533): DEBUG: Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
** (process:2533): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
** (process:2533): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1
** (process:2533): DEBUG: Got type for in_accel_x: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Got type for in_accel_y: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Got type for in_accel_z: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for in_accel_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for in_accel_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for in_accel_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6
** (process:2533): DEBUG: Got type for in_magn_x: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Got type for in_magn_y: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Got type for in_magn_z: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Got type for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for in_magn_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for in_magn_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for in_magn_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Built channel array for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2533): DEBUG: Handling driver refcounting method
'ClaimLight' for ambient light sensor device
** (process:2533): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:2533): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:2533): DEBUG: Read from IIO: 4449, -1007689, 15468
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 0, 9, 0
** (process:2533): DEBUG: Emitted orientation changed: from undefined to normal
** (process:2533): DEBUG: Read from IIO: 3729, -1007724, 12494
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 0, 9, 0
** (process:2533): DEBUG: Read from IIO: -12800, -1056421, -2211
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 0, 9, 0
** (process:2533): DEBUG: Read from IIO: -642273, -671193, -106330
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 5, 6, 0
** (process:2533): DEBUG: Emitted orientation changed: from normal to right-up
** (process:2533): DEBUG: Read from IIO: -968979, -66939, 45709
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 8, 0, 0
** (process:2533): DEBUG: Read from IIO: -973822, -54006, 38730
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 8, 0, 0
** (process:2533): DEBUG: Read from IIO: -436204, -868488, -94847
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 3, 7, 0
** (process:2533): DEBUG: Emitted orientation changed: from right-up to normal
** (process:2533): DEBUG: Read from IIO: -32008, -988339, -7532
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 0, 8, 0
** (process:2533): DEBUG: Read from IIO: 22296, -1010201, 9358
** (process:2533): DEBUG: Accel sent by driver (quirk applied): 0, 9, 0
^C
root@gladys:/usr/sbin# exit

Script done on Tue 14 Jun 2016 16:47:49 BST
