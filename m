From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Tue, 14 Jun 2016 22:33:46 +0100
Message-ID: <CACxGe6sE0oWRXd+vAERQQvQoW52+cfEJ19T_KzLN9bbpTWLnbg@mail.gmail.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
 <1465509287.24319.3.camel@linux.intel.com> <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
 <1465566904.10525.11.camel@linux.intel.com> <1465568791.7409.38.camel@hadess.net>
 <1465569941.10525.17.camel@linux.intel.com> <1465571076.7409.39.camel@hadess.net>
 <1465572227.24319.7.camel@linux.intel.com> <1465572452.7409.41.camel@hadess.net>
 <CACxGe6sjFHS9VaeWUY1PsJXhTW1Nvkuoqutty9oSX2Ywj+yV9g@mail.gmail.com>
 <1465917123.606.11.camel@hadess.net> <CACxGe6siZMA3GX=M8=07GbHsnzRzq0=dKQ8aeC_VN=9iPcc=Ew@mail.gmail.com>
 <1465923665.606.19.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465923665.606.19.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 14, 2016 at 6:01 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2016-06-14 at 17:08 +0100, Grant Likely wrote:
>> On Tue, Jun 14, 2016 at 4:12 PM, Bastien Nocera <hadess@hadess.net>
>> wrote:
>> > On Tue, 2016-06-14 at 14:44 +0100, Grant Likely wrote:
>> > > On Fri, Jun 10, 2016 at 4:27 PM, Bastien Nocera <hadess@hadess.ne
>> > > t>
>> > > wrote:
>> > > > On Fri, 2016-06-10 at 08:23 -0700, Srinivas Pandruvada wrote:
>> > > > > On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
>> > > > > > >
>> > > > >
>> > > > > [...]
>> > > > >
>> > > > > > Are there any errors when setting the triggers?
>> > > > > >
>> > > > > Is there any debug option in this service to give more
>> > > > > verbose
>> > > > > output?
>> > > >
>> > > > Add:
>> > > > Environment="G_MESSAGES_DEBUG=all"
>> > > >
>> > > > To the service file. You should see the debug in systemctl:
>> > > > systemctl status iio-sensor-proxy.service
>> > > >
>> > > > Or in journalctl if there's too much data:
>> > > > journalctl --reverse -u iio-sensor-proxy.service
>> > >
>> > > Still no joy on the sensors. The proxy starts up and detects the
>> > > sensors, but I don't see any sensor events occurring:
>> >
>> > Could you try again with the current master of iio-sensor-proxy?
>> > Make
>> > sure to install the file in the same location as in your distro
>> > provided package.
>> >
>> > I've added more debug/warnings to a few cases where it would have
>> > silently failed in the past.
>> >
>> > In particular, I don't see any messages that would be coming out
>> > of:
>> > https://github.com/hadess/iio-sensor-proxy/blob/master/src/iio-buff
>> > er-utils.c#L512
>> >
>> > Could it be that the sub-directory is populated after the device is
>> > created in the kernel, causing a race?
>> >
>> > Either that, or the contents of the scan_elements/ directory is not
>> > the
>> > one expected by this code.
>> >
>> > The output of this command should us that:
>> > ls /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-
>> > A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-
>> > 200073.8.auto/iio:device1/scan_elements
>>
>> Hmmm, this is interesting. I fetched, built and ran the latest
>> iio-sensor-proxy. It quit with the following error. However,
>> immediately afterwards, I ran the Debian packaged version (1.1-1),
>> and
>> the sensors started to work. Something in the latest master activates
>> the sensors enough for the older version to work.
>
> There's no changes in that code other than me introducing a bug that'd
> make it throw a warning when the sensor was already enabled. Fixed now.
>
> Could you try again, but make sure to replace the existing iio-sensor-
> proxy so it's started on boot, when the device appears. If you see the
> warning again, please attach the output out from "ls" as requested in
> the earlier mail.

Oops, missed that the first time. Here you go:

root@gladys:~# ls
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1/scan_elements
in_accel_x_en     in_accel_y_en     in_accel_z_en
in_accel_x_index  in_accel_y_index  in_accel_z_index
in_accel_x_type   in_accel_y_type   in_accel_z_type

> If it doesn't warn on startup, and it fails to work, then we're
> probably looking at a bug in the kernel...

Here is the output. The latest master still doesn't work. However, it
has the same behaviour that running the broken version of
iio-sensors-proxy (207b5bbd8) will cause the good one start working
(92fa6ea9e).

-- Logs begin at Tue 2016-06-14 22:19:47 BST, end at Tue 2016-06-14
22:20:52 BST. --
Jun 14 22:19:48 gladys systemd[1]: Starting IIO Sensor Proxy service...
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Found device /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Found device /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1/scan_elements/in_accel_x_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1/scan_elements/in_accel_y_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1/scan_elements/in_accel_z_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_accel_x: is signed: 1, bytes: 4, bits_used: 32, shift:
0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_accel_y: is signed: 1, bytes: 4, bits_used: 32, shift:
0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_accel_z: is signed: 1, bytes: 4, bits_used: 32, shift:
0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_accel_x: is signed: 1, bytes: 4, bits_used:
32, shift: 0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_accel_y: is signed: 1, bytes: 4, bits_used:
32, shift: 0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_accel_z: is signed: 1, bytes: 4, bits_used:
32, shift: 0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6/scan_elements/in_magn_x_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6/scan_elements/in_magn_y_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6/scan_elements/in_magn_z_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Enabled sensor /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6/scan_elements/in_rot_from_north_magnetic_tilt_comp_en
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_magn_x: is signed: 1, bytes: 4, bits_used: 32, shift:
0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_magn_y: is signed: 1, bytes: 4, bits_used: 32, shift:
0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_magn_z: is signed: 1, bytes: 4, bits_used: 32, shift:
0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Got type for in_rot_from_north_magnetic_tilt_comp: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_magn_x: is signed: 1, bytes: 4, bits_used:
32, shift: 0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_magn_y: is signed: 1, bytes: 4, bits_used:
32, shift: 0, mask: 0x0, be: 0
Jun 14 22:19:48 gladys systemd[1]: Started IIO Sensor Proxy service.
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_magn_z: is signed: 1, bytes: 4, bits_used:
32, shift: 0, mask: 0x0, be: 0
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Built channel array for in_rot_from_north_magnetic_tilt_comp: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Handling driver refcounting method 'ClaimAccelerometer' for
accelerometer device
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Handling driver refcounting method 'ReleaseLight' for ambient light
sensor device
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
Handling driver refcounting method 'ClaimAccelerometer' for
accelerometer device
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:44 gladys iio-sensor-proxy[577]: ** (process:577): DEBUG:
No new data available
Jun 14 22:20:47 gladys systemd[1]: Stopping IIO Sensor Proxy service...
Jun 14 22:20:47 gladys iio-sensor-proxy[577]: ** (process:577):
Jun 14 22:20:47 gladys systemd[1]: Stopped IIO Sensor Proxy service.



>
> Cheers
