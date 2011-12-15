From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] input: signedness bug in cma3000_thread_irq()
Date: Wed, 14 Dec 2011 22:21:00 -0500
Message-ID: <3797.1323919260@turing-police.cc.vt.edu>
References: <1323672566-16738-1-git-send-email-xi.wang@gmail.com> <12775.1323916035@turing-police.cc.vt.edu>
            <ECD4A42B-AC97-417B-99CA-3856B5DAFAC6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1323919260_3689P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: Your message of "Wed, 14 Dec 2011 21:35:22 EST."
             <ECD4A42B-AC97-417B-99CA-3856B5DAFAC6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--==_Exmh_1323919260_3689P
Content-Type: text/plain; charset=us-ascii

On Wed, 14 Dec 2011 21:35:22 EST, Xi Wang said:
> On Dec 14, 2011, at 9:27 PM, Valdis.Kletnieks@vt.edu wrote:
> > That will fix the signed/unsigned issue.  However, was there a reason
> > the field was an 8-bit-wide to begin with?
>
> Which field?  The ->read() function pointer?

No, the variable that used to be a u8 - was it 8 bits wide for a reason?

--==_Exmh_1323919260_3689P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFO6WeccC3lWbTT17ARAl/dAKDZxg4rTZak3KJBZLvQLzCCxJIBiwCghJiq
9f1CjeffPASHIzxSOkxpr/c=
=yKs9
-----END PGP SIGNATURE-----

--==_Exmh_1323919260_3689P--
