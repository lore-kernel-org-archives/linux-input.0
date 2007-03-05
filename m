From: Kristian =?ISO-8859-1?Q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
Subject: Re: PROBLEM: "BUG:" when resuming from suspend-to-ram
Date: Mon, 05 Mar 2007 21:51:38 +0100
Message-ID: <1173127898.10294.1.camel@miraculinux>
References: <1172601905.5428.28.camel@localhost.localdomain>
	 <1172781250.5042.1.camel@localhost.localdomain>
	 <d120d5000703050644x741564v625f0aa7a58c60ad@mail.gmail.com>
	 <200703051932.29996.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703051932.29996.rjw@sisk.pl>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2007-03-05 at 19:32 +0100, Rafael J. Wysocki wrote:
> On Monday, 5 March 2007 15:44, Dmitry Torokhov wrote:
> > On 3/1/07, Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> > > On Thu, 2007-03-01 at 15:25 -0500, Dmitry Torokhov wrote:
> > > > On 3/1/07, Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> > > > >
> > > > > Hmmm.
> > > > >
> > > > > Now i get this BUG:
> > > > >
> > > >
> > > > Does it die the same way if you just unload the button driver witho=
ut
> > > > suspending?
> > > >
> > >
> > > No. Tried unloading and loading 30 times after each other. No problem=
s
> > > at all.
> > >
> >=20
> > I wonder what causes unloading of the ACPI button driver during resume.=
..
>=20
> Let me guess: pm-utils in OpenSUSE 10.2.
>=20
Nope. acpi-support for Debian unstable.

/Kristian
