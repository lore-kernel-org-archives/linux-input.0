From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Input: Let the FT5x06 driver build without debugfs
Date: Fri, 17 Aug 2012 10:09:01 +0200
Message-ID: <502DFC1D.20903@kernelconcepts.de>
References: <87k3wy1ii3.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k3wy1ii3.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/17/2012 02:15 AM, Eric W. Biederman wrote:
> When testing to make certain my user namespace code works in
> various configurations I tripped over the tf5x06.c not building
> with debugfs disabled.

Sorry for that.

There already is a patch for this issue which I slightly prefer. You
can find it in the mail from Guenther Roeck:
   http://www.mail-archive.com/linux-input@vger.kernel.org/msg00646.html

Thanks,
        Simon


- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAt/B0ACgkQO2O/RXesiHCszgCeID9FyWmWea9eyktU38ikzPQP
V2gAoLfff/V9CtE9xpVmS2wIyyrC2d0J
=SSUc
-----END PGP SIGNATURE-----
