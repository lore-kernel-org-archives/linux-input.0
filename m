From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: edt-ft5x06 question
Date: Fri, 17 Nov 2017 18:16:34 +0100
Message-ID: <2352100a-db85-e469-95b1-02d9180aba41@lucaceresoli.net>
References: <49b16b2c-772d-b9d6-993a-063c41e46200@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:45140 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdKQRQj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 12:16:39 -0500
In-Reply-To: <49b16b2c-772d-b9d6-993a-063c41e46200@micronovasrl.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, simon.budig@kernelconcepts.de, martink@posteo.de, a.mathur@samsung.com

Hi Giulio,

On 15/11/2017 17:30, Giulio Benetti wrote:
> Hi Luca,
> 
> I had problems with e-mail filter, so I rebuilt yours by hand.
> Forgive me.
> 
> See below.
> 
> Thanks
> Kind regards
> 
>> Hi Giulio,
>>
>> On 14/11/2017 22:42, Giulio Benetti wrote:
>> > Hello everybody,
>> >
>> > I'm using ft5206 with edt-ft5x06.c driver,
>> > but what I see is that registers with M09 or M06
>> > seem different from focaltech ft5206
>> > https://www.buydisplay.com/download/ic/FT5206.pdf
>> >
>> > For example, except address 0x80 for threshold register(thgroup),
>> > all the others don't appear:
>> > GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)
>> >
>> > Can someone clarify this?
>>
>> Are you having any problems, or just investigating?
> 
> I need to add some other IC register to calibrate sensibility with
> different glasses, but starting from ft5x06 or other Focaltech standard
> IC FW.

If I understood correctly you want to implement auto-calibration, and in
order to do that you need the four extra registers, not mentioned in the
Focaltech datasheet. Right?

>> > Maybe M06 or M09 are a custom firmware for focaltech ft5x,
>> > then it has different registers?
>>
>> All the FT5x06 are 8051-based chips designed to implement touchscreen
>> controllers. The FT5x26 are similar but with a more powerful core
>> (Cortex-M IIRC).
>>
>> As far as I could understand and guess, their register interface is
>> fully implemented in firmware, so it could change completely from one
>> panel to another. However all panels that I have seen seem to use
>> firmwares with either the "M06" or the "M09" protocol, which are
>> implemented in the Linux driver.
> 
> In my case driver recognizes M09, but only address 0x80
> register(thgroup) is correct.
> The others:
> GAIN: 0x92
> GAIN: 0x93
> GAIN: 0x94
> GAIN: 0x95
> 
> are not described in that datasheet.

What about all the other registers? The datasheet lists a few dozen, not
only 0x80. Are they implemented in the panel you are working on?

> The point is that datasheet seems to be official by Focaltech,
> like if they deliver that IC with a standard FW inside.
> I can't find a way to safely probe if it's a standard FW or from EDT M09
> or M06.

Since everything is based on the programmed firmware, and there's no
"standard" way to detect firmware version, every firmware detection is
bound to be a hack. But there's no better way I'm afraid. Thus device
tree seems the only reliable way...

However, did you check registers FIRMID, FT5201ID (CTPM Vendor ID) and
ID_G_LIB_VERSION_H/L? According to their name they might hold
interesting info.

And did you consider read the "additional registers" tentatively during
probe to detect whether they are present? What effect would this have on
chips without those registers?

Bye,
-- 
Luca
