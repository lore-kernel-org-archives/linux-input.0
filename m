From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 1/1 try#2] [INPUT] keypad driver: Added support for
	OpenCores Keyboard Controller
Date: Tue, 5 Feb 2008 12:22:42 +0100
Message-ID: <20080205112242.GA5398@suse.cz>
References: <1201686610-31458-1-git-send-email-bryan.wu@analog.com> <87a5b0800801300353l196b39bekad6af6ccdbd49d5b@mail.gmail.com> <1201713502.8345.1.camel@roc-laptop> <20080205104242.GA11437@suse.cz> <47A845F7.8030102@hvsistemas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751863AbYBELWy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47A845F7.8030102@hvsistemas.es>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Herrero <jherrero@hvsistemas.es>
Cc: Bryan Wu <bryan.wu@analog.com>, Will Newton <will.newton@gmail.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 05, 2008 at 12:18:15PM +0100, Javier Herrero wrote:
> Dear Vojtech,
>
> I think that a 1:1 mapping between linux keycodes and what keyboard s=
ends=20
> is right, because the scan code to key code conversion is already=20
> programmed and done inside the FPGA code.

And the FPGA code changes with different keyboards attached?

> Best regards,
>
> Javier
>
> Vojtech Pavlik escribi=F3:
>> On Thu, Jan 31, 2008 at 01:18:22AM +0800, Bryan Wu wrote:
>>
>>> +static irqreturn_t opencores_kbd_isr(int irq, void *dev_id)
>>> +{
>>> +	unsigned char c;
>>> +	struct platform_device *pdev =3D dev_id;
>>> +	struct opencores_kbd *opencores_kbd =3D platform_get_drvdata(pdev=
);
>>> +	struct input_dev *input =3D opencores_kbd->input;
>>> +
>>> +	c =3D readb(opencores_kbd->addr_res->start);
>>> +	input_report_key(input, c & 0x7f, c & 0x80 ? 0 : 1);
>>> +	input_sync(input);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>  This looks utterly wrong: It assumes 1:1 mapping between Linux keyc=
odes
>> and what the keyboard sends, which I can't believe is the case.
>>
>
> --=20
> ---------------------------------------------------------------------=
---
> Javier Herrero                            EMAIL: jherrero@hvsistemas.=
com
> HV Sistemas S.L.                          PHONE:         +34 949 336 =
806
> Los Charcones, 17A                        FAX:           +34 949 336 =
792
> 19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas.=
com=20

--=20
Vojtech Pavlik
Director SuSE Labs
