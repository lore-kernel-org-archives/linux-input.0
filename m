From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory
 error path
Date: Thu, 5 Apr 2018 01:34:26 +0000
Message-ID: <DM5PR2101MB103205963461FF9EE6FDC1EDFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <Alexander.Levin@microsoft.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Christophe JAILLET.

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 7.5278)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Failed to apply! Possible dependencies:
    8d99758dee31: ("Input: synaptics-rmi4 - add SPI transport driver")
    ff8f83708b3e: ("Input: synaptics-rmi4 - add support for 2D sensors and =
F11")
    fdf51604f104: ("Input: synaptics-rmi4 - add I2C transport driver")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")
    fdf51604f104: ("Input: synaptics-rmi4 - add I2C transport driver")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks.
Sasha=
