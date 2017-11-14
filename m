From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: edt-ft5x06 question
Date: Tue, 14 Nov 2017 22:42:27 +0100
Message-ID: <9036109f-ae02-01de-77a7-13442e3d9e53@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: it
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, luca@lucaceresoli.net, simon.budig@kernelconcepts.de, martink@posteo.de, a.mathur@samsung.com
List-Id: linux-input@vger.kernel.org

Hello everybody,

I'm using ft5206 with edt-ft5x06.c driver,
but what I see is that registers with M09 or M06
seem different from focaltech ft5206 
https://www.buydisplay.com/download/ic/FT5206.pdf

For example, except address 0x80 for threshold register(thgroup),
all the others don't appear:
GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)

Can someone clarify this?

Maybe M06 or M09 are a custom firmware for focaltech ft5x,
then it has different registers?

Thanks in advance and
kind regards to everybody

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
