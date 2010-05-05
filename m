From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 20:03:28 +0200
Message-ID: <4BE1B2F0.6010809@euromail.se>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1A591.3020201@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:37114 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752526Ab0EESE1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 May 2010 14:04:27 -0400
In-Reply-To: <4BE1A591.3020201@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

=C9ric Piel wrote:
> Op 05-05-10 18:38, Dmitry Torokhov schreef:
>> Hi Eric,
>>
>> On Wed, May 05, 2010 at 02:20:46PM +0200, =C9ric Piel wrote:
> :
>>> =20
>>>  	/* byte 0: n1  n0   .   .   .   .   R   L */
>>>  	fingers =3D (packet[0] & 0xc0) >> 6;
>>> -	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>> Mousedev works a tad better if BTN_TOUCH is reported first. Otherwis=
e
>> looks good.
> I moved it there because somehow I had understood in the
> multi-touch-protocol that all the old events had to be reported after
> the last SYNC_MT. That said, I don't recall any influence on the
> synaptics nor multitouch X drivers. Maybe it matters just for the ABS=
_*
> events?

The "old" events can be reported anywhere in the sequence, it does not =
matter.

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
