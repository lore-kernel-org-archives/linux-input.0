From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
Date: Thu, 24 Jan 2019 10:55:48 -0800
Message-ID: <154835614871.136743.8711596686877554586@swboyd.mtv.corp.google.com>
References: <20190121062255.551587-1-lkundrak@v3.sk> <20190121062255.551587-2-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121062255.551587-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:22:54)
> Turns out this is not such a great idea. Once the SP clock is disabled,
> it's not sufficient to just enable in order to bring the SP core back up.
>=20
> It seems that the kernel has no business managing this clock. Just let
> the firmware keep it enabled.
>=20
> This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.
>=20
> Link: https://lore.kernel.org/lkml/154783267051.169631.319783654464662574=
7@swboyd.mtv.corp.google.com/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-fixes
