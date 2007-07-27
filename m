From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: wistron_btns - Is polling always required?
Date: Fri, 27 Jul 2007 12:20:50 +0100
Message-ID: <200707271220.51397.cathectic@gmail.com>
References: <f7o5fo$b3c$1@sea.gmane.org> <200707221514.15142.cathectic@gmail.com> <46A7C375.4080109@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46A7C375.4080109@tremplin-utc.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Ashutosh Naik <ashutosh.naik@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wednesday 25 July 2007 22:41:09 =C3=89ric Piel wrote:
> So I'm fine with your suggestion to remove their entries, at least for:
> 3020, 5020, 2100, 2410. For the 2420, it came earlier from Ashutosh Nai=
k
> (cc'ed now), asking him first if it's also working without the driver
> would be much better!

Fair enough. :-)

> By removing the entries, we should keep in mind that with the vanilla
> kernel, there is still a small functionality loss: wireless and led
> activations are lost.=20

True, but then again, this still really shouldn't be done by polling (per=
haps=20
some sort of userspace application would do-the-right-thing?)

> Those functionalities are provided by the=20
> acer_acpi driver (with a much cleaner approach),=20

For the 3020/ 5020 yes. For the other machines I do not have DSDTs for th=
em=20
yet, so I don't know if acer_acpi will work with them or not (unfortunate=
ly=20
acer_acpi is limited to a small subset of Acer's 2005 and newer laptops -=
 I=20
just don't know all of them yet).

> but it's unlikely to=20
> reach the vanilla kernel within less than three or four releases.=20

Possibly - it won't go in as is though (I'm currently waiting on Len Brow=
n to=20
release a generic WMI ACPI implementation that acer_acpi can then build o=
n,=20
and hopefully _that_ will then get submitted upstream; acer_acpi in it's=20
current form has been NAKed).

> So=20
> Dimitry should decide if we want to only remove the key part from those
> entries, leaving the led and wireless part until acer_acpi gets merged
> or if we should delete them completely right now.

I would say not to base this decision on acer_acpi - I can't yet guarante=
e it=20
will support anything other than the 3020/5020 of the other listed laptop=
s. I=20
would say at the very least remove the 5020 from wistron_btns, otherwise =
it's=20
left with inconsistent support between x86 and x86-64.

-Carlos
--=20
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
