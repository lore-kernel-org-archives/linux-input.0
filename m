From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH 8/8] input: gpio_keys_polled: fix Kconfig help text
Date: Sun, 05 Dec 2010 10:11:19 +0100
Message-ID: <4CFB5737.7040506@openwrt.org>
References: <4CF541ED.80905@openwrt.org>	<1291142663-1011-9-git-send-email-juhosg@openwrt.org> <87r5e1ksvd.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:33402 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0LEJLV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Dec 2010 04:11:21 -0500
In-Reply-To: <87r5e1ksvd.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

2010.12.01. 23:53 keltez=E9ssel, Ferenc Wagner =EDrta:
> Gabor Juhos <juhosg@openwrt.org> writes:
>=20
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -491,7 +491,7 @@ config KEYBOARD_GPIO_POLLED
>> -	  to GPIO pins of various CPUs (and some other chips).
>> +	  to GPIO pins which is not capable to generate interrupts.
>=20
> I suggest s/is/are/ or perhaps even s/which is //.

Ok, i will send an updated patch.

Thanks,
Gabor
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
