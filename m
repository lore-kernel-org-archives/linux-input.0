From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 0/3] Stop managing the SP clock
Date: Mon, 21 Jan 2019 07:22:53 +0100
Message-ID: <20190121062255.551587-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Per discussion in [1] it seems that the kernel has no business managing
this clock: once the SP clock is disabled, it's not sufficient to just
enable it in order to bring the SP core back up.

Just let the firmware keep it enabled and don't expose it to drivers.

[1] https://lore.kernel.org/lkml/154783267051.169631.3197836544646625747@=
swboyd.mtv.corp.google.com/

The "secure processor" (SP) core runs the keyboard firmware on the
OLPC XO 1.75 laptop.

Lubo
