From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Fri, 28 Nov 2008 20:27:51 +0200
Message-ID: <49303827.4050907@gmail.com>
References: <200811262333.45245.lukasz@lubojanski.info> <alpine.LRH.1.10.0811271337320.26670@twin.jikos.cz> <200811280718.23274.lukasz@lubojanski.info> <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:60579 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbYK1S2F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2008 13:28:05 -0500
In-Reply-To: <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-2?Q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>, linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Fri, 28 Nov 2008, =A3ukasz Luboja=F1ski wrote:
>=20
>>> Could you please rebase your patch on top of current state of Linus=
'
>>> kernel tree for 2.6.28-rc? Then the code could be reviewed and I'll=
 merge
>>> it through my tree.
>>> For inspiration, you can look into
>>>
>>> 	drivers/hid/hid-pl.c
>>>
>>> That driver even contains support for some Greenasia device ... (0x=
0003).
>> I have rewriten the code for 2.6.28-rc6 and after testing and checki=
ng=20
>> it with checkpatch I will send it again.
>=20
> Great, thanks.
>=20
>> Anyway I know that pantherlord code is also supporting greenasia dev=
ices=20
>> (first code was also mostly taken from that) - and I'm still don't k=
now=20
>> if I'm dooing right naming my part "greenasia" - because some people=
=20
>> could get confused. It could also happen that someone else will=20
>> implement other greenasia device and this will make another confusio=
n.
>=20
> The question is how much the protocol that is used by your device dif=
fers=20
> from the one that is already implemented in hid-pl.c? Would it make s=
ense=20
> to have these two implementations in the same driver, or is the proto=
col=20
> just completely different?

It seems the protocol resembles more the hid-lg2ff one. The differences
are the additional 0xfa 0xfe 0x0 report sent to the device, and the
missing 0xf3 stop command.

=A3ukasz, I see your code implements both FF_RUMBLE and FF_CONSTANT in =
the
same way. If the device only supports rumble effects, then you should
only implement FF_RUMBLE.

--=20
Anssi Hannula
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
