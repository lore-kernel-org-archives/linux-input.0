From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: wistron_btns - Is polling always required?
Date: Wed, 25 Jul 2007 23:41:09 +0200
Message-ID: <46A7C375.4080109@tremplin-utc.net>
References: <f7o5fo$b3c$1@sea.gmane.org> <200707200006.35795.dtor@insightbb.com> <200707221514.15142.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707221514.15142.cathectic@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Ashutosh Naik <ashutosh.naik@gmail.com>
List-Id: linux-input@vger.kernel.org

07/22/2007 04:14 PM, Carlos Corbacho wrote/a =C3=A9crit:
> Dimitry, =C3=89ric,
>=20
> On Friday 20 July 2007 05:06:35 Dmitry Torokhov wrote:
>> I was not aware that these models can deliver events for hotkeys via
>> atkbd. I think option B is best since interrupt-driven mode is always
>> better than polling. I am CC-ing Eric Piel who did most of the work
>> on new models support in wistron_btns.
>=20
> Looking around a bit more, the following should definitely be removed f=
rom=20
> wistron_btns:
>=20
> Acer Aspire 3020
> Acer Aspire 5020
>=20
> The following I'm not entirely sure on these, but they _probably_ shoul=
d be=20
> removed:
>=20
> Acer TravelMate 2100
> Acer TravelMate 2410 (identical hardware to the Aspire 1610, which is k=
nown to=20
> generate scancodes)
> Acer TravelMate 2424NWXCi (aka TravelMate 2420 series)
>=20
> As a rule of thumb, if the laptop is based on Acer's "folio" design, wh=
ich=20
> they've used for most of the TravelMate and Aspire laptops from 2004 to=
 the=20
> present day (although some of the newer ones are now using a different=20
> design), and/ or the model/ series number is a four digit one (such as =
5020),=20
> it shouldn't be in wistron_btns (the Aspire 1500 and Aspire 1600 I woul=
d make=20
> an exception for, as they don't appear to be based on the "folio" desig=
n, and=20
> therefore don't fit this pattern).

Hi,

I finally got a hand on an old 3020, a 32 bit-only one. I can confirm=20
that even on this old version the keys are also passed through atkdb=20
(including wifi and bluetooth keys). I had put all the one you mentioned=20
only because they were described in the acerhk driver as using the=20
wistron interface. I'm not attached to them at all ;-)

So I'm fine with your suggestion to remove their entries, at least for:=20
3020, 5020, 2100, 2410. For the 2420, it came earlier from Ashutosh Naik=20
(cc'ed now), asking him first if it's also working without the driver=20
would be much better!

By removing the entries, we should keep in mind that with the vanilla=20
kernel, there is still a small functionality loss: wireless and led=20
activations are lost. Those functionalities are provided by the=20
acer_acpi driver (with a much cleaner approach), but it's unlikely to=20
reach the vanilla kernel within less than three or four releases. So=20
Dimitry should decide if we want to only remove the key part from those=20
entries, leaving the led and wireless part until acer_acpi gets merged=20
or if we should delete them completely right now.

See you,
Eric
