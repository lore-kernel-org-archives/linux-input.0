From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 3/3] Blackfin serial driver: this driver enable SPORTs on Blackfin emulate UART
Date: Mon, 15 Oct 2007 18:10:02 -0400
Message-ID: <200710151810.02291.rgetz@blackfin.uclinux.org>
References: <1192098220-25828-1-git-send-email-bryan.wu@analog.com> <1192098220-25828-4-git-send-email-bryan.wu@analog.com> <20071015133326.995a4f38.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751926AbXJOWJW@vger.kernel.org>
In-Reply-To: <20071015133326.995a4f38.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bryan Wu <bryan.wu@analog.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon 15 Oct 2007 16:33, Andrew Morton pondered:
>=20
> > Subject: [PATCH 3/3] Blackfin serial driver: this driver enable SPO=
RTs
> on Blackfin emulate UART
>=20
> That's a bit hard to parse.
>=20

Blackfin's have a synchronous Serial Peripheral pORT (SPORT).=20

Unlike SPI, UART, I2C, or CAN interfaces which are designed for specifi=
c=20
industry standard compatible communication only, the SPORT support a va=
riety=20
(software programmable) serial data communication protocols:
 - A-law or =C2=B5-law companding according to G.711 specification
 - Multichannel or Time-Division-Multiplexed (TDM) modes
 - Stereo Audio I2S Mode
 - TDM Modes for Multi-Channel audio codecs
 - H.100 Telephony standard support
 - others, but if anyone really cares, they need to read the chip specs=
=2E..

Bryan's patch takes the SPORT, and makes a standard UART out of it=20
(exposing /dev/ttySS0) for those people who don't have enough hardware =
UARTs=20
in their system.

Is it a SPORT driver that emulates a UART, or a UART driver on the SPOR=
T? I=20
think it is the latter...

Maybe:

[PATCH 3/3] Blackfin serial driver: enables a UART interface for the SP=
ORT


Which still doesn't make any sense, until you know what a SPORT is :)

-Robin
