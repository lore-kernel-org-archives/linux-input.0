From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 1/2] elantech: Improved protocol support for hardware
 2
Date: Mon, 10 May 2010 14:02:51 +0200
Message-ID: <4BE7F5EB.9060904@tudelft.nl>
References: <4BE59352.4070407@tudelft.nl> <4BE5A353.2080308@euromail.se> <4BE604CC.7010903@tudelft.nl> <4BE6EBF6.7060900@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:60907 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0EJMCy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 08:02:54 -0400
In-Reply-To: <4BE6EBF6.7060900@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 09-05-10 19:08, Henrik Rydberg schreef:
> =C3=89ric Piel wrote:
>> Op 08-05-10 19:45, Henrik Rydberg schreef:
>>> Hi =C3=89ric,
>>>
>> :
>>> Please run the ./scripts/checkpatch.pl on patches before submitting=
 them, to
>>> remove trivial formatting errors.
>> Ooops, I usually run it... forgot this time, while it would have bee=
n
>> very worthy. Thanks for noticing.
>> Here is a version fixed.
>=20
> Thanks, comments below.
:
Thanks for the feedback. I'll fix the comments and resend.

>> @@ -467,6 +480,8 @@ static void elantech_set_input_params(struct psm=
ouse
>> *psmouse)
>>  		break;
>>
>>  	case 2:
>> +		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
>> +		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V=
2,
>> 0, 0);
>=20
> Is there an appropriate signal-to-noise ratio for the width? How does=
 the device
> handle fingers going away? Does it send one or several zero-width eve=
nts?
What do you mean by SNR for the width? The minimal variation which is
significant for an actual change in the width of the finger? On my
hardware it was fairly precise, and a unit was stable as long as I kept
the finger pressed the same way. Actually at some low pressures I could
swear it detects my blood pulse ;-) That said, in all the measures the
values were between 13 and 55, but I put as min and max 0 and 64. I did
this because I'm not sure it's the same with every version of the
hardware (apparently some old versions of the hardware even just report
0 all the time). It sounded more conservative this way. Is that the
right way?

When you leave the last finger, the device sends one message with "0
finger". However, as it is currently working, the driver then just send=
s
one "BTN_TOUCH 0", but not any change in the ABS_TOOL_WIDTH. According
to the input protocol, should it also sends in this case a
"ABS_TOOL_WIDTH 0"?

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
