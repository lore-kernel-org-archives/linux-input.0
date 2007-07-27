From: "Indan Zupancic" <indan@nul.nu>
Subject: Re: [RFC/RFT 0/5] Input locking patches
Date: Sat, 28 Jul 2007 00:25:31 +0200 (CEST)
Message-ID: <41532.81.207.0.53.1185575131.squirrel@secure.samage.net>
References: <20070724044520.913891976.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070724044520.913891976.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, July 24, 2007 06:45, Dmitry Torokhov wrote:
> Hi everyone,
>
> I finally managed to put together some patches implementing
> locking in input core and main input handles. Please look
> over them and give them a spin.

Since kernel 2.6.21 or so I was annoyed by a warping mouse, and
one kernel version later also by "stuck" keys, causing repeated input
at the most inconvenient moments (e.g. when opening a program by
pressing F1).

As it happened irregularly and unpredictable it was hard to debug,
and I suspected faulty hardware. My cpu was quite hot, but after
removing all the dust it seems all right again. Unfortunately that
was about the same time I upgraded to 2.6.23-rc1, so all I can say
is that the stuck key problem seems to be gone, though not sure
thanks to what, but that neither the cleaning nor the upgrade fixed
the warping mouse problem.

I'm running with these locking patches for two days now and the
mouse doesn't warp any more (it can also have fixed the stuck key
problem, not sure). Normally it would warp several times a day,
and that didn't happen yet, so I'm tempted to praise your patches.

Sorry for the babbling, just wanted to say that I've tested these
patches and that they seem to fix real problems.

Thanks,

Indan
