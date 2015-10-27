From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: keychord: Add keychord driver
Date: Tue, 27 Oct 2015 02:05:52 -0700
Message-ID: <20151027090552.GB12315@dtor-ws>
References: <1445935647-5799-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445935647-5799-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?B=E1lint?= Czobor <czoborbalint@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Mike Lockwood <lockwood@android.com>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 27, 2015 at 09:47:26AM +0100, B=E1lint Czobor wrote:
> From: Mike Lockwood <lockwood@android.com>
>=20
> This driver allows userspace to receive notification when client
> specified key combinations are pressed.
> The client opens /dev/keychord and writes a list of keychords
> for the driver to monitor.
> The client then reads or polls /dev/keychord for notifications.
> A client specified ID for the keychord is returned from read()
> when a keychord press is detected.
>=20
> Signed-off-by: Mike Lockwood <lockwood@android.com>
>=20
> keychord: fix to build without CONFIG_PREEMPT

Why does this need to be in the kernel?

Thanks.

--=20
Dmitry
