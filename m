From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 4/8] clk: mmp2: add SP clock
Date: Tue, 02 Oct 2018 00:18:30 -0700
Message-ID: <153846471096.119890.948010578540326036@swboyd.mtv.corp.google.com>
References: <20180910112654.42061-1-lkundrak@v3.sk>
 <20180910112654.42061-5-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112654.42061-5-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Quoting Lubomir Rintel (2018-09-10 04:26:50)
> The "security processor", sometimes referred to as "wireless trusted
> module" or "generic encrypt unit" is a low-power core present on MMP2,
> that has nothing to do with security, wireless, trust or encryption.
> =

> On an OLPC machine it runs CForth and serves as a keyboard controller:
> http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.f=
th
> =

> The register address was obtained from the OLPC kernel, since the
> datasheet seems to be the Marvell's most important business secret.
> =

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
