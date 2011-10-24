From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: Elantech touchpad problem
Date: Mon, 24 Oct 2011 23:52:53 +0200
Message-ID: <4EA5DE35.4050302@tudelft.nl>
References: <8198347.CZxqmPDXMC@ax5200p> <4EA52F55.80301@tudelft.nl> <2342123.XOsjN3CsJT@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:56986 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab1JXVw6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Oct 2011 17:52:58 -0400
In-Reply-To: <2342123.XOsjN3CsJT@ax5200p>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Op 24-10-11 21:00, Marc Dietrich schreef:
:
>
>> Let's see exactly what is "not working". When in compatible (IMPS
>> protocol), the touchpad is seen by Xorg differently than when using =
the
>> ad-hoc protocol. In particular, you should have the "synaptic" drive=
r.
>> Do you have it loaded? Check you xorg log (/var/log/Xorg.0.log). Als=
o
>
> I tried with it, but it does not detect the touchpad. I attached the =
xorg log
> with the imps mouse driver and the synaptics driver.


> just some new data point. Booted with with elantech proto (instead of=
 imps)
> and the synaptics driver loaded:
:
Ok, so Xorg correctly tries, but as the kernel driver fails to=20
initialise the hardware, obviously Xorg cannot get much out of it.

>
>> you can check whether there is input coming from the kernel or not: =
you
>> need to stop Xorg, and then do something like "evtest
>> /dev/input/eventX", where X is the number for the device correspondi=
ng
>> to your touchpad. Then touch a bit your touchpad, and you should see
>> lots of inputs, or not?
>
> correct, it reports the events matching my gestures.
Sorry, I'm reading again the dmesg logs, and I had missed all this "los=
t=20
sync" before. The elantech driver doesn't seem to be so happy with your=
=20
device.

:
>
> I have these patches already. In fact the problems started with them =
:-)
> After the "knocking", the touchpad responses 0x3c 0x03 0x00 which isn=
't
> detected in the old code.
Ok. Well, at least it's great because now you already have the latest=20
version of the kernel driver, so you can directly contact the developer=
=20
mailing-list.

>
>> Let me know if you find out the source of the problems.
>
> There is something special with this netbook as it connected the touc=
hpad to a
> keyboard controller which connects itself via i2c bus to the tegra cp=
u. So we
> have our own ps2 driver which "tunnels" the ps2 commands via i2c. Thi=
s worked
> well till now, but maybe the keyboard controller firmware may play tr=
icks on us
> (I hope it doesn't).
It could be, indeed.

Basically, it seems it can see the hardware, but when it tries to write=
=20
to it, it fails. It blocks at the a ETP_PS2_CUSTOM_COMMAND=3D0xf8 in a=20
call to elantech_write_reg():
[  658.643473] elantech: retrying ps2 command 0xe6 (2).
[  659.176446] elantech: retrying ps2 command 0xf8 (2).
[  659.880999] elantech: retrying ps2 command 0xf8 (1).

The rest of your log is lost connection to the hardware, until it=20
eventually gives up.

In the log we can see it tries 5 times before failing, so it's very=20
probably in elantech_set_absolute_mode(), which tries=20
ETP_READ_BACK_TRIES=3D5 times.

I can't really pinpoint what is command 0xe6. Could you maybe add a=20
debug line in elantech_ps2_command() to see what is exactly is sent bef=
ore:
elantech_debug("sending ps2 command 0x%02x.\n", command);

However, the way to write a register to the hardware is quite similar=20
for all versions of the hardware (above 1). So I'd quite be surprised=20
your hardware expects something else. So, if the command sent is=20
correct, and this fails, it might be due to some strange things=20
happening in the tunnelling...

All in all, I'd recommend you to determine precisely at which command i=
n=20
fails in elantech_set_absolute_mode(). Then contact the linux-input=20
(linux-input@vger.kernel.org) mailing list with JJ Ding=20
(jj_ding@emc.com.tw) and Dmitry Torokhov (dmitry.torokhov@gmail.com) in=
=20
CC. Explain precisely your setup, with the tunnelling, and with a copy=20
of the logs you have. Maybe someone else has the same device touchpad=20
version and could compare the log at least.

See you,
=C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
