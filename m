From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add support for Google Pixel
 2
Date: Wed, 15 Apr 2015 17:20:21 -0400
Message-ID: <552ED615.5020301@gmail.com>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com> <552E8A8C.6000900@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vn0-f48.google.com ([209.85.216.48]:43494 "EHLO
	mail-vn0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbbDOVUX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 17:20:23 -0400
In-Reply-To: <552E8A8C.6000900@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Olof Johansson <olof@lixom.net>

Hi guys,

On Wed, Apr 15, 2015 at 11:58 AM, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> Hello Dmitry,
>
> On 04/08/2015 02:26 AM, Dmitry Torokhov wrote:
>> This change allows atmel_mxt_ts to bind to ACPI-enumerated devices in
>> Google Pixel 2 (2015).
>>
>> While newer version of ACPI standard allow use of device-tree-like
>> properties in device descriptions, the version of ACPI implemented in
>> Google BIOS does not support them, and we have to resort to DMI data to
>> specify exact characteristics of the devices (touchpad vs. touchscreen,
>> GPIO to button mapping, etc).
>>
>> Pixel 1 continues to use i2c devices and platform data created by
>> chromeos-laptop driver, since ACPI does not enumerate them.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
[snipped]
>
> Patch looks good to me and I've tested it in a Pixel2 Chromebook using
> evtest:
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>

Hmm, this is weird. I tried to apply the 2 patches of this series to a 
4.0 fedora kernel[1], and the touch{pad|screen} are desperately muted. 
The abs_X/Y max shows up as 0, so there is something wrong with either 
my touchpad (which works fine on ChromeOS) or with the driver.
There are no differences between 4.0-rcX and the final 4.0 so I suspect 
there must be something else.
I also copied the 2 samus-* config files from the ChromeOS root to
/lib/firmware but this does not change anything.

In [3], I enabled the debug output of atmel_mxt, and it seems that the 
table of functions is missing the T9 one, which is the multitouch one... :(

Any help would be greatly appreciated so we can fix [2] and support 
those laptops in Fedora directly.

Cheers,
Benjamin


[1] http://koji.fedoraproject.org/koji/taskinfo?taskID=9490910
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1209088
[3] dmesg output with debug:

[ 1988.789927] atmel_mxt_ts i2c-ATML0000:01: T37 Start:202 Size:130 Instances:1 Report IDs:0-0
[ 1988.789937] atmel_mxt_ts i2c-ATML0000:01: T44 Start:332 Size:1 Instances:1 Report IDs:0-0
[ 1988.789943] atmel_mxt_ts i2c-ATML0000:01: T5 Start:333 Size:11 Instances:1 Report IDs:0-0
[ 1988.789947] atmel_mxt_ts i2c-ATML0000:01: T6 Start:344 Size:7 Instances:1 Report IDs:1-1
[ 1988.789952] atmel_mxt_ts i2c-ATML0000:01: T38 Start:351 Size:64 Instances:1 Report IDs:0-0
[ 1988.789956] atmel_mxt_ts i2c-ATML0000:01: T71 Start:415 Size:200 Instances:1 Report IDs:0-0
[ 1988.789961] atmel_mxt_ts i2c-ATML0000:01: T110 Start:615 Size:28 Instances:9 Report IDs:0-0
[ 1988.789965] atmel_mxt_ts i2c-ATML0000:01: T7 Start:867 Size:5 Instances:1 Report IDs:0-0
[ 1988.789969] atmel_mxt_ts i2c-ATML0000:01: T8 Start:872 Size:15 Instances:1 Report IDs:0-0
[ 1988.789973] atmel_mxt_ts i2c-ATML0000:01: T15 Start:887 Size:11 Instances:1 Report IDs:2-2
[ 1988.789978] atmel_mxt_ts i2c-ATML0000:01: T18 Start:898 Size:2 Instances:1 Report IDs:0-0
[ 1988.789982] atmel_mxt_ts i2c-ATML0000:01: T19 Start:900 Size:6 Instances:1 Report IDs:3-3
[ 1988.789986] atmel_mxt_ts i2c-ATML0000:01: T25 Start:906 Size:15 Instances:1 Report IDs:4-4
[ 1988.789991] atmel_mxt_ts i2c-ATML0000:01: T42 Start:921 Size:13 Instances:1 Report IDs:0-0
[ 1988.789995] atmel_mxt_ts i2c-ATML0000:01: T46 Start:934 Size:12 Instances:1 Report IDs:5-5
[ 1988.789999] atmel_mxt_ts i2c-ATML0000:01: T47 Start:946 Size:40 Instances:1 Report IDs:0-0
[ 1988.790004] atmel_mxt_ts i2c-ATML0000:01: T56 Start:986 Size:28 Instances:1 Report IDs:6-6
[ 1988.790009] atmel_mxt_ts i2c-ATML0000:01: T61 Start:1014 Size:5 Instances:6 Report IDs:7-12
[ 1988.790013] atmel_mxt_ts i2c-ATML0000:01: T65 Start:1044 Size:23 Instances:3 Report IDs:13-15
[ 1988.790018] atmel_mxt_ts i2c-ATML0000:01: T70 Start:1113 Size:10 Instances:20 Report IDs:16-35
[ 1988.790022] atmel_mxt_ts i2c-ATML0000:01: T72 Start:1313 Size:85 Instances:1 Report IDs:36-36
[ 1988.790027] atmel_mxt_ts i2c-ATML0000:01: T77 Start:1398 Size:2 Instances:1 Report IDs:0-0
[ 1988.790031] atmel_mxt_ts i2c-ATML0000:01: T78 Start:1400 Size:12 Instances:1 Report IDs:0-0
[ 1988.790035] atmel_mxt_ts i2c-ATML0000:01: T80 Start:1412 Size:11 Instances:1 Report IDs:37-37
[ 1988.790040] atmel_mxt_ts i2c-ATML0000:01: T100 Start:1423 Size:60 Instances:1 Report IDs:38-49
[ 1988.790044] atmel_mxt_ts i2c-ATML0000:01: T101 Start:1483 Size:30 Instances:1 Report IDs:0-0
[ 1988.790048] atmel_mxt_ts i2c-ATML0000:01: T104 Start:1513 Size:11 Instances:1 Report IDs:0-0
[ 1988.790053] atmel_mxt_ts i2c-ATML0000:01: T108 Start:1524 Size:75 Instances:1 Report IDs:50-50
[ 1988.790058] atmel_mxt_ts i2c-ATML0000:01: T109 Start:1599 Size:9 Instances:1 Report IDs:51-51
[ 1988.790062] atmel_mxt_ts i2c-ATML0000:01: T111 Start:1608 Size:23 Instances:3 Report IDs:0-0
[ 1988.790066] atmel_mxt_ts i2c-ATML0000:01: T112 Start:1677 Size:5 Instances:2 Report IDs:52-53
[ 1988.790071] atmel_mxt_ts i2c-ATML0000:01: T113 Start:1687 Size:3 Instances:1 Report IDs:0-0
[ 1988.806017] atmel_mxt_ts i2c-ATML0000:01: message: 28 94 97 01 60 01 01 24 04 4b
[ 1988.806021] atmel_mxt_ts i2c-ATML0000:01: message: 29 49 44 02 f0 00 02 00 00 00
[ 1988.806023] atmel_mxt_ts i2c-ATML0000:01: message: 2a 19 b4 01 ae 01 00 2a 03 5e
[ 1988.806024] atmel_mxt_ts i2c-ATML0000:01: message: 2b 49 4b 02 47 01 02 00 00 00
[ 1988.806025] atmel_mxt_ts i2c-ATML0000:01: message: 28 15 e9 01 91 01 00 14 01 29
[ 1988.808689] atmel_mxt_ts i2c-ATML0000:01: T6 Config Checksum: 0x81161B
[ 1988.814052] atmel_mxt_ts i2c-ATML0000:01: message: 03 0e 00 00 00 00 00 00 00 00
[ 1988.814059] atmel_mxt_ts i2c-ATML0000:01: message: 04 00 00 00 00 00 00 00 00 00
[ 1988.814061] atmel_mxt_ts i2c-ATML0000:01: message: 05 00 00 00 00 00 00 00 00 00
[ 1988.814063] atmel_mxt_ts i2c-ATML0000:01: message: 26 00 00 00 00 00 00 00 00 00
[ 1988.814065] atmel_mxt_ts i2c-ATML0000:01: message: 27 00 00 00 00 00 00 00 00 00
[ 1988.814067] atmel_mxt_ts i2c-ATML0000:01: message: 28 15 e9 01 91 01 00 14 01 29
[ 1988.814070] atmel_mxt_ts i2c-ATML0000:01: message: 29 49 44 02 f0 00 02 00 00 00
[ 1988.814072] atmel_mxt_ts i2c-ATML0000:01: message: 2a 19 b4 01 ae 01 00 2a 03 5e
[ 1988.814073] atmel_mxt_ts i2c-ATML0000:01: message: 2b 49 4b 02 47 01 02 00 00 00
[ 1988.814075] atmel_mxt_ts i2c-ATML0000:01: message: 2c 00 00 00 00 00 00 00 00 00
[ 1988.814077] atmel_mxt_ts i2c-ATML0000:01: message: 2d 00 00 00 00 00 00 00 00 00
[ 1988.814079] atmel_mxt_ts i2c-ATML0000:01: message: 2e 00 00 00 00 00 00 00 00 00
[ 1988.814081] atmel_mxt_ts i2c-ATML0000:01: message: 2f 00 00 00 00 00 00 00 00 00
[ 1988.814083] atmel_mxt_ts i2c-ATML0000:01: message: 30 00 00 00 00 00 00 00 00 00
[ 1988.814085] atmel_mxt_ts i2c-ATML0000:01: message: 31 00 00 00 00 00 00 00 00 00
[ 1988.814087] atmel_mxt_ts i2c-ATML0000:01: message: 33 05 00 00 00 00 00 00 00 00
[ 1988.814546] atmel_mxt_ts i2c-ATML0000:01: Interrupt triggered but zero messages
[ 1988.828014] atmel_mxt_ts i2c-ATML0000:01: Warning: Info CRC error - device=0x000000 file=0xFE0A28
[ 1988.828104] atmel_mxt_ts i2c-ATML0000:01: Config CRC error, calculated=8824C9, file=81161B
[ 1988.880438] atmel_mxt_ts i2c-ATML0000:01: T6 Config Checksum: 0x81161B
[ 1988.888101] atmel_mxt_ts i2c-ATML0000:01: Resetting chip
[ 1988.985130] atmel_mxt_ts i2c-ATML0000:01: T6 Status 0x80 RESET
[ 1988.985133] atmel_mxt_ts i2c-ATML0000:01: Config successfully updated
[ 1988.985135] atmel_mxt_ts i2c-ATML0000:01: Invalid object type T9
[ 1988.985137] atmel_mxt_ts i2c-ATML0000:01: Failed to initialize T9 resolution
[ 1988.985209] input: Atmel maXTouch Touchpad as /devices/pci0000:00/INT3432:00/i2c-9/i2c-ATML0000:01/input/input17
[ 1988.986334] atmel_mxt_ts i2c-ATML0000:01: message: 03 0e 00 00 00 00 00 00 00 00
[ 1988.986338] atmel_mxt_ts i2c-ATML0000:01: T6 Status 0x10 CAL
[ 1988.986487] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0.AA Objects: 32
[ 1988.987310] atmel_mxt_ts i2c-ATML0000:01: Interrupt triggered but zero messages
[ 1988.988097] atmel_mxt_ts i2c-ATML0000:01: Invalid object type T9
[ 1989.002500] atmel_mxt_ts i2c-ATML0000:01: Invalid object type T9
[ 1989.014274] atmel_mxt_ts i2c-ATML0000:01: Invalid object type T9
[ 1989.075055] atmel_mxt_ts i2c-ATML0000:01: T6 Status 0x00 OK
[ 2378.845942] atmel_mxt_ts i2c-ATML0000:01: message: 28 c4 2f 00 26 00 07 00 00 00
[ 2378.855751] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 07 00 00 00
[ 2378.865445] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 07 00 00 00
[ 2378.875318] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 06 00 00 00
[ 2378.885024] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 06 00 00 00
[ 2378.894862] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 05 00 00 00
[ 2378.904413] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 05 00 00 00
[ 2378.914256] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 04 00 00 00
[ 2378.923926] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 03 00 00 00
[ 2378.933790] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 03 00 00 00
[ 2378.943454] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 03 00 00 00
[ 2378.953318] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 02 00 00 00
[ 2378.962950] atmel_mxt_ts i2c-ATML0000:01: message: 28 c0 2f 00 26 00 02 00 00 00
... lots of interrupt messages when I have my finger hovering or touching the touchpad.

