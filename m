From: Kristian =?ISO-8859-1?Q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
Subject: Re: PROBLEM: "BUG:" when resuming from suspend-to-ram
Date: Thu, 01 Mar 2007 21:34:10 +0100
Message-ID: <1172781250.5042.1.camel@localhost.localdomain>
References: <1172601905.5428.28.camel@localhost.localdomain>
	 <1172622441.4587.14.camel@localhost.localdomain>
	 <200702281345.15098.rjw@sisk.pl> <200703010036.28166.dtor@insightbb.com>
	 <1172779492.7396.2.camel@localhost.localdomain>
	 <d120d5000703011225t1ffaa33akbfcde29d2954601e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703011225t1ffaa33akbfcde29d2954601e@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 2007-03-01 at 15:25 -0500, Dmitry Torokhov wrote:
> On 3/1/07, Kristian Gr=F8nfeldt S=F8rensen <kriller@vkr.dk> wrote:
> >
> > Hmmm.
> >
> > Now i get this BUG:
> >
>=20
> Does it die the same way if you just unload the button driver without
> suspending?
>=20

No. Tried unloading and loading 30 times after each other. No problems
at all.

/Kristian
