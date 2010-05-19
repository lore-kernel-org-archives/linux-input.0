From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Wed, 19 May 2010 10:00:01 -0600
Message-ID: <AANLkTilV7xaAaUpt9oCraVL2jG2gP8N5DfYbr5XW6duV@mail.gmail.com>
References: <20100514102905.7807.27638.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<4BED2859.3050204@ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42946 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab0ESQA0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 12:00:26 -0400
Received: by gwaa20 with SMTP id a20so1882207gwa.19
        for <linux-input@vger.kernel.org>; Wed, 19 May 2010 09:00:23 -0700 (PDT)
In-Reply-To: <4BED2859.3050204@ge.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martyn Welch <martyn.welch@ge.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org

On Fri, May 14, 2010 at 4:39 AM, Martyn Welch <martyn.welch@ge.com> wro=
te:
> Martyn Welch wrote:
>> Currently the irqs for the i8042, which historically provides keyboa=
rd and
>> mouse (aux) support, is hardwired in the driver rather than parsing =
the
>> dts.
>>
>> In addition the interrupts are provided in the dts, but in a way tha=
t is
>> not easily parsable using irq_of_parse_and_map().
>>
>> This patch modifies the powerpc legacy IO code to attempt to parse t=
he
>> device tree for this information, failing back to the hardcoded valu=
es if
>> it fails. For this to succeed the interrupts for the keyboard and mo=
use
>> ports need to be moved from the parent i8042 node to the individual =
port
>> nodes.
>>
>> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
>> ---
>>
>> To get irq_of_parse_and_map() to successfully parse the interrupts, =
I had
>> to do this to my device tree:
>>
>> @@ -120,16 +120,17 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #add=
ress-cells =3D <1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <1 0x60 0x1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A01 0x64 0x1>;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interr=
upts =3D <1 1 12 1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inte=
rrupt-parent =3D <&lpc_pic>;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keyb=
oard@0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 reg =3D <0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 interrupts =3D <1 1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 compatible =3D "pnpPNP,303";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mous=
e@1 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 reg =3D <0x1>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 interrupts =3D <12 1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 compatible =3D "pnpPNP,f03";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> I'm not sure how to parse for the correct interrupt if I don't do th=
is. I
>> this is incorrect and someone could advise me on how the existing de=
vice
>> tree layout can be properly parsed, I'll happily modify this patch.

Call of_irq_parse_and_map() on the parent node, using the second
parameter to specify if you want the first or second irq.  You get the
parent node with of_get_parent().

Although looking at this fragment, I don't understand why the i8042
node doesn't have its own compatible property.  Maybe there is
something historical that I'm missing here.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
