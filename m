From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: wistron_btns - Is polling always required?
Date: Fri, 27 Jul 2007 15:07:25 +0200
Message-ID: <46A9EE0D.5040006@tremplin-utc.net>
References: <f7o5fo$b3c$1@sea.gmane.org> <200707221514.15142.cathectic@gmail.com> <46A7C375.4080109@tremplin-utc.net> <200707271220.51397.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707271220.51397.cathectic@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Ashutosh Naik <ashutosh.naik@gmail.com>
List-Id: linux-input@vger.kernel.org

07/27/2007 01:20 PM, Carlos Corbacho wrote/a =C3=A9crit:
> On Wednesday 25 July 2007 22:41:09 =C3=89ric Piel wrote:
>> By removing the entries, we should keep in mind that with the vanilla
>> kernel, there is still a small functionality loss: wireless and led
>> activations are lost.=20
>=20
> True, but then again, this still really shouldn't be done by polling (p=
erhaps=20
> some sort of userspace application would do-the-right-thing?)
Yes, that's right, I hadn't thought this way. What we could do is that=20
if an entry doesn't contain any key related info, we don't activate the=20
polling. That would require adding a user interface to control the=20
bluetooth and wifi cards...


>> Those functionalities are provided by the=20
>> acer_acpi driver (with a much cleaner approach),=20
>=20
> For the 3020/ 5020 yes. For the other machines I do not have DSDTs for =
them=20
> yet, so I don't know if acer_acpi will work with them or not (unfortuna=
tely=20
> acer_acpi is limited to a small subset of Acer's 2005 and newer laptops=
 - I=20
> just don't know all of them yet).
[Ah! I hadn't realized that Carlos and Cathectic were the same person=20
;-) So _you_ are writing acer_acpi :-) ]
So there might be some laptop which do report keys directly via atkbd=20
but do not have the ACPI interface to control the led/wireless? What a=20
mess... Well, then this solution of keeping the support in wistron_btns=20
is necessary.

BTW, do you know you'll find plenty of acer DSDTs at this address:=20
http://acpi.sourceforge.net/dsdt/view.php?manufacturer=3DACER . At least,=
=20
there is 3020 and 2410 that you are looking for :-)

>> So=20
>> Dimitry should decide if we want to only remove the key part from thos=
e
>> entries, leaving the led and wireless part until acer_acpi gets merged
>> or if we should delete them completely right now.
>=20
> I would say not to base this decision on acer_acpi - I can't yet guaran=
tee it=20
> will support anything other than the 3020/5020 of the other listed lapt=
ops. I=20
> would say at the very least remove the 5020 from wistron_btns, otherwis=
e it's=20
> left with inconsistent support between x86 and x86-64.
Well, let's just remove the key part for every hardware which does=20
report keys via atkbd. Once acer_acpi is merged we can also drop=20
completely the laptops which it supports. It doesn't really matter much=20
if x86 has slightly more hardware support than x86-64.

One very nice thing would be to agree on a common interface to control=20
the wireless interfaces between wistron_btns and acer_acpi (IIRC, led=20
interface is already mostly identical). So that users don't have the=20
interface changing depending on which acer laptop or which driver they=20
are using. That's basically two files called wifi and bluetooth, taking=20
1 for activation and 0 for deactivation. Anyone can suggest a good path=20
to put them in? (It will be /sys/... definitely as nothing should be=20
added to /proc anymore)

/sys/devices/platform/acer/ ?

Eric
