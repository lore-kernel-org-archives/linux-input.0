From: Daniel Stone <daniel-rLtY4a/8tF1rovVCs/uTlw@public.gmane.org>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sun, 7 Nov 2010 11:30:37 -0500
Message-ID: <20101107163037.GR14865@fooishbar.org>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0588422632=="
Return-path: <xorg-devel-bounces+gcfxd-xorg-devel=m.gmane.org-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
In-Reply-To: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.x.org/mailman/options/xorg-devel>,
	<mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.x.org/archives/xorg-devel>
List-Post: <mailto:xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://lists.x.org/mailman/listinfo/xorg-devel>,
	<mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: xorg-devel-bounces+gcfxd-xorg-devel=m.gmane.org-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Errors-To: xorg-devel-bounces+gcfxd-xorg-devel=m.gmane.org-go0+a7rfsptAfugRpC6u6w@public.gmane.org
To: Ping Cheng <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "X.Org Devel List" <xorg-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--===============0588422632==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 05, 2010 at 11:47:28AM -0700, Ping Cheng wrote:
> Recent changes and discussion about MT support at LKML, UDS, and
> xorg-devel encouraged me to migrate Wacom MT devices to the slot-based
> MT protocol (introduced in kernel 2.6.36).

Nice!

> My goal is to understand how X server would like the MT data to be
> reported from the kernel. I hope to keep kernel and X server driver MT
> support in sync so we can avoid unnecessary confusion or extra work in
> the userland.

:)

> The existing solution for single touch events is to arbitrate touch
> when pen is in prox. This is based on the assumption that we do not
> want to have two cursors competing on the screen.

What do you mean by 'arbitrate' here? I guess you're talking about which
events should send ABS_[XY]?

> 1.     Arbitrate all touch data in the kernel.
>=20
> This is the simplest solution for device driver developers. But I do
> not feel it is end user and userland client friendly.
>=20
> [...]
>=20
> 3.    Report first finger touch as ABS_X/Y events when pen is not in prox;
>        Report pen data as ABS_X/Y events when there is no finger touch;
>        Report touch data as MT_TOOL_TOUCH and pen data as MT_TOOL_PEN
> events when both pen and touch data are received. No ABS_X/Y are
> reported when pen and tocuh or multi-touch data are received.
>=20
> I feel this one makes sense to userland since pen can be considered as
> another touch.

I'd say that either #1 or #3 is the best idea here, simply because they
seem to be the most straightforward, and thus easier to support.
Assuming that xf86-input-wacom will track the state itself and decide
(using whatever criteria) which events should send core x/y motion, then
all you need to do with ABS_[XY] is just make a best effort to have it
more or less work for dumb userspace clients.

Cheers,
Daniel

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzW1C0ACgkQUVYB1rKAgJQsVgCeLDJMhTo5lI6b5bCGjJs9bUDT
XaoAnR87SXjRDsxSWa4vlBUrbD3S4VWZ
=HGz6
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--===============0588422632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org: X.Org development
Archives: http://lists.x.org/archives/xorg-devel
Info: http://lists.x.org/mailman/listinfo/xorg-devel
--===============0588422632==--
