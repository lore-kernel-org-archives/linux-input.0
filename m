From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Date: Wed, 10 Oct 2018 16:24:56 +0200
Message-ID: <20181010142504.233467-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This makes keyboard/touchpad work on a DT MMP2 platform.

I believe that it would be a good idea if this, once reviewed, went in
via the input tree. The DT and CLK parts got reviews/acks.

Changes from v1:
- Basically none, just re-send, including Ack and Review tags in patches
  that received them. Plus an extra Cc.
  I'd be very thankful for reviews.

Lubi
