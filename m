From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Fix hid_device_id for cross compiling
Date: Thu, 30 Oct 2008 10:19:51 +0100
Message-ID: <jehc6u8mo8.fsf@sykes.suse.de>
References: <jevdvgl345.fsf@sykes.suse.de>
	<20081030002332.4ef1fac4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754310AbYJ3JUH@vger.kernel.org>
In-Reply-To: <20081030002332.4ef1fac4.akpm@linux-foundation.org> (Andrew
	Morton's message of "Thu, 30 Oct 2008 00:23:32 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@ver.kernel.org
List-Id: linux-input@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Sun, 26 Oct 2008 00:30:18 +0200 Andreas Schwab <schwab@suse.de> wr=
ote:
>
>> struct hid_device_id contains hidden padding which is bad for cross
>> compiling.  Make the padding explicit and consistent across
>> architectures.
>>=20
>
> What is "bad" about it?

It is bad because it depends on the alignment restrictions of the
architecture.  On m68k everything is aligned on a 2-byte boundary, so
this padding does not exist.

> Can you expand a bit on the problem which is being fixed here?

It's the well known cross compiling problem with modpost that has bitte=
n
us so often before.  This one is even worse, because modpost would
silently read bogus values since the struct size is the same, only the
padding moves elsewhere.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
