From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"
Date: Thu, 24 Jan 2019 10:56:20 -0800
Message-ID: <154835618070.136743.10161536507964722189@swboyd.mtv.corp.google.com>
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-4-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121062255.551587-4-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:22:56)
> It seems that the kernel has no business managing this clock: once the SP
> clock is disabled, it's not sufficient to just enable it in order to bring
> the SP core back up.
>=20
> Pretty sure nothing ever used this and it's safe to remove.
>=20
> This reverts commit e8a2c779141415105825e65a4715f1130bba61b1.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-fixes
