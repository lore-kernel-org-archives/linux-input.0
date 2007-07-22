From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: wistron_btns - Is polling always required?
Date: Sun, 22 Jul 2007 15:14:14 +0100
Message-ID: <200707221514.15142.cathectic@gmail.com>
References: <f7o5fo$b3c$1@sea.gmane.org> <200707200006.35795.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707200006.35795.dtor@insightbb.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, =?iso-8859-1?q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
List-Id: linux-input@vger.kernel.org

Dimitry, =C9ric,

On Friday 20 July 2007 05:06:35 Dmitry Torokhov wrote:
> I was not aware that these models can deliver events for hotkeys via
> atkbd. I think option B is best since interrupt-driven mode is always
> better than polling. I am CC-ing Eric Piel who did most of the work
> on new models support in wistron_btns.

Looking around a bit more, the following should definitely be removed fro=
m=20
wistron_btns:

Acer Aspire 3020
Acer Aspire 5020

The following I'm not entirely sure on these, but they _probably_ should =
be=20
removed:

Acer TravelMate 2100
Acer TravelMate 2410 (identical hardware to the Aspire 1610, which is kno=
wn to=20
generate scancodes)
Acer TravelMate 2424NWXCi (aka TravelMate 2420 series)

As a rule of thumb, if the laptop is based on Acer's "folio" design, whic=
h=20
they've used for most of the TravelMate and Aspire laptops from 2004 to t=
he=20
present day (although some of the newer ones are now using a different=20
design), and/ or the model/ series number is a four digit one (such as 50=
20),=20
it shouldn't be in wistron_btns (the Aspire 1500 and Aspire 1600 I would =
make=20
an exception for, as they don't appear to be based on the "folio" design,=
 and=20
therefore don't fit this pattern).

-Carlos
--=20
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
