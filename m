From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/3] Revert "clk: mmp2: add SP clock"
Date: Thu, 24 Jan 2019 10:56:09 -0800
Message-ID: <154835616940.136743.9426109859913925018@swboyd.mtv.corp.google.com>
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121062255.551587-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:22:55)
> It seems that the kernel has no business managing this clock: once the SP
> clock is disabled, it's not sufficient to just enable in order to bring t=
he
> SP core back up. Just let the firmware keep it enabled and don't expose it
> to drivers.
>=20
> This reverts commit fc27c2394d96fd19854b7e2d3f0e60df0d86fc90.
>=20
> Link: https://lore.kernel.org/lkml/154783267051.169631.319783654464662574=
7@swboyd.mtv.corp.google.com/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-fixes
