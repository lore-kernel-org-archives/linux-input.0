From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Tue, 14 Jun 2016 14:44:11 +0100
Message-ID: <CACxGe6sjFHS9VaeWUY1PsJXhTW1Nvkuoqutty9oSX2Ywj+yV9g@mail.gmail.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
 <1465509287.24319.3.camel@linux.intel.com> <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
 <1465566904.10525.11.camel@linux.intel.com> <1465568791.7409.38.camel@hadess.net>
 <1465569941.10525.17.camel@linux.intel.com> <1465571076.7409.39.camel@hadess.net>
 <1465572227.24319.7.camel@linux.intel.com> <1465572452.7409.41.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465572452.7409.41.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Darren Hart <darren-P76s1CtE8BHQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 10, 2016 at 4:27 PM, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:
> On Fri, 2016-06-10 at 08:23 -0700, Srinivas Pandruvada wrote:
>> On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
>> > >
>>
>> [...]
>>
>> > Are there any errors when setting the triggers?
>> >
>> Is there any debug option in this service to give more verbose
>> output?
>
> Add:
> Environment="G_MESSAGES_DEBUG=all"
>
> To the service file. You should see the debug in systemctl:
> systemctl status iio-sensor-proxy.service
>
> Or in journalctl if there's too much data:
> journalctl --reverse -u iio-sensor-proxy.service

Still no joy on the sensors. The proxy starts up and detects the
sensors, but I don't see any sensor events occurring:

root@gladys:~# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy
** (process:2802): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
** (process:2802): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:2802): DEBUG: Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
** (process:2802): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
** (process:2802): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1
** (process:2802): DEBUG: Got type for in_accel_x: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Got type for in_accel_y: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Got type for in_accel_z: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for in_accel_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for in_accel_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for in_accel_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6
** (process:2802): DEBUG: Got type for in_magn_x: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Got type for in_magn_y: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Got type for in_magn_z: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Got type for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for in_magn_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for in_magn_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for in_magn_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Built channel array for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2802): DEBUG: Handling driver refcounting method
'ClaimLight' for ambient light sensor device
** (process:2802): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:2802): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:2802): DEBUG: No new data available
** (process:2802): DEBUG: No new data available
^C
root@gladys:~# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy
** (process:3568): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
** (process:3568): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:3568): DEBUG: Found magn_3d at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
** (process:3568): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/iio:device6
of type compass at IIO Buffer Compass
** (process:3568): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/trigger1
** (process:3568): DEBUG: Got type for in_accel_x: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Got type for in_accel_y: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Got type for in_accel_z: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for in_accel_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for in_accel_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for in_accel_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0003/HID-SENSOR-200083.27.auto/trigger6
** (process:3568): DEBUG: Got type for in_magn_x: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Got type for in_magn_y: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Got type for in_magn_z: is signed: 1, bytes:
4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Got type for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for in_magn_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for in_magn_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for in_magn_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Built channel array for
in_rot_from_north_magnetic_tilt_comp: is signed: 1, bytes: 4,
bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:3568): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:3568): DEBUG: Handling driver refcounting method
'ClaimLight' for ambient light sensor device
** (process:3568): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
** (process:3568): DEBUG: No new data available
^C
root@gladys:~#

This is running on a 4.6.2 kernel with v2 of the ISH patch set.

Here is the kernel log output:

[    0.000000] Linux version 4.6.2-gcl1+ (grant@gladys) (gcc version
5.3.1 20160528 (Debian 5.3.1-21) ) #8 SMP Tue Jun 14 12:19:30 BST 2016
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.6.2-gcl1+
root=/dev/mapper/gladys--vg-debian ro quiet
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  960, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]: 1024, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is
1088 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ec6dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ec6e000-0x000000007ec6efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007ec6f000-0x000000007ec98fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ec99000-0x00000000864c7fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000864c8000-0x00000000871ccfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000871cd000-0x0000000087218fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000087219000-0x0000000087b5afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000087b5b000-0x0000000087f68fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000087f69000-0x0000000087ffefff] type 20
[    0.000000] BIOS-e820: [mem 0x0000000087fff000-0x0000000087ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000088000000-0x00000000880fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000473ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ESRT=0x87f65118  ACPI=0x871e4000  ACPI
2.0=0x871e4000  SMBIOS=0x853cb010
[    0.000000] esrt: Reserving ESRT space from 0x0000000087f65118 to
0x0000000087f65150.
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: HP HP Spectre x360 Convertible/81A1, BIOS F.35 04/26/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x474000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.000000]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.000000]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.000000]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.000000]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.000000]   5 base 0089000000 mask 7FFF000000 uncachable
[    0.000000]   6 base 0088800000 mask 7FFF800000 uncachable
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] e820: last_pfn = 0x88000 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x03341000, 0x03341fff] PGTABLE
[    0.000000] BRK [0x03342000, 0x03342fff] PGTABLE
[    0.000000] BRK [0x03343000, 0x03343fff] PGTABLE
[    0.000000] BRK [0x03344000, 0x03344fff] PGTABLE
[    0.000000] BRK [0x03345000, 0x03345fff] PGTABLE
[    0.000000] BRK [0x03346000, 0x03346fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x36022000-0x37008fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000871E4000 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000871E40A8 0000D4 (v01 HPQOEM
SLIC-MPC 01072009 HP   00010013)
[    0.000000] ACPI: FACP 0x0000000087210630 00010C (v05 HPQOEM
SLIC-MPC 01072009 HP   00010013)
[    0.000000] ACPI: DSDT 0x00000000871E4210 02C419 (v02 HPQOEM 81A1
  01072009 ACPI 20120913)
[    0.000000] ACPI: FACS 0x0000000087B58F80 000040
[    0.000000] ACPI: APIC 0x0000000087210740 000084 (v03 HPQOEM 81A1
  01072009 HP   00010013)
[    0.000000] ACPI: FPDT 0x00000000872107C8 000044 (v01 HPQOEM 81A1
  01072009 HP   00010013)
[    0.000000] ACPI: FIDT 0x0000000087210810 00009C (v01 HPQOEM 81A1
  01072009 HP   00010013)
[    0.000000] ACPI: MCFG 0x00000000872108B0 00003C (v01 HPQOEM 81A1
  01072009 HP   00000097)
[    0.000000] ACPI: HPET 0x00000000872108F0 000038 (v01 HPQOEM 81A1
  01072009 HP   0005000B)
[    0.000000] ACPI: SSDT 0x0000000087210928 000495 (v01 HPQOEM 81A1
  00001000 ACPI 20120913)
[    0.000000] ACPI: LPIT 0x0000000087210DC0 000094 (v01 HPQOEM 81A1
  00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x0000000087210E58 000248 (v02 HPQOEM 81A1
  00000000 ACPI 20120913)
[    0.000000] ACPI: SSDT 0x00000000872110A0 0011A8 (v02 HPQOEM 81A1
  00001000 ACPI 20120913)
[    0.000000] ACPI: DBGP 0x0000000087212248 000034 (v01 HPQOEM 81A1
  00000000 MSFT 0000005F)
[    0.000000] ACPI: DBG2 0x0000000087212280 000054 (v00 HPQOEM 81A1
  00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x00000000872122D8 000024 (v02 HPQOEM 81A1
  00000000 ACPI 20120913)
[    0.000000] ACPI: MSDM 0x0000000087212300 000055 (v03 HPQOEM
SLIC-MPC 00000001 ACPI 00010013)
[    0.000000] ACPI: SSDT 0x0000000087212358 0053FD (v02 HPQOEM 81A1
  00003000 ACPI 20120913)
[    0.000000] ACPI: UEFI 0x0000000087217758 000042 (v01 HPQOEM 81A1
  00000000 HP   00000000)
[    0.000000] ACPI: SSDT 0x00000000872177A0 000E73 (v02 HPQOEM 81A1
  00003000 ACPI 20120913)
[    0.000000] ACPI: DMAR 0x0000000087218618 0000A8 (v01 HPQOEM 81A1
  00000001 INTL 00000001)
[    0.000000] ACPI: NHLT 0x00000000872186C0 00002D (v00 HPQOEM 81A1
  00000002      01000013)
[    0.000000] ACPI: TPM2 0x00000000872186F0 000034 (v03 HPQOEM 81A1
  00000001 HP   00000000)
[    0.000000] ACPI: ASF! 0x0000000087218728 0000A5 (v32 HPQOEM 81A1
  00000001 HP   000F4240)
[    0.000000] ACPI: BGRT 0x00000000872187D0 000038 (v01 HPQOEM 81A1
  01072009 HP   00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000473ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x473ff8000-0x473ffcfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000473ffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007ec6dfff]
[    0.000000]   node   0: [mem 0x000000007ec99000-0x00000000864c7fff]
[    0.000000]   node   0: [mem 0x0000000087fff000-0x0000000087ffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000473ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000473ffffff]
[    0.000000] On node 0 totalpages: 4170810
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 8531 pages used for memmap
[    0.000000]   DMA32 zone: 545950 pages, LIFO batch:31
[    0.000000]   Normal zone: 56576 pages used for memmap
[    0.000000]   Normal zone: 3620864 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0x89000000-0x8affffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ec6e000-0x7ec6efff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ec6f000-0x7ec98fff]
[    0.000000] PM: Registered nosave memory: [mem 0x864c8000-0x871ccfff]
[    0.000000] PM: Registered nosave memory: [mem 0x871cd000-0x87218fff]
[    0.000000] PM: Registered nosave memory: [mem 0x87219000-0x87b5afff]
[    0.000000] PM: Registered nosave memory: [mem 0x87b5b000-0x87f68fff]
[    0.000000] PM: Registered nosave memory: [mem 0x87f69000-0x87ffefff]
[    0.000000] PM: Registered nosave memory: [mem 0x88000000-0x880fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x88100000-0x88ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x89000000-0x8affffff]
[    0.000000] PM: Registered nosave memory: [mem 0x8b000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x8b000000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4
nr_node_ids:1
[    0.000000] percpu: Embedded 32 pages/cpu @ffff880473c00000 s93080
r8192 d29800 u524288
[    0.000000] pcpu-alloc: s93080 r8192 d29800 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 4105617
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-4.6.2-gcl1+
root=/dev/mapper/gladys--vg-debian ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 16277592K/16683240K available (6489K kernel
code, 1150K rwdata, 2900K rodata, 1348K init, 792K bss, 405648K
reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 64.
[    0.000000] RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:1024 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: PIT calibration matches HPET. 1 loops
[    0.000000] tsc: Detected 2591.938 MHz processor
[    0.000022] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5183.87 BogoMIPS (lpj=10367752)
[    0.000024] pid_max: default: 32768 minimum: 301
[    0.000032] ACPI: Core revision 20160108
[    0.023560] ACPI Error: [\_SB_.PCI0.SAT1] Namespace lookup failure,
AE_NOT_FOUND (20160108/dswload-210)
[    0.023564] ACPI Exception: AE_NOT_FOUND, During name
lookup/catalog (20160108/psobject-227)
[    0.023617] ACPI Exception: AE_NOT_FOUND, (SSDT:81A1    ) while
loading table (20160108/tbxfload-227)
[    0.032847] ACPI Error: 1 table load failures, 6 successful
(20160108/tbxfload-247)
[    0.033067] Security Framework initialized
[    0.033068] Yama: becoming mindful.
[    0.033073] AppArmor: AppArmor disabled by boot time parameter
[    0.033897] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes)
[    0.036231] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.037283] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.037297] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes)
[    0.037509] CPU: Physical Processor ID: 0
[    0.037510] CPU: Processor Core ID: 0
[    0.037513] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.037514] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.037518] mce: CPU supports 8 MCE banks
[    0.037530] CPU0: Thermal monitoring enabled (TM1)
[    0.037537] process: using mwait in idle threads
[    0.037539] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.037540] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.037832] Freeing SMP alternatives memory: 28K (ffffffff81e72000
- ffffffff81e79000)
[    0.041714] ftrace: allocating 25763 entries in 101 pages
[    0.049725] smpboot: Max logical packages: 2
[    0.049727] smpboot: APIC(0) Converting physical 0 to logical package 0
[    0.049730] DMAR: Host address width 39
[    0.049731] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.049737] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
1c0000c40660462 ecap 7e3ff0505e
[    0.049738] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.049741] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008c40660462 ecap f050da
[    0.049742] DMAR: RMRR base: 0x00000086f6f000 end: 0x00000086f8efff
[    0.049743] DMAR: RMRR base: 0x00000088800000 end: 0x0000008affffff
[    0.049745] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.049746] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.049746] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.049748] DMAR-IR: Use 'intremap=no_x2apic_optout' to override
the BIOS setting.
[    0.051125] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.051126] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.055103] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.094793] TSC deadline timer enabled
[    0.094798] smpboot: CPU0: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
(family: 0x6, model: 0x4e, stepping: 0x3)
[    0.094811] Performance Events: PEBS fmt3+, 32-deep LBR, Skylake
events, full-width counters, Intel PMU driver.
[    0.094833] ... version:                4
[    0.094834] ... bit width:              48
[    0.094835] ... generic registers:      4
[    0.094835] ... value mask:             0000ffffffffffff
[    0.094836] ... max period:             0000ffffffffffff
[    0.094836] ... fixed-purpose events:   3
[    0.094837] ... event mask:             000000070000000f
[    0.095242] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.095308] x86: Booting SMP configuration:
[    0.095309] .... node  #0, CPUs:      #1 #2 #3
[    0.336932] x86: Booted up 1 node, 4 CPUs
[    0.336935] smpboot: Total of 4 processors activated (20738.16 BogoMIPS)
[    0.340871] devtmpfs: initialized
[    0.340918] x86/mm: Memory block size: 128MB
[    0.343217] PM: Registering ACPI NVS region [mem
0x7ec6e000-0x7ec6efff] (4096 bytes)
[    0.343218] PM: Registering ACPI NVS region [mem
0x87219000-0x87b5afff] (9707520 bytes)
[    0.343394] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.343471] pinctrl core: initialized pinctrl subsystem
[    0.343581] NET: Registered protocol family 16
[    0.352543] cpuidle: using governor ladder
[    0.360957] cpuidle: using governor menu
[    0.361011] ACPI: bus type PCI registered
[    0.361013] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.361079] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.361080] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.361091] PCI: Using configuration type 1 for base access
[    0.372676] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.372677] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.372896] ACPI: Added _OSI(Module Device)
[    0.372898] ACPI: Added _OSI(Processor Device)
[    0.372899] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.372900] ACPI: Added _OSI(Processor Aggregator Device)
[    0.374175] ACPI: Executed 24 blocks of module-level executable AML code
[    0.383839] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.386855] ACPI: Dynamic OEM Table Load:
[    0.386860] ACPI: SSDT 0xFFFF8804630EA800 000660 (v02 PmRef
Cpu0Ist  00003000 INTL 20120913)
[    0.387724] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.389154] ACPI: Dynamic OEM Table Load:
[    0.389159] ACPI: SSDT 0xFFFF880460C20400 00037F (v02 PmRef
Cpu0Cst  00003001 INTL 20120913)
[    0.390513] ACPI: Dynamic OEM Table Load:
[    0.390518] ACPI: SSDT 0xFFFF8804630EA000 0005AA (v02 PmRef  ApIst
  00003000 INTL 20120913)
[    0.391507] ACPI: Dynamic OEM Table Load:
[    0.391510] ACPI: SSDT 0xFFFF880460D87E00 000119 (v02 PmRef  ApCst
  00003000 INTL 20120913)
[    0.393865] ACPI : EC: EC started
[    0.404894] ACPI: Interpreter enabled
[    0.404923] ACPI: (supports S0 S3 S4 S5)
[    0.404924] ACPI: Using IOAPIC for interrupt routing
[    0.404951] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.406634] ACPI: Power Resource [PG00] (on)
[    0.406893] ACPI: Power Resource [PG01] (on)
[    0.407144] ACPI: Power Resource [PG02] (on)
[    0.408459] ACPI: Power Resource [WRST] (off)
[    0.408713] ACPI: Power Resource [WRST] (off)
[    0.408966] ACPI: Power Resource [WRST] (off)
[    0.409222] ACPI: Power Resource [WRST] (off)
[    0.409476] ACPI: Power Resource [WRST] (off)
[    0.409738] ACPI: Power Resource [WRST] (off)
[    0.410187] ACPI: Power Resource [WRST] (off)
[    0.410439] ACPI: Power Resource [WRST] (off)
[    0.410690] ACPI: Power Resource [WRST] (off)
[    0.411294] ACPI: Power Resource [WRST] (off)
[    0.411547] ACPI: Power Resource [WRST] (off)
[    0.411798] ACPI: Power Resource [WRST] (off)
[    0.412049] ACPI: Power Resource [WRST] (off)
[    0.412301] ACPI: Power Resource [WRST] (off)
[    0.412554] ACPI: Power Resource [WRST] (off)
[    0.412805] ACPI: Power Resource [WRST] (off)
[    0.413062] ACPI: Power Resource [WRST] (off)
[    0.413314] ACPI: Power Resource [WRST] (off)
[    0.413566] ACPI: Power Resource [WRST] (off)
[    0.413817] ACPI: Power Resource [WRST] (off)
[    0.421419] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.421424] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.422692] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.423177] PCI host bridge to bus 0000:00
[    0.423179] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.423181] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.423182] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.423183] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000c3fff window]
[    0.423183] pci_bus 0000:00: root bus resource [mem
0x000c4000-0x000c7fff window]
[    0.423184] pci_bus 0000:00: root bus resource [mem
0x000c8000-0x000cbfff window]
[    0.423186] pci_bus 0000:00: root bus resource [mem
0x000cc000-0x000cffff window]
[    0.423187] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000d3fff window]
[    0.423188] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff window]
[    0.423188] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff window]
[    0.423189] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff window]
[    0.423190] pci_bus 0000:00: root bus resource [mem
0x8b000000-0xdfffffff window]
[    0.423191] pci_bus 0000:00: root bus resource [mem
0xfd000000-0xfe7fffff window]
[    0.423193] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.423198] pci 0000:00:00.0: [8086:1904] type 00 class 0x060000
[    0.423448] pci 0000:00:02.0: [8086:1916] type 00 class 0x030000
[    0.423455] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    0.423460] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff
64bit pref]
[    0.423463] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.423623] pci 0000:00:13.0: [8086:9d35] type 00 class 0x000000
[    0.423640] pci 0000:00:13.0: reg 0x10: [mem 0xdf32b000-0xdf32bfff 64bit]
[    0.423790] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.423808] pci 0000:00:14.0: reg 0x10: [mem 0xdf310000-0xdf31ffff 64bit]
[    0.423873] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.423957] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.423988] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.424005] pci 0000:00:14.2: reg 0x10: [mem 0xdf32a000-0xdf32afff 64bit]
[    0.424153] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.424167] pci 0000:00:16.0: reg 0x10: [mem 0xdf329000-0xdf329fff 64bit]
[    0.424215] pci 0000:00:16.0: PME# supported from D3hot
[    0.424345] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.424400] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.424500] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.424527] pci 0000:00:1c.1: [8086:9d11] type 01 class 0x060400
[    0.424583] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.424680] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.424713] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.424775] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.424874] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.424917] pci 0000:00:1f.0: [8086:9d48] type 00 class 0x060100
[    0.425114] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.425122] pci 0000:00:1f.2: reg 0x10: [mem 0xdf324000-0xdf327fff]
[    0.425258] pci 0000:00:1f.3: [8086:9d70] type 00 class 0x040100
[    0.425277] pci 0000:00:1f.3: reg 0x10: [mem 0xdf320000-0xdf323fff 64bit]
[    0.425302] pci 0000:00:1f.3: reg 0x20: [mem 0xdf300000-0xdf30ffff 64bit]
[    0.425348] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.425475] pci 0000:00:1f.3: System wakeup disabled by ACPI
[    0.425507] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.425554] pci 0000:00:1f.4: reg 0x10: [mem 0xdf328000-0xdf3280ff 64bit]
[    0.425623] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.425851] pci 0000:01:00.0: [10ec:5227] type 00 class 0xff0000
[    0.425871] pci 0000:01:00.0: reg 0x10: [mem 0xdf200000-0xdf200fff]
[    0.425987] pci 0000:01:00.0: supports D1 D2
[    0.425988] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.426064] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.433081] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.433086] pci 0000:00:1c.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.433297] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000
[    0.433375] pci 0000:02:00.0: reg 0x10: [mem 0xdf100000-0xdf101fff 64bit]
[    0.433630] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.433825] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.441226] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.441231] pci 0000:00:1c.1:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.441566] pci 0000:03:00.0: [1179:010f] type 00 class 0x010802
[    0.441584] pci 0000:03:00.0: reg 0x10: [mem 0xdf000000-0xdf003fff 64bit]
[    0.441739] pci 0000:03:00.0: System wakeup disabled by ACPI
[    0.449360] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.449364] pci 0000:00:1c.4:   bridge window [mem 0xdf000000-0xdf0fffff]
[    0.451348] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.451395] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.451440] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.451485] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.451529] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.451574] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.451619] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.451663] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.452452] ACPI: Enabled 5 GPEs in block 00 to 7F
[    0.452546] ACPI : EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.452618] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.452619] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.452622] vgaarb: loaded
[    0.452622] vgaarb: bridge control possible 0000:00:02.0
[    0.452729] PCI: Using ACPI for IRQ routing
[    0.480782] PCI: pci_cache_line_size set to 64 bytes
[    0.481376] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.481377] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.481378] e820: reserve RAM buffer [mem 0x7ec6e000-0x7fffffff]
[    0.481379] e820: reserve RAM buffer [mem 0x864c8000-0x87ffffff]
[    0.481524] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.481528] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.483569] clocksource: Switched to clocksource hpet
[    0.488311] VFS: Disk quotas dquot_6.6.0
[    0.488343] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.488441] pnp: PnP ACPI init
[    0.488612] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.488613] system 00:00: [io  0xffff] has been reserved
[    0.488614] system 00:00: [io  0xffff] has been reserved
[    0.488615] system 00:00: [io  0xffff] has been reserved
[    0.488617] system 00:00: [io  0x1800-0x18fe] could not be reserved
[    0.488618] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.488620] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.488690] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.488717] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.488719] system 00:02: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.488750] pnp 00:03: Plug and Play ACPI device, IDs HPQ8001
PNP0303 (active)
[    0.488772] pnp 00:04: Plug and Play ACPI device, IDs SYN3206
SYN1e00 SYN0002 PNP0f13 (active)
[    0.488931] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.488933] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.488934] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.488935] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.488936] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.488937] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.488938] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.488940] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.488941] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.488942] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    0.488944] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.488972] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.488974] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.488975] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.488976] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.488977] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.488978] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.488979] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.488981] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.489189] system 00:07: [io  0xff00-0xfffe] has been reserved
[    0.489190] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.489971] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
[    0.489972] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
[    0.489973] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.489975] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.489976] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.489977] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.491313] pnp: PnP ACPI: found 9 devices
[    0.499891] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.499912] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.499916] pci 0000:00:1c.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.499921] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.499924] pci 0000:00:1c.1:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.499930] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.499933] pci 0000:00:1c.4:   bridge window [mem 0xdf000000-0xdf0fffff]
[    0.499939] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.499940] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.499941] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.499942] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.499943] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.499944] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.499945] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.499946] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.499947] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.499948] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.499949] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.499950] pci_bus 0000:00: resource 15 [mem 0x8b000000-0xdfffffff window]
[    0.499950] pci_bus 0000:00: resource 16 [mem 0xfd000000-0xfe7fffff window]
[    0.499952] pci_bus 0000:01: resource 1 [mem 0xdf200000-0xdf2fffff]
[    0.499953] pci_bus 0000:02: resource 1 [mem 0xdf100000-0xdf1fffff]
[    0.499953] pci_bus 0000:03: resource 1 [mem 0xdf000000-0xdf0fffff]
[    0.500108] NET: Registered protocol family 2
[    0.500295] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.500434] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.500532] TCP: Hash tables configured (established 131072 bind 65536)
[    0.500550] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.500584] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.500717] NET: Registered protocol family 1
[    0.500729] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.501934] PCI: CLS 0 bytes, default 64
[    0.501965] Unpacking initramfs...
[    0.726991] Freeing initrd memory: 16284K (ffff880036022000 -
ffff880037009000)
[    0.727012] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.727014] software IO TLB [mem 0x806f3000-0x846f3000] (64MB)
mapped at [ffff8800806f3000-ffff8800846f2fff]
[    0.727148] simple-framebuffer simple-framebuffer.0: framebuffer at
0xc0000000, 0x1d5000 bytes, mapped to 0xffffc90001c00000
[    0.727150] simple-framebuffer simple-framebuffer.0:
format=a8r8g8b8, mode=800x600x32, linelength=3200
[    0.728026] Console: switching to colour frame buffer device 100x37
[    0.728724] simple-framebuffer simple-framebuffer.0: fb0: simplefb
registered!
[    0.728939] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.728986] audit: initializing netlink subsys (disabled)
[    0.728999] audit: type=2000 audit(1465914671.728:1): initialized
[    0.729302] Initialise system trusted keyring
[    0.729499] workingset: timestamp_bits=37 max_order=22 bucket_order=0
[    0.729536] zbud: loaded
[    0.730142] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.761502] Key type asymmetric registered
[    0.761505] Asymmetric key parser 'x509' registered
[    0.761541] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
[    0.761595] io scheduler noop registered
[    0.761598] io scheduler deadline registered
[    0.761655] io scheduler cfq registered (default)
[    0.762173] aer 0000:00:1c.0:pcie02: service driver aer loaded
[    0.762194] aer 0000:00:1c.1:pcie02: service driver aer loaded
[    0.762216] aer 0000:00:1c.4:pcie02: service driver aer loaded
[    0.762227] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    0.762228] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.762230] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    0.762236] pcieport 0000:00:1c.1: Signaling PME through PCIe PME interrupt
[    0.762237] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.762239] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme loaded
[    0.762246] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    0.762246] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    0.762249] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    0.762253] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.762257] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.762272] intel_idle: MWAIT substates: 0x11142120
[    0.762272] intel_idle: v0.4.1 model 0x4E
[    0.762435] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.762475] GHES: HEST is not enabled!
[    0.762542] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.763007] Linux agpgart interface v0.103
[    0.763305] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    0.770763] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.770765] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.771027] mousedev: PS/2 mouse device common for all mice
[    0.771285] rtc_cmos 00:01: RTC can wake from S4
[    0.771880] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    0.771959] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    0.771966] Intel P-state driver initializing.
[    0.823816] intel_pstate: HWP enabled
[    0.823828] ledtrig-cpu: registered to indicate activity on CPUs
[    0.824036] EFI Variables Facility v0.08 2004-May-17
[    0.828778] pstore: Registered efi as persistent store backend
[    0.828796] hidraw: raw HID events driver (C) Jiri Kosina
[    0.829052] intel_ish_ipc 0000:00:13.0: enabling device (0000 -> 0002)
[    0.845705] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    1.340502] NET: Registered protocol family 10
[    1.340790] mip6: Mobile IPv6
[    1.340793] NET: Registered protocol family 17
[    1.340801] mpls_gso: MPLS GSO support
[    1.341059] microcode: CPU0 sig=0x406e3, pf=0x80, revision=0x88
[    1.341074] microcode: CPU1 sig=0x406e3, pf=0x80, revision=0x88
[    1.341093] microcode: CPU2 sig=0x406e3, pf=0x80, revision=0x88
[    1.341098] microcode: CPU3 sig=0x406e3, pf=0x80, revision=0x88
[    1.341178] microcode: Microcode Update Driver: v2.01
<tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.341458] registered taskstats version 1
[    1.341467] Loading compiled-in X.509 certificates
[    1.341497] zswap: loaded using pool lzo/zbud
[    1.342687] Key type encrypted registered
[    1.344160] rtc_cmos 00:01: setting system clock to 2016-06-14
14:31:13 UTC (1465914673)
[    1.345282] ish {33AECD58-B679-4E54-9BD9-A04D34F0C226}: [hid-ish]:
enum_devices_done OK, num_hid_devices=6
[    1.386370] PM: Hibernation image not present or could not be loaded.
[    1.387185] Freeing unused kernel memory: 1348K (ffffffff81d21000 -
ffffffff81e72000)
[    1.387186] Write protecting the kernel read-only data: 12288k
[    1.387678] Freeing unused kernel memory: 1688K (ffff880002a5a000 -
ffff880002c00000)
[    1.389292] Freeing unused kernel memory: 1196K (ffff880002ed5000 -
ffff880003000000)
[    1.394109] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.436305] random: systemd-udevd urandom read with 17 bits of
entropy available
[    1.456514] fjes: module verification failed: signature and/or
required key missing - tainting kernel
[    1.456707] FUJITSU Extended Socket Network Device Driver - version
1.0 - Copyright (c) 2015 FUJITSU LIMITED
[    1.480814] [Firmware Bug]: Invalid critical threshold (0)
[    1.483549] thermal LNXTHERM:00: registered as thermal_zone0
[    1.483551] ACPI: Thermal Zone [TZ01] (45 C)
[    1.491312] rtsx_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    1.491433] rtsx_pci 0000:01:00.0: rtsx_pci_acquire_irq:
pcr->msi_en = 1, pci->irq = 145
[    1.491796] ACPI: bus type USB registered
[    1.491816] usbcore: registered new interface driver usbfs
[    1.491847] usbcore: registered new interface driver hub
[    1.491888] usbcore: registered new device driver usb
[    1.493088] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.493096] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    1.493142] nvme nvme0: pci function 0000:03:00.0
[    1.494298] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x00109810
[    1.494316] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.494490] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.494492] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.494493] usb usb1: Product: xHCI Host Controller
[    1.494494] usb usb1: Manufacturer: Linux 4.6.2-gcl1+ xhci-hcd
[    1.494495] usb usb1: SerialNumber: 0000:00:14.0
[    1.494690] hub 1-0:1.0: USB hub found
[    1.494757] hub 1-0:1.0: 12 ports detected
[    1.501134] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.501138] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    1.501197] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.501198] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.501199] usb usb2: Product: xHCI Host Controller
[    1.501200] usb usb2: Manufacturer: Linux 4.6.2-gcl1+ xhci-hcd
[    1.501201] usb usb2: SerialNumber: 0000:00:14.0
[    1.501351] hub 2-0:1.0: USB hub found
[    1.501362] hub 2-0:1.0: 6 ports detected
[    1.504015] usb: port power management may be unreliable
[    1.702796]  nvme0n1: p1 p2 p3 p4 p5 p6
[    1.727710] tsc: Refined TSC clocksource calibration: 2591.987 MHz
[    1.727720] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x255caa87895, max_idle_ns: 440795290362 ns
[    1.867746] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    2.061667] usb 1-6: New USB device found, idVendor=1bcf, idProduct=2c7d
[    2.061675] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.061680] usb 1-6: Product: HP Truevision Full HD
[    2.061683] usb 1-6: Manufacturer: DEKHP029I1833A
[    2.231826] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    2.339551] psmouse serio1: synaptics: queried max coordinates: x
[..5610], y [..4700]
[    2.378122] psmouse serio1: synaptics: queried min coordinates: x
[1394..], y [1238..]
[    2.418612] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2a
[    2.418619] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.454739] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2,
id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 2869, fw
id: 1953112
[    2.503796] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input2
[    2.569517] device-mapper: uevent: version 1.0.3
[    2.569613] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28)
initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.587719] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[    2.600433] EXT4-fs (dm-0): mounted filesystem with ordered data
mode. Opts: (null)
[    2.652860] systemd[1]: RTC configured in localtime, applying delta
of 60 minutes to system time.
[    2.688589] systemd[1]: systemd 230 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[    2.688763] systemd[1]: Detected architecture x86-64.
[    2.688966] systemd[1]: Set hostname to <gladys>.
[    2.727929] clocksource: Switched to clocksource tsc
[    2.733963] systemd[1]: Listening on udev Kernel Socket.
[    2.734016] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    2.734043] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    2.734050] systemd[1]: Reached target User and Group Name Lookups.
[    2.734056] systemd[1]: Reached target Remote File Systems (Pre).
[    2.734061] systemd[1]: Reached target Encrypted Volumes.
[    2.734080] systemd[1]: Listening on Syslog Socket.
[    2.734133] systemd[1]: Listening on Journal Audit Socket.
[    2.734142] systemd[1]: Reached target Remote File Systems.
[    2.734211] systemd[1]: Created slice User and Session Slice.
[    2.734231] systemd[1]: Listening on LVM2 poll daemon socket.
[    2.734242] systemd[1]: Listening on LVM2 metadata daemon socket.
[    2.734262] systemd[1]: Listening on udev Control Socket.
[    2.734281] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    2.734293] systemd[1]: Listening on fsck to fsckd communication Socket.
[    2.734344] systemd[1]: Created slice System Slice.
[    2.734356] systemd[1]: Reached target Slices.
[    2.734409] systemd[1]: Created slice system-getty.slice.
[    2.734458] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.734483] systemd[1]: Listening on Journal Socket.
[    2.755975] systemd[1]: Starting Set the console keyboard layout...
[    2.756498] systemd[1]: Mounting Huge Pages File System...
[    2.757105] systemd[1]: Mounting POSIX Message Queue File System...
[    2.757483] systemd[1]: Starting Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling...
[    2.757908] systemd[1]: Mounting Debug File System...
[    2.758175] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    2.759703] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.760083] systemd[1]: Starting Journal Service...
[    2.760415] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.760797] systemd[1]: Starting Create list of required static
device nodes for the current kernel...
[    2.760875] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[    2.764433] systemd[1]: Starting Load Kernel Modules...
[    2.765439] systemd[1]: Mounted Debug File System.
[    2.765459] systemd[1]: Mounted POSIX Message Queue File System.
[    2.765469] systemd[1]: Mounted Huge Pages File System.
[    2.765758] systemd[1]: Started Create list of required static
device nodes for the current kernel.
[    2.765931] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro
[    2.766529] systemd[1]: Started Remount Root and Kernel File Systems.
[    2.767188] systemd[1]: Started LVM2 metadata daemon.
[    2.767585] systemd[1]: Starting Load/Save Random Seed...
[    2.769278] systemd[1]: Starting udev Coldplug all Devices...
[    2.769697] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.771286] systemd[1]: Started Load Kernel Modules.
[    2.771487] systemd[1]: Started Load/Save Random Seed.
[    2.776112] systemd[1]: Mounting Configuration File System...
[    2.777745] systemd[1]: Starting Apply Kernel Variables...
[    2.780077] systemd[1]: Mounted Configuration File System.
[    2.781368] usb 1-8: New USB device found, idVendor=04f3, idProduct=2072
[    2.781371] usb 1-8: New USB device strings: Mfr=4, Product=14,
SerialNumber=0
[    2.781373] usb 1-8: Product: Touchscreen
[    2.781375] usb 1-8: Manufacturer: ELAN
[    2.781496] systemd[1]: Started Apply Kernel Variables.
[    2.785590] systemd[1]: Started Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling.
[    2.786117] systemd[1]: Started Create Static Device Nodes in /dev.
[    2.786506] systemd[1]: Starting udev Kernel Device Manager...
[    2.790685] systemd[1]: Started Journal Service.
[    2.794159] systemd-journald[231]: Received request to flush
runtime journal from PID 1
[    2.831196] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input3
[    2.834298] Initializing HPQ6001 module
[    2.834346] input: HP Wireless hotkeys as /devices/virtual/input/input4
[    2.836380] ACPI: Lid Switch [LID0]
[    2.836439] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input5
[    2.836442] ACPI: Power Button [PWRB]
[    2.836601] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input6
[    2.836604] ACPI: Power Button [PWRF]
[    2.836851] ACPI: AC Adapter [ADP1] (off-line)
[    2.840200] Bluetooth: Core ver 2.21
[    2.840212] NET: Registered protocol family 31
[    2.840214] Bluetooth: HCI device and connection manager initialized
[    2.840216] Bluetooth: HCI socket layer initialized
[    2.840219] Bluetooth: L2CAP socket layer initialized
[    2.840223] Bluetooth: SCO socket layer initialized
[    2.841896] Bluetooth: HCI UART driver ver 2.3
[    2.841898] Bluetooth: HCI UART protocol H4 registered
[    2.841900] Bluetooth: HCI UART protocol BCSP registered
[    2.841901] Bluetooth: HCI UART protocol LL registered
[    2.841902] Bluetooth: HCI UART protocol ATH3K registered
[    2.841903] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    2.841937] Bluetooth: HCI UART protocol Intel registered
[    2.841953] Bluetooth: HCI UART protocol BCM registered
[    2.841953] Bluetooth: HCI UART protocol QCA registered
[    2.848567] usbcore: registered new interface driver usbhid
[    2.848569] usbhid: USB HID core driver
[    2.865676] [drm] Initialized drm 1.1.0 20060810
[    2.876538] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    2.879000] usbcore: registered new interface driver btusb
[    2.881627] media: Linux media interface: v0.10
[    2.883645] Linux video capture interface: v2.00
[    2.885785] uvcvideo: Found UVC 1.00 device HP Truevision Full HD (1bcf:2c7d)
[    2.890753] [drm] Memory usable by graphics device = 4096M
[    2.890756] checking generic (c0000000 1d5000) vs hw (c0000000 10000000)
[    2.890757] fb: switching to inteldrmfb from simple
[    2.890793] Console: switching to colour dummy device 80x25
[    2.890849] [drm] Replacing VGA console driver
[    2.893060] uvcvideo 1-6:1.0: Entity type for entity Extension 4
was not initialized!
[    2.893063] uvcvideo 1-6:1.0: Entity type for entity Extension 3
was not initialized!
[    2.893064] uvcvideo 1-6:1.0: Entity type for entity Processing 2
was not initialized!
[    2.893066] uvcvideo 1-6:1.0: Entity type for entity Camera 1 was
not initialized!
[    2.893127] input: HP Truevision Full HD as
/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input7
[    2.893148] usbcore: registered new interface driver uvcvideo
[    2.893149] USB Video Class driver (1.1.1)
[    2.893737] Bluetooth: hci0: read Intel version: 370810011003110e00
[    2.894164] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
[    2.895773] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
[    2.897161] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.897163] [drm] Driver supports precise vblank timestamp query.
[    2.903246] i915 0000:00:02.0: Direct firmware load for
i915/skl_dmc_ver1.bin failed with error -2
[    2.903249] i915 0000:00:02.0: Failed to load DMC firmware
[https://01.org/linuxgraphics/intel-linux-graphics-firmwares],
disabling runtime power management.
[    2.907555] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.934825] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.935134] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[    2.935189] [drm] Initialized i915 1.6.0 20160229 for 0000:00:02.0 on minor 0
[    2.935245] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.935251] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    2.944516] ACPI Warning: SystemIO range
0x000000000000F040-0x000000000000F05F conflicts with OpRegion
0x000000000000F040-0x000000000000F04F (\_SB.PCI0.SBUS.SMBI)
(20160108/utaddress-255)
[    2.944522] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    2.945315] Intel(R) Wireless WiFi driver for Linux
[    2.945316] Copyright(c) 2003- 2015 Intel Corporation
[    2.945485] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    2.946255] iwlwifi 0000:02:00.0: Direct firmware load for
iwlwifi-7265D-21.ucode failed with error -2
[    2.946261] iwlwifi 0000:02:00.0: Direct firmware load for
iwlwifi-7265D-20.ucode failed with error -2
[    2.946267] iwlwifi 0000:02:00.0: Direct firmware load for
iwlwifi-7265D-19.ucode failed with error -2
[    2.946271] iwlwifi 0000:02:00.0: Direct firmware load for
iwlwifi-7265D-18.ucode failed with error -2
[    2.946275] iwlwifi 0000:02:00.0: Direct firmware load for
iwlwifi-7265D-17.ucode failed with error -2
[    2.946532] iwlwifi 0000:02:00.0: Unsupported splx structure
[    2.949045] iwlwifi 0000:02:00.0: loaded firmware version
16.242414.0 op_mode iwlmvm
[    2.956321] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band
Wireless AC 7265, REV=0x210
[    2.956644] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    2.957085] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    2.979959] input: PC Speaker as /devices/platform/pcspkr/input/input9
[    2.980690] Error: Driver 'pcspkr' is already registered, aborting...
[    2.984757] FAT-fs (nvme0n1p1): utf8 is not a recommended IO
charset for FAT filesystems, filesystem will be case sensitive!
[    3.025256] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    3.046341] AVX2 version of gcm_enc/dec engaged.
[    3.046343] AES CTR mode by8 optimization enabled
[    3.072756] kvm: disabled by bios
[    3.082766] Bluetooth: hci0: Intel Bluetooth firmware patch
completed and activated
[    3.144395] intel_rapl: Found RAPL domain package
[    3.144397] intel_rapl: Found RAPL domain core
[    3.144399] intel_rapl: Found RAPL domain uncore
[    3.144400] intel_rapl: Found RAPL domain dram
[    3.145608] kvm: disabled by bios
[    3.188612] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    3.188612] fbcon: inteldrmfb (fb0) is primary device
[    3.204395] random: nonblocking pool is initialized
[    3.217068] kvm: disabled by bios
[    3.217087] snd_hda_codec_conexant hdaudioC0D0: CX20724: BIOS auto-probing.
[    3.217590] snd_hda_codec_conexant hdaudioC0D0: autoconfig for
CX20724: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    3.217591] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    3.217592] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[    3.217593] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    3.217594] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    3.217595] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[    3.217596] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[    3.218722] snd_hda_codec_conexant hdaudioC0D0: Enable sync_write
for stable communication
[    3.227240] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    3.227747] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    3.227782] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    3.227814] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    3.227847] input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    3.227880] input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    3.285302] ACPI: Battery Slot [BAT0] (battery present)
[    3.285591] wmi: Mapper loaded
[    3.350850] Adding 31248380k swap on /dev/mapper/gladys--vg-swap.
Priority:-1 extents:1 across:31248380k SSFS
[    3.353470] iwlwifi 0000:02:00.0 wlo1: renamed from wlan0
[    3.362284] input: ELAN Touchscreen Pen as
/devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:04F3:2072.0007/input/input16
[    3.362553] input: ELAN Touchscreen as
/devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:04F3:2072.0007/input/input17
[    3.362949] hid-multitouch 0003:04F3:2072.0007:
input,hiddev0,hidraw0: USB HID v1.10 Keyboard [ELAN Touchscreen] on
usb-0000:00:14.0-8/input0
[    3.369587] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[    3.379530] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
size 160 (bits) (20160108/dsopcode-236)
[    3.379534] ACPI Error: Method parse/execution failed [\HWMC] (Node
ffff8804630e4c58), AE_AML_BUFFER_LIMIT (20160108/psparse-542)
[    3.379540] ACPI Error: Method parse/execution failed
[\_SB.WMID.WMAA] (Node ffff8804630e5b18), AE_AML_BUFFER_LIMIT
(20160108/psparse-542)
[    3.379579] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
size 160 (bits) (20160108/dsopcode-236)
[    3.379582] ACPI Error: Method parse/execution failed [\HWMC] (Node
ffff8804630e4c58), AE_AML_BUFFER_LIMIT (20160108/psparse-542)
[    3.379587] ACPI Error: Method parse/execution failed
[\_SB.WMID.WMAA] (Node ffff8804630e5b18), AE_AML_BUFFER_LIMIT
(20160108/psparse-542)
[    3.379621] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
size 160 (bits) (20160108/dsopcode-236)
[    3.379623] ACPI Error: Method parse/execution failed [\HWMC] (Node
ffff8804630e4c58), AE_AML_BUFFER_LIMIT (20160108/psparse-542)
[    3.379628] ACPI Error: Method parse/execution failed
[\_SB.WMID.WMAA] (Node ffff8804630e5b18), AE_AML_BUFFER_LIMIT
(20160108/psparse-542)
[    3.379683] input: HP WMI hotkeys as /devices/virtual/input/input19
[    3.380272] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
size 160 (bits) (20160108/dsopcode-236)
[    3.380275] ACPI Error: Method parse/execution failed [\HWMC] (Node
ffff8804630e4c58), AE_AML_BUFFER_LIMIT (20160108/psparse-542)
[    3.380281] ACPI Error: Method parse/execution failed
[\_SB.WMID.WMAA] (Node ffff8804630e5b18), AE_AML_BUFFER_LIMIT
(20160108/psparse-542)
[    3.380317] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
size 160 (bits) (20160108/dsopcode-236)
[    3.380320] ACPI Error: Method parse/execution failed [\HWMC] (Node
ffff8804630e4c58), AE_AML_BUFFER_LIMIT (20160108/psparse-542)
[    3.380324] ACPI Error: Method parse/execution failed
[\_SB.WMID.WMAA] (Node ffff8804630e5b18), AE_AML_BUFFER_LIMIT
(20160108/psparse-542)
[    3.600258] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    3.600259] Bluetooth: BNEP filters: protocol multicast
[    3.600262] Bluetooth: BNEP socket layer initialized
[    3.890655] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.895545] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    3.905164] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    4.000110] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[    4.000462] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    4.000902] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    4.063035] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    4.063481] iwlwifi 0000:02:00.0: L1 Enabled - LTR Enabled
[    4.096171] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[    4.180680] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[    4.636315] Console: switching to colour frame buffer device 320x90
[    4.646341] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    4.795916] [drm] RC6 on
[    5.996168] Bluetooth: RFCOMM TTY layer initialized
[    5.996181] Bluetooth: RFCOMM socket layer initialized
[    5.996192] Bluetooth: RFCOMM ver 1.11
[    7.570966] wlo1: authenticate with 00:ac:54:f1:87:02
[    7.576337] wlo1: send auth to 00:ac:54:f1:87:02 (try 1/3)
[    7.579363] wlo1: authenticated
[    7.579770] wlo1: associate with 00:ac:54:f1:87:02 (try 1/3)
[    7.584033] wlo1: RX AssocResp from 00:ac:54:f1:87:02 (capab=0x431
status=0 aid=5)
[    7.585967] wlo1: associated
[    7.586012] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[   20.124184] usb 1-3: new high-speed USB device number 5 using xhci_hcd
[   20.310459] usb 1-3: New USB device found, idVendor=05e3, idProduct=0610
[   20.310467] usb 1-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   20.310472] usb 1-3: Product: USB2.0 Hub
[   20.311423] hub 1-3:1.0: USB hub found
[   20.311733] hub 1-3:1.0: 4 ports detected
[   20.584205] usb 1-3.1: new high-speed USB device number 6 using xhci_hcd
[   20.674490] usb 1-3.1: New USB device found, idVendor=05e3, idProduct=0610
[   20.674498] usb 1-3.1: New USB device strings: Mfr=0, Product=1,
SerialNumber=0
[   20.674502] usb 1-3.1: Product: USB2.0 Hub
[   20.675491] hub 1-3.1:1.0: USB hub found
[   20.675774] hub 1-3.1:1.0: 4 ports detected
[   20.748195] usb 1-3.2: new low-speed USB device number 7 using xhci_hcd
[   20.820235] usb 1-3.2: device descriptor read/64, error -32
[   20.996233] usb 1-3.2: device descriptor read/64, error -32
[   21.172205] usb 1-3.2: new low-speed USB device number 8 using xhci_hcd
[   21.244244] usb 1-3.2: device descriptor read/64, error -32
[   21.420239] usb 1-3.2: device descriptor read/64, error -32
[   21.596206] usb 1-3.2: new low-speed USB device number 9 using xhci_hcd
[   21.596841] usb 1-3.2: Device not responding to setup address.
[   21.800847] usb 1-3.2: Device not responding to setup address.
[   22.004207] usb 1-3.2: device not accepting address 9, error -71
[   22.076226] usb 1-3.2: new low-speed USB device number 10 using xhci_hcd
[   22.076868] usb 1-3.2: Device not responding to setup address.
[   22.280846] usb 1-3.2: Device not responding to setup address.
[   22.484225] usb 1-3.2: device not accepting address 10, error -71
[   22.484683] usb 1-3-port2: unable to enumerate USB device
[   22.556230] usb 1-3.3: new full-speed USB device number 11 using xhci_hcd
[   22.649881] usb 1-3.3: New USB device found, idVendor=03f0, idProduct=d407
[   22.649888] usb 1-3.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[   22.649892] usb 1-3.3: Product: HP Link-5 Micro Receiver
[   22.649895] usb 1-3.3: Manufacturer: HP
[   22.653118] input: HP HP Link-5 Micro Receiver as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.3/1-3.3:1.0/0003:03F0:D407.0008/input/input20
[   22.708826] hid-generic 0003:03F0:D407.0008: input,hidraw1: USB HID
v1.11 Keyboard [HP HP Link-5 Micro Receiver] on
usb-0000:00:14.0-3.3/input0
[   22.713335] input: HP HP Link-5 Micro Receiver as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.3/1-3.3:1.1/0003:03F0:D407.0009/input/input21
[   22.768737] hid-generic 0003:03F0:D407.0009: input,hiddev0,hidraw2:
USB HID v1.11 Mouse [HP HP Link-5 Micro Receiver] on
usb-0000:00:14.0-3.3/input1
[   44.945907] fuse init (API version 7.24)
