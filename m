From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Sun, 7 Dec 2008 12:28:38 -0800
Message-ID: <200812071228.38475.david-b@pacbell.net>
References: <200812071159.50267.david-b@pacbell.net>
	<20081207202128.GA9629@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20081207202128.GA9629@frodo>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sunday 07 December 2008, Felipe Balbi wrote:
> > +=A0=A0=A0=A0=A0platform_set_drvdata(pdev, keys);
> > +=A0=A0=A0=A0=A0keys->pdev =3D pdev;
>=20
> you could be holding only the device pointer.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0keys->dev =3D &pdev->dev;
>=20
> then, if you really happen to need the pdev pointer you can use
>=20
> to_platform_device(keys->dev);

True, that would be a bit simpler; the device handle is what's
normally needed, e.g. for dev_dbg().  I'd take an update patch;
but for now I'll avoid a re-test cycle.  :)

- Dave
