From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: wistron_btns - Is polling always required?
Date: Fri, 27 Jul 2007 14:27:21 +0100
Message-ID: <200707271427.22604.cathectic@gmail.com>
References: <f7o5fo$b3c$1@sea.gmane.org> <200707271220.51397.cathectic@gmail.com> <46A9EE0D.5040006@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46A9EE0D.5040006@tremplin-utc.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Ashutosh Naik <ashutosh.naik@gmail.com>
List-Id: linux-input@vger.kernel.org

On Friday 27 July 2007 14:07:25 =C3=89ric Piel wrote:
> [Ah! I hadn't realized that Carlos and Cathectic were the same person
> ;-) So _you_ are writing acer_acpi :-) ]

[Yes (I really don't like Google obfuscating my name with my user name - =
I'm=20
quite happy for people to know who I really am).]

> So there might be some laptop which do report keys directly via atkbd
> but do not have the ACPI interface to control the led/wireless?=20

Yes. AFAIK, it seems the "newer" Acer laptops (2006 and newer) do all com=
e=20
with a useable ACPI interface (at least, no one has reported to me one th=
at=20
doesn't). The 2004 to 2005 are hit and miss. I don't know of any Acer lap=
top=20
before 2004 that could be supported by acer_acpi (which in turn tend to b=
e=20
the ones more likely to require wistron_btns anyway).

> What a=20
> mess... Well, then this solution of keeping the support in wistron_btns
> is necessary.

For enabling the hardware on many of these laptops, yes.

> BTW, do you know you'll find plenty of acer DSDTs at this address:
> http://acpi.sourceforge.net/dsdt/view.php?manufacturer=3DACER . At leas=
t,
> there is 3020 and 2410 that you are looking for :-)

I've mostly found that a bit of a pain to sift through (since I really wa=
nt=20
the original DSDTs, not the user modified ones, and not everyone submits=20
their originals, or marks properly which one they uploaded. Although I wi=
ll=20
get around to poking about there and update acer_acpi's supported hardwar=
e=20
list soon).

> Well, let's just remove the key part for every hardware which does
> report keys via atkbd. Once acer_acpi is merged we can also drop
> completely the laptops which it supports. It doesn't really matter much
> if x86 has slightly more hardware support than x86-64.

Agreed.

> One very nice thing would be to agree on a common interface to control
> the wireless interfaces between wistron_btns and acer_acpi (IIRC, led
> interface is already mostly identical). So that users don't have the
> interface changing depending on which acer laptop or which driver they
> are using. That's basically two files called wifi and bluetooth, taking
> 1 for activation and 0 for deactivation. Anyone can suggest a good path
> to put them in? (It will be /sys/... definitely as nothing should be
> added to /proc anymore)
>
> /sys/devices/platform/acer/ ?

That sounds fine - my original upstream proposal for acer_acpi had someth=
ing=20
like that:

1) /sys/devices/platform/acer_acpi for wireless and bluetooth
2) Register Mail LED with LED subsystem

(I experimented with rfkill for wireless and bluetooth, but I didn't like=
 the=20
results - I ended up with devices named 'rfkill0', 'rfkill1', etc, which=20
wasn't very helpful).

-Carlos
--=20
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
