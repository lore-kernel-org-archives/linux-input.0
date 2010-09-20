From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 21:48:50 +0200
Message-ID: <4C97BAA2.6000309@euromail.se>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-2-git-send-email-rydberg@euromail.se> <FF722ED6-6568-47D0-82D1-99B9E9D5AEAF@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:58805 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802Ab0ITTtd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 15:49:33 -0400
In-Reply-To: <FF722ED6-6568-47D0-82D1-99B9E9D5AEAF@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/20/2010 09:43 PM, St=E9phane Chatty wrote:

>=20
> Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :
>=20
>> The Microtouch controller is capable of doing finger tracking on
>> up to 60 fingers. To reduce bandwidth and cpu usage, convert the
>> driver to use the MT slots protocol.
>=20
> As I understand it, this patch actually has three roles:
>  1. improving the evdev parameters of the device
>  2. cleaning the protocol to get rid of useless MISC/SCANCODE message=
s
>  3. convert the protocol to MT slots
>=20
>=20
>> +#define SN_MOVE            2048
>> +#define SN_WIDTH        128
>>
>=20
> In the long run, it might be useful to comment these signal/noise con=
stants
>=20
>=20
>=20
>>              hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
>> +            input_set_capability(hi->input, EV_KEY, BTN_TOUCH);
>=20
>>  {
>> +    /* tell hid-input to skip setup of these event types */
>>      if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_ABS)
>> -        clear_bit(usage->code, *bit);
>> -
>> -    return 0;
>> +        set_bit(usage->type, hi->input->evbit);
>> +    return -1;
>>  }
>>
>=20
> I understand this as a trick to get rid of MISC/SCANCODEs that are ad=
ded for
> every EV_KEY message, consequence of a rule in hid-input.c. Wouldn't =
it be
> simpler to improve the rule than to work around it?


The main reason is to be able to set the fuzz parameters, which are oth=
erwise
overwritten by hid-input setup.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
