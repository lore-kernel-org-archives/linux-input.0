From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
Date: Thu, 24 Jan 2019 10:53:23 -0800
Message-ID: <154835600359.136743.8585628353385883771@swboyd.mtv.corp.google.com>
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-2-lkundrak@v3.sk> <20190123220545.GD179701@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123220545.GD179701@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Quoting Dmitry Torokhov (2019-01-23 14:05:45)
> On Mon, Jan 21, 2019 at 07:22:54AM +0100, Lubomir Rintel wrote:
> > Turns out this is not such a great idea. Once the SP clock is disabled,
> > it's not sufficient to just enable in order to bring the SP core back u=
p.
> >=20
> > It seems that the kernel has no business managing this clock. Just let
> > the firmware keep it enabled.
> >=20
> > This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.
> >=20
> > Link: https://lore.kernel.org/lkml/154783267051.169631.3197836544646625=
747@swboyd.mtv.corp.google.com/
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> OK, as clock folks say it is a bad idea it must be so. Merge though clk
> tree?
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20

Ok sure. I'll merge them through clk tree. I'll fast track it through
clk-fixes too.
