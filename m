From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1 try#2] [INPUT] keypad driver: Added support for OpenCores Keyboard Controller
Date: Mon, 12 May 2008 13:50:42 +0800
Message-ID: <386072610805112250p33e1c10cm347682fc5fe40d55@mail.gmail.com>
References: <1201686610-31458-1-git-send-email-bryan.wu@analog.com>
	 <87a5b0800801300353l196b39bekad6af6ccdbd49d5b@mail.gmail.com>
	 <1201713502.8345.1.camel@roc-laptop> <20080205104242.GA11437@suse.cz>
	 <47A845F7.8030102@hvsistemas.es> <20080205112242.GA5398@suse.cz>
	 <47A84979.5080004@hvsistemas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757593AbYELFvA@vger.kernel.org>
In-Reply-To: <47A84979.5080004@hvsistemas.es>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Herrero <jherrero@hvsistemas.es>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Bryan Wu <bryan.wu@analog.com>, Will Newton <will.newton@gmail.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 5, 2008 at 7:33 PM, Javier Herrero <jherrero@hvsistemas.es>=
 wrote:
> Vojtech Pavlik escribi=F3:
>>
>> On Tue, Feb 05, 2008 at 12:18:15PM +0100, Javier Herrero wrote:
>>>
>>> Dear Vojtech,
>>>
>>> I think that a 1:1 mapping between linux keycodes and what keyboard=
 sends
>>> is right, because the scan code to key code conversion is already p=
rogrammed
>>> and done inside the FPGA code.
>>
>> And the FPGA code changes with different keyboards attached?
>>
> The original OpenCores keyboard controller is a 6 rows x 12 cols keyb=
oard
> controller that can be customized for other row/col sizes modifiying
> Constants.vhd VHDL file, in which also the translation table is defin=
ed, and
> for different key disposition schemes both the number of rows and col=
s can
> be changed. We are currently using this controller with a 4x4 key mat=
rix,
> and with a different key mapping values, so I thought that it would b=
e
> preferable to have the driver mapping fixed to 1:1 and do the mapping=
 in the
> VHDL, since in most cases the keyboard using this controller would be
> different to the default keyboard defined in the original Contants.vh=
d VHDL
> file.
>
> Regards,
>
> Javier
>

Hi Vojtech, Will and Dmitry,

How do you think of this driver from Javier?
It works fine on Blackfin arch, but it can also be shared by other plat=
form.
So this driver is useful of the other developers.
Could you please consider merging this driver?

If you need me to resend this patch, please ping me.

Thanks
-Bryan
