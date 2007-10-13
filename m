From: Andreas Schwab <schwab@suse.de>
Subject: Re: [patch 2/8] m68k: Atari keyboard ACIA driver cleanup
Date: Sat, 13 Oct 2007 17:32:43 +0200
Message-ID: <jed4vjrpwk.fsf@sykes.suse.de>
References: <20071013123123.085686856@mail.of.borg>
	<20071013123412.672481897@mail.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071013123412.672481897@mail.of.borg> (Geert Uytterhoeven's
	message of "Sat\, 13 Oct 2007 14\:31\:25 +0200")
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
List-Id: linux-input@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> --- a/arch/m68k/atari/atakeyb.c
> +++ b/arch/m68k/atari/atakeyb.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/atari/atakeyb.c
> + * linux/arch/m68k/atari/atakeyb.c

Please kill that line.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED=
5
"And now for something completely different."
