From: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
Date: Thu, 6 Dec 2018 01:26:42 +0530
Message-ID: <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-5-jagan@amarulasolutions.com> <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 3, 2018 at 4:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > vcc-supply property is need for some Goodix CTP controller like GT5663
> > where 3.3V external pull-up regulator connected via controller VCC pin.
>
> "External pull-up regulator" sounds fishy. Chips have power supply
> pins, either combined, or separate rails for analog, digital, and I/O.
> For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
> and description you provide match none of these.

We have vcc pin in the connector to supply vcc-ctp, but indeed it is
AVDD28 supply as per the reference schematic design[1] Page 23.  Host
interface has AVDD pin which is connected to ADVDD28 on goodix chip,
so I can name this as avdd28-supply. is that OK?

[1] https://www.crystalfontz.com/controllers/GOODIX/GT5663/459/
