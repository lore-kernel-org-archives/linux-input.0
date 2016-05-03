From: Ben Gamari <ben@smart-cactus.org>
Subject: Dell Latitude E7470 touchpad status
Date: Tue, 03 May 2016 15:31:24 +0200
Message-ID: <87eg9j6zf7.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:55626 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbcECNjq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 09:39:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>, Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hello Dell kernel people,

I recently started using a Latitude E7470 (with BIOS version 1.4.2) as
my primary machine and have found that the touchpad seems to come up as
a standard emulated PS/2 device.

    input: ImPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input6

Sadly simply blacklisting psmouse doesn't resolve this. I found this
rather surprising for this to be the case with such modern hardware and
have grown used to having a functional touchpad so I started to do some
digging.

I started by dumping the machine's DSDT [1] to find that the touchpad's
I2C interface appears to be conditional [2] on some embedded controller
state exposed to the system via the SDS0 field of the GNVS OpRegion
(which appears to be 0 on my system).

I have verified the values of OSYS (which is 0x07df on my machine) and
SDM0 (which is 0x1), so SDS0 seems as though the only remaining barrier
to having the i2c-hid touchpad properly exposed in the ACPI tables is
SDS0.

So, does anyone know what might influence the value of SDS0 provided by
the EC? Any help would be greatly appreciated.

Cheers,

- Ben



[1] https://github.com/bgamari/dell-e7470-dsdt

[2] _INI method for the TPD0:

    Method (_INI, 0, NotSerialized)  // _INI: Initialize
    {
        // Verify that we have at least Windows 2012
        If ((OSYS < 0x07DC))    // OSYS == 0x07df on my machine
        {
            SRXO (GPDI, One)
        }

        // GPIO number and interrupt number of GPDI pin?
        INT1 = GNUM (GPDI)
        INT2 = INUM (GPDI)

        If ((SDM0 == Zero))     // SDM0 == 1 on my machine
        {
            SHPO (GPDI, One)
        }

        If ((SDS0 == One))      // SDS0 == 0 on my machine
        {
            _HID = "SYNA2393"   // I guess this is some Synaptics touchpad?
            HID2 = 0x20
            Return (Zero)
        }

        If ((SDS0 == 0x02))
        {
            _HID = "06CB2846"   // Some other vendor's touchpad?
            HID2 = 0x20
            Return (Zero)
        }

        If ((SDS0 == 0x05))
        {
            _HID = "CUST0001"   // ???
            HID2 = TPDH /* \TPDH */
            BADR = TPDB /* \TPDB */
            If ((TPDS == Zero))
            {
                SPED = 0x000186A0
            }

            If ((TPDS == One))
            {
                SPED = 0x00061A80
            }

            If ((TPDS == 0x02))
            {
                SPED = 0x000F4240
            }

            Return (Zero)
        }
        // DSDT bug: Seems like this really ought to return a value since
        // otherwise the specification defines the behavior is undefined
    }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKKgsAAoJEHPt6ejPuu8B6QYH/3dZckWYv1Q2cRHllcqKx2LB
6mt0gS4eB5uW7VC1ga+mVIJsZCP9P0CDnXP4/auqxobUFUxW5NdRxC3vEwLIw0jB
jqo2DYbSySlcY0TLRyoUnhD8vOTEpHiFdFuyfKYuXnG7zJmR3kSW4STg4OVgAu+o
0jn2Ld/wf2YqPYQhGRCcubnZQv4QW/65AIFx1RToVQEQkYI5SwPxWTYlFsW8I134
Tg/EUivj4XY2XIZbQC7BuZrQJbk0uFWU+RSoxanjn/9it12DdlcUaHZzS6zjjJLF
wds1zwR+U0JDa4MUSdjxc85yGVb9dHgEmDlElkJb9CCp2Fa7M1SdKThu9Qfy9Xg=
=IWHH
-----END PGP SIGNATURE-----
--=-=-=--
