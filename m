From: Javier Herrero <jherrero@hvsistemas.es>
Subject: Re: [PATCH 1/1 try#2] [INPUT] keypad driver: Added support for	OpenCores
 Keyboard Controller
Date: Tue, 05 Feb 2008 12:33:13 +0100
Message-ID: <47A84979.5080004@hvsistemas.es>
References: <1201686610-31458-1-git-send-email-bryan.wu@analog.com> <87a5b0800801300353l196b39bekad6af6ccdbd49d5b@mail.gmail.com> <1201713502.8345.1.camel@roc-laptop> <20080205104242.GA11437@suse.cz> <47A845F7.8030102@hvsistemas.es> <20080205112242.GA5398@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754812AbYBELdl@vger.kernel.org>
In-Reply-To: <20080205112242.GA5398@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bryan Wu <bryan.wu@analog.com>, Will Newton <will.newton@gmail.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Vojtech Pavlik escribi=F3:
> On Tue, Feb 05, 2008 at 12:18:15PM +0100, Javier Herrero wrote:
>> Dear Vojtech,
>>
>> I think that a 1:1 mapping between linux keycodes and what keyboard =
sends=20
>> is right, because the scan code to key code conversion is already=20
>> programmed and done inside the FPGA code.
>
> And the FPGA code changes with different keyboards attached?
>
The original OpenCores keyboard controller is a 6 rows x 12 cols=20
keyboard controller that can be customized for other row/col sizes=20
modifiying Constants.vhd VHDL file, in which also the translation table=
=20
is defined, and for different key disposition schemes both the number o=
f=20
rows and cols can be changed. We are currently using this controller=20
with a 4x4 key matrix, and with a different key mapping values, so I=20
thought that it would be preferable to have the driver mapping fixed to=
=20
1:1 and do the mapping in the VHDL, since in most cases the keyboard=20
using this controller would be different to the default keyboard define=
d=20
in the original Contants.vhd VHDL file.

Regards,

Javier

>> Best regards,
>>
>> Javier
>>
>> Vojtech Pavlik escribi=F3:
>>> On Thu, Jan 31, 2008 at 01:18:22AM +0800, Bryan Wu wrote:
>>>
>>>> +static irqreturn_t opencores_kbd_isr(int irq, void *dev_id)
>>>> +{
>>>> +	unsigned char c;
>>>> +	struct platform_device *pdev =3D dev_id;
>>>> +	struct opencores_kbd *opencores_kbd =3D platform_get_drvdata(pde=
v);
>>>> +	struct input_dev *input =3D opencores_kbd->input;
>>>> +
>>>> +	c =3D readb(opencores_kbd->addr_res->start);
>>>> +	input_report_key(input, c & 0x7f, c & 0x80 ? 0 : 1);
>>>> +	input_sync(input);
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>  This looks utterly wrong: It assumes 1:1 mapping between Linux key=
codes
>>> and what the keyboard sends, which I can't believe is the case.
>>>
>> --=20
>> --------------------------------------------------------------------=
----
>> Javier Herrero                            EMAIL: jherrero@hvsistemas=
=2Ecom
>> HV Sistemas S.L.                          PHONE:         +34 949 336=
 806
>> Los Charcones, 17A                        FAX:           +34 949 336=
 792
>> 19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas=
=2Ecom=20
>

--=20
-----------------------------------------------------------------------=
-
Javier Herrero                            EMAIL: jherrero@hvsistemas.co=
m
HV Sistemas S.L.                          PHONE:         +34 949 336 80=
6
Los Charcones, 17A                        FAX:           +34 949 336 79=
2
19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas.co=
m=20
