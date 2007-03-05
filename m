From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PROBLEM: "BUG:" when resuming from suspend-to-ram
Date: Mon, 5 Mar 2007 19:32:29 +0100
Message-ID: <200703051932.29996.rjw@sisk.pl>
References: <1172601905.5428.28.camel@localhost.localdomain> <1172781250.5042.1.camel@localhost.localdomain> <d120d5000703050644x741564v625f0aa7a58c60ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703050644x741564v625f0aa7a58c60ad@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristian =?iso-8859-1?q?Gr=F8nfeldt?= =?iso-8859-1?q?_S=F8rensen?= <kriller@vkr.dk>, linux-input@atrey.karlin.mff.cuni.cz, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Monday, 5 March 2007 15:44, Dmitry Torokhov wrote:
> On 3/1/07, Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> > On Thu, 2007-03-01 at 15:25 -0500, Dmitry Torokhov wrote:
> > > On 3/1/07, Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> > > >
> > > > Hmmm.
> > > >
> > > > Now i get this BUG:
> > > >
> > >
> > > Does it die the same way if you just unload the button driver without
> > > suspending?
> > >
> >
> > No. Tried unloading and loading 30 times after each other. No problems
> > at all.
> >
>=20
> I wonder what causes unloading of the ACPI button driver during resume...

Let me guess: pm-utils in OpenSUSE 10.2.
