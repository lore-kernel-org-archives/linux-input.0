From: Hendrik Iben <Hendrik_Iben@web.de>
Subject: Re: hid-lg2ff handling of zero/low magnitude rumble effects
Date: Sat, 05 Apr 2014 01:02:13 +0200
Message-ID: <533F39F5.3020909@web.de>
References: <CADbOyBRGha3+X8RSjvOU=ftTGuDGYAyuFW_b7==0HeF1uBLV-g@mail.gmail.com> <CADbOyBQkSGkDYcfpRUZR-h=gz-3S-NGLg4meuFYAP4zZQ7d2fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:60929 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbaDDXCj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Apr 2014 19:02:39 -0400
In-Reply-To: <CADbOyBQkSGkDYcfpRUZR-h=gz-3S-NGLg4meuFYAP4zZQ7d2fQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>, Edgar Simo-Serra <bobbens@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org, Simon Wood <simon@mungewell.org>, =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>

Hi Elias,

First of all - thanks for caring about compatibility with old devices.
It would be really annoying if something that worked once stopped
working on an update.

I just dug out my old Wingman Rumblepad (VID 046d PID c20a) and did the
test cases (thanks for the tool by the way - might come in handy for
other things). The first motor for this device controls a weak/smooth
rumble effect and the second one a strong/coarse one. For both motors,
values from 00 to 03 have no effect on the haptic side. You can hear the
motors spinning a bit higher if you hold the pad to your ear... :-) -
but it sounds like a  linear increase. It similar for the high values.
FC-FF produce the same high amount of rumble. There might be a small
increase but not really any difference.
>From these observations I would say that clamping is fine for the
Rumblepad although not needed. But a special case handling would have no
positive effect.

Best regards,
Hendrik

Am 04.04.2014 22:10, schrieb Elias Vanderstuyft:
> Hi guys,
> 
> 
> I'm about to release a patch (see attachment
> "0001-HID-lg2ff-add-rumble-magnitude-clamping-quirk.patch") for the
> lg2ff driver to account for some weird quirks concerning the magnitude
> of a rumble effect.
> You can read the description in that patch too get more details on it.
> 
> The reason I sent this to you, is because I only own and tested this
> on a Logitech Vibration Feedback wheel, and not on a Rumblepad (2). I
> saw that Hendrik might have a Wingman Rumblepad, and Edgar a Rumblepad
> 2 device. But if other people have such lg2ff-compatible device as
> well, feel free to cooperate.
> May I ask you to perform some simple tests (see next paragraph) to
> verify that these quirks are also valid on those devices?
> 
> To test sending some USB commands, I attached "USBCommander.zip" which
> contains a program made with Qt4 by Michal (Cc'd; thanks Michal!) To
> build it, you will need to run 'qmake-qt4' and 'make' in the top-level
> directory.
> It's simple to use USBCommander: enter the Vendor ID ("046d") and
> Product ID ("c20a" for Rumblepad, or "c218" for Rumblepad 2), then
> press 'Open', enter the to-be-tested command in the 'Command:' field,
> and finally press 'Send command'.
> After testing, press 'Release' and then quit the application.
> You will need to run 'USBCommander' as root to send the USB commands.
> 
> Commands to test:
> ==============
> 
>     Send the following commands (without parentheses):
>     "51 00 xx 00 yy 00 00"
>     with yy (strong rumble) = "02" and:
>         xx = "00"    => You should feel an irregular weak rumble
>         xx = "01"    => You should feel an irregular weak rumble
>         xx = "02"    => You should feel (almost) no rumble
>         xx = "03"    => You should feel (almost) no rumble
>         xx = "FC"    => You should feel much weak rumble
>         xx = "FD"    => You should feel much weak rumble
>         xx = "FE"    => You should feel much irregular weak rumble,
> but less than with xx = FD
>         xx = "FF"    => You should feel much irregular weak rumble,
> but less than with xx = FD
> 
>     Test the same for the other rumble motor type (swap xx with yy).
> 
>     To stop the rumble, send the following command:
>     "F3 00 00 00 00 00 00"
> 
> If you discover that the results do not match my assumptions, please
> tell what happens in that case.
> 
> 
> Thank you very much,
> 
> Elias
> 
> On Thu, Mar 27, 2014 at 11:13 PM, Elias Vanderstuyft
> <elias.vds@gmail.com> wrote:
>> Hi,
>>
>>
>> I noticed that my rumble wheel (Logitech Formula Vibration Feedback)
>> reacts in a strange way when sending low rumble magnitudes to the
>> device:
>>
>> Assume the following USB command to be send to emit rumble:
>>     report->field[0]->value[0] = 0x51;
>>     report->field[0]->value[2] = weak;
>>     report->field[0]->value[4] = strong;
>> When 'weak' or 'strong' is lower than 0x02 (i.e. 0x01 or 0x00), then
>> the corresponding rumble motor begins to rumble intermittently, this
>> resembles a bit to forcing a 2-state light-switch to be in the middle
>> position.
>>
>> Now my question is whether all other devices (e.g. "Logitech
>> RumblePad", "Rumblepad 2") experience this behaviour?
>> (If you own such a device, please verify this.)
>>
>>
>> Best regards,
>>
>> Elias
