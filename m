From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: Re: edt-ft5x06 question
Date: Wed, 15 Nov 2017 17:30:32 +0100
Message-ID: <49b16b2c-772d-b9d6-993a-063c41e46200@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, luca@lucaceresoli.net, simon.budig@kernelconcepts.de, martink@posteo.de, a.mathur@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Luca,

I had problems with e-mail filter, so I rebuilt yours by hand.
Forgive me.

See below.

Thanks
Kind regards

 > Hi Giulio,
 >
 > On 14/11/2017 22:42, Giulio Benetti wrote:
 > > Hello everybody,
 > >
 > > I'm using ft5206 with edt-ft5x06.c driver,
 > > but what I see is that registers with M09 or M06
 > > seem different from focaltech ft5206
 > > https://www.buydisplay.com/download/ic/FT5206.pdf
 > >
 > > For example, except address 0x80 for threshold register(thgroup),
 > > all the others don't appear:
 > > GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)
 > >
 > > Can someone clarify this?
 >
 > Are you having any problems, or just investigating?

I need to add some other IC register to calibrate sensibility with 
different glasses, but starting from ft5x06 or other Focaltech standard 
IC FW.

 >
 > > Maybe M06 or M09 are a custom firmware for focaltech ft5x,
 > > then it has different registers?
 >
 > All the FT5x06 are 8051-based chips designed to implement touchscreen
 > controllers. The FT5x26 are similar but with a more powerful core
 > (Cortex-M IIRC).
 >
 > As far as I could understand and guess, their register interface is
 > fully implemented in firmware, so it could change completely from one
 > panel to another. However all panels that I have seen seem to use
 > firmwares with either the "M06" or the "M09" protocol, which are
 > implemented in the Linux driver.

In my case driver recognizes M09, but only address 0x80 
register(thgroup) is correct.
The others:
GAIN: 0x92
GAIN: 0x93
GAIN: 0x94
GAIN: 0x95

are not described in that datasheet.
The point is that datasheet seems to be official by Focaltech,
like if they deliver that IC with a standard FW inside.
I can't find a way to safely probe if it's a standard FW or from EDT M09 
or M06.
I wouldn't write a different driver ft5x.c because it's a repeatition,
but EDT seems a special version(FW) of ft5x.

Maybe on dt-bindings I could force to be EDT or standard.
On legacy sunxi-3.4 the driver handled this as datasheet I mentioned.
What do you think?

 >
 > The driver also performs some checks to understand which of the two
 > protocols is implemented by the controller. These checks are quite
 > horrible, but they worked for me.

I have FW with registers as described at 
https://www.buydisplay.com/download/ic/FT5206.pdf
and I would like to add them as attributes more and dt-bindings to 
improve trimming.
I would call those registers the same as manual:
THGROUP
THCAL
etc.

And I would also like to add a tasklet that recalibrate every 
minute(specified by attr or dt-binding).
I want to do this(already done succesfully on 3.4) because I've 
experienced problems on temperature and mechanical drifts.

 >
 > The best thing is that you ask a datasheet to your supplier, in order to
 > make sure about the protocol and avoid guessing.
 >
 > Regards,
 > --
 > Luca


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
