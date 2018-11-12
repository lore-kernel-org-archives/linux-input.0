From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 0/6] OLPC 1.75 Keyboard/Touchpad fixes
Date: Mon, 12 Nov 2018 03:30:23 +0100
Message-ID: <20181112023029.648408-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

This makes keyboard/touchpad work on a DT MMP2 platform.

Changes since v1:
- Collected Acks
- Replaced "Input: olpc_apsp: depend on CONFIG_OF" patch with "Input:
  olpc_apsp: drop CONFIG_OLPC dependency", since it was correctly
  pointed out that the driver doesn't actually depend on OF.
- Dropped "Input: olpc_apsp: allocate the GPIOs used" and "dt-bindings:
  olpc,ap-sp: add GPIO lines" since at the moment they are not useful
  for much more than documenting the lines the SP uses and actually
  claiming them was deemed not to be a good idea.
- Fixed error handling in the "enable the SP clock" patch.

Cheers
Lubo
