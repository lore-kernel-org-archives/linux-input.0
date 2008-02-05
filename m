From: Javier Herrero <jherrero@hvsistemas.es>
Subject: Re: [PATCH 1/1 try#2] [INPUT] keypad driver: Added support for	OpenCores
 Keyboard Controller
Date: Tue, 05 Feb 2008 12:18:15 +0100
Message-ID: <47A845F7.8030102@hvsistemas.es>
References: <1201686610-31458-1-git-send-email-bryan.wu@analog.com> <87a5b0800801300353l196b39bekad6af6ccdbd49d5b@mail.gmail.com> <1201713502.8345.1.camel@roc-laptop> <20080205104242.GA11437@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752590AbYBELZQ@vger.kernel.org>
In-Reply-To: <20080205104242.GA11437@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bryan Wu <bryan.wu@analog.com>, Will Newton <will.newton@gmail.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dear Vojtech,

I think that a 1:1 mapping between linux keycodes and what keyboard=20
sends is right, because the scan code to key code conversion is already=
=20
programmed and done inside the FPGA code.

Best regards,

Javier

Vojtech Pavlik escribi=F3:
> On Thu, Jan 31, 2008 at 01:18:22AM +0800, Bryan Wu wrote:
>
>> +static irqreturn_t opencores_kbd_isr(int irq, void *dev_id)
>> +{
>> +	unsigned char c;
>> +	struct platform_device *pdev =3D dev_id;
>> +	struct opencores_kbd *opencores_kbd =3D platform_get_drvdata(pdev)=
;
>> +	struct input_dev *input =3D opencores_kbd->input;
>> +
>> +	c =3D readb(opencores_kbd->addr_res->start);
>> +	input_report_key(input, c & 0x7f, c & 0x80 ? 0 : 1);
>> +	input_sync(input);
>> +
>> +	return IRQ_HANDLED;
>> +}
> =20
> This looks utterly wrong: It assumes 1:1 mapping between Linux keycod=
es
> and what the keyboard sends, which I can't believe is the case.
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
