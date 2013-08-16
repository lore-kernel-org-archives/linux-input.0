From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and trigger
 support
Date: Fri, 16 Aug 2013 12:33:54 +0100
Message-ID: <520E0E22.4000403@kernel.org>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com> <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com> <520CBEC6.8010400@kernel.org> <20130816100702.GD26895@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130816100702.GD26895-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 08/16/13 11:07, Sebastian Andrzej Siewior wrote:
> * Jonathan Cameron | 2013-08-15 12:43:02 [+0100]:
>=20
>> Hi,
> Hi Jonathan,
>=20
>> Whilst the below review is based on what we have here, I tried to ap=
ply it
>> to the latest iio.git togreg branch (which for this driver should be
>> much the same as staging-next and hence linux-next).  It's not even
>> close and I can't immediately spot where some of the changes came
>> from.  Have I missed a precursor patch or is this based on an
>> older version of this driver?
>=20
> I took the four patches, checkout iio/fixes-togreg and then
>=20
> |git am -3 iio.mbox
> |Applying: input: ti_am335x_tsc: correct step mask update after IRQ
> |Applying: input: ti_am335x_tsc: Increase sequencer delay time
> |Applying: input: ti_am335x_tsc: Enable shared IRQ for TSC, add overr=
un and underflow checks
> |Applying: iio: ti_am335x_adc: Add continuous sampling and trigger su=
pport
>=20
> It did apply with no trouble here.
> Let me look at your comments=E2=80=A6

Ah, fixes-togreg is for this cycle, whereas new stuff like this needs
to go on the togreg branch.  Hence please rebase on the togreg branch
instead.

That would explain it.
