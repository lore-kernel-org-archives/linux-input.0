From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Sony DualShock4 - basic functions work, but looking to improve support
Date: Mon, 9 Dec 2013 10:05:59 +0100
Message-ID: <CANq1E4Q=4DEDFibVtifMVE-2wq7Bt0KOPRRE5nFy9Hu-tgy_Cg@mail.gmail.com>
References: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
	<a26fde1f94cf430dd54a5045f82ac260.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64319 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760751Ab3LIJF7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 04:05:59 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so5430932iec.7
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 01:05:59 -0800 (PST)
In-Reply-To: <a26fde1f94cf430dd54a5045f82ac260.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Antonio Ospite <ospite@studenti.unina.it>

Hi

On Mon, Dec 9, 2013 at 1:51 AM,  <simon@mungewell.org> wrote:
> Following a very useful post on Reddit:
> http://np.reddit.com/r/PS4/comments/1p9y0l/pairing_your_ds4_controller_via_bluetooth/
>
> I was able to put the DS4 into discoverable mode, pair and connect using
> the 'hidd --connect 1C:66:6D:07:C3:E0' to get a working wireless/BT
> joystick.
>
> discoverable - hold 'PS' and 'Share' until light bar fast strobes.
> connected - light bar turns on constant.
> turn device off - hold 'PS' until light bar turns off.
>
> Not sure why, but under a bluetooth connection the 'hidraw0' device only
> outputs the first 10 bytes (compared to 64 bytes with USB connection)
> --
> $ hexdump -v -e '10/1 "%02x " "\n"' < /dev/hidraw0
> 01 7d 7e 82 7e 08 00 00 00 00
> 01 7d 7e 83 7e 08 00 00 00 00
> 01 7d 7e 81 7e 08 00 00 00 00
> 01 7d 7e 82 7e 08 00 00 00 00
> 01 7d 7e 80 7f 08 00 00 00 00
> --
>
> Attached are some bluetooth details for the device. No idea on how to get
> audio to/from the device - I was kind of hoping it would behave like a BT
> headset.

Regarding Bluetooth: hidd is deprecated. It should be all handled by
bluetoothd now. But once it's connected, HIDP is handled by the kernel
so this shouldn't be an issue here.

The SDP/hcitool information are pretty sparse so they won't help much.
All they tell is that the device uses HIDP (and a bit about BT
internals). No A2DP or alike. I guess sound is transmitted through the
HIDP channel (which is also what the wiimote does) and allows the same
transmission via USB and BT.

The report descriptor actually describes a lot more report-IDs than
just "0x01" which you describe in hidraw.txt. Are you sure the
report-descriptors are the same for USB and BT? 64bytes also seems
quite large for HID reports, I thought BT had a limit of 22 (but I'm
not sure). At least your report-descriptor says the biggest report is
63 bytes so that seems to be right for USB at least. You could turn on
BT debugging, the HIDP layer will then print size/content information
for incoming L2CAP skbs. This should help finding the culprit.

Thanks
David
