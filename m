From: simon@mungewell.org
Subject: Re: Sony DualShock4 - basic functions work, but looking to improve
 support
Date: Sun, 8 Dec 2013 19:51:53 -0500
Message-ID: <a26fde1f94cf430dd54a5045f82ac260.squirrel@mungewell.org>
References: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131208195152_10705"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:37159 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab3LIAvz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Dec 2013 19:51:55 -0500
In-Reply-To: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Linux Input <linux-input@vger.kernel.org>, Antonio Ospite <ospite@studenti.unina.it>

------=_20131208195152_10705
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Following a very useful post on Reddit:
http://np.reddit.com/r/PS4/comments/1p9y0l/pairing_your_ds4_controller_via_bluetooth/

I was able to put the DS4 into discoverable mode, pair and connect using
the 'hidd --connect 1C:66:6D:07:C3:E0' to get a working wireless/BT
joystick.

discoverable - hold 'PS' and 'Share' until light bar fast strobes.
connected - light bar turns on constant.
turn device off - hold 'PS' until light bar turns off.

Not sure why, but under a bluetooth connection the 'hidraw0' device only
outputs the first 10 bytes (compared to 64 bytes with USB connection)
--
$ hexdump -v -e '10/1 "%02x " "\n"' < /dev/hidraw0
01 7d 7e 82 7e 08 00 00 00 00
01 7d 7e 83 7e 08 00 00 00 00
01 7d 7e 81 7e 08 00 00 00 00
01 7d 7e 82 7e 08 00 00 00 00
01 7d 7e 80 7f 08 00 00 00 00
--

Attached are some bluetooth details for the device. No idea on how to get
audio to/from the device - I was kind of hoping it would behave like a BT
headset.
Simon
------=_20131208195152_10705
Content-Type: text/plain; name="hcitool_info.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="hcitool_info.txt"

simon@womble:~$ hcitool info 1C:66:6D:07:C3:E0
Requesting information ...
	BD Address:  1C:66:6D:07:C3:E0
	Device Name: Wireless Controller
	LMP Version: 3.0 (0x5) LMP Subversion: 0x0
	Manufacturer: Atheros Communications, Inc. (69)
	Features: 0xff 0xfe 0x0d 0xfe 0x98 0x7f 0x79 0x87
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
		<transparent SCO> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> 
		<enhanced iscan> <interlaced iscan> <interlaced pscan> 
		<inquiry with RSSI> <extended SCO> <AFH cap. slave> 
		<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
		<sniff subrating> <pause encryption> <AFH cap. master> 
		<AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps> 
		<extended inquiry> <simple pairing> <encapsulated PDU> 
		<err. data report> <non-flush flag> <LSTO> <inquiry TX power> 
		<EPC> <extended features> 
------=_20131208195152_10705
Content-Type: text/plain; name="sdptool_records.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="sdptool_records.txt"

simon@womble:~/dualshock4$ sdptool records 1C:66:6D:07:C3:E0
Service Name: Wireless Controller
Service Description: Game Controller
Service Provider: Sony Computer Entertainment
Service RecHandle: 0x10001
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

Service RecHandle: 0x10002
Service Class ID List:
  "PnP Information" (0x1200)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Profile Descriptor List:
  "PnP Information" (0x1200)
    Version: 0x0103


------=_20131208195152_10705--


