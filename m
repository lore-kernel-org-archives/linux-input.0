From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2] HID: Add Support for Setting and Getting Feature
 Reports from hidraw
Date: Thu, 10 Jun 2010 12:45:11 +0200
Message-ID: <20100610124511.973a2ca5.ospite@studenti.unina.it>
References: <1275969108-14948-1-git-send-email-alan@signal11.us>
	<1276098868-3262-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__10_Jun_2010_12_45_11_+0200_=L0YqTYKWoKfYaWU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:44504 "EHLO
	smtp208-alice.cp.alice.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758100Ab0FJKv6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jun 2010 06:51:58 -0400
In-Reply-To: <1276098868-3262-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Stephane Chatty <chatty@enac.fr>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

--Signature=_Thu__10_Jun_2010_12_45_11_+0200_=L0YqTYKWoKfYaWU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed,  9 Jun 2010 11:54:28 -0400
Alan Ott <alan@signal11.us> wrote:

> Per the HID Specification, Feature reports must be sent and received on
> the Configuration endpoint (EP 0) through the Set_Report/Get_Report
> interfaces.  This patch adds two ioctls to hidraw to set and get feature
> reports to and from the device.  Modifications were made to hidraw and
> usbhid.
>=20
> New hidraw ioctls:
>   HIDIOCSFEATURE - Perform a Set_Report transfer of a Feature report.
>   HIDIOCGFEATURE - Perform a Get_Report transfer of a Feature report.
>=20
> Signed-off-by: Alan Ott <alan@signal11.us>

Tested-by: Antonio Ospite <ospite@studenti.unina.it>

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Thu__10_Jun_2010_12_45_11_+0200_=L0YqTYKWoKfYaWU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwQwjcACgkQ5xr2akVTsAGi5QCfddQ3+Tw0qKSEPpahyuFJul2y
KloAn04s+M7U21CxsUH6G4FJmr/5FKvg
=f32D
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jun_2010_12_45_11_+0200_=L0YqTYKWoKfYaWU--
