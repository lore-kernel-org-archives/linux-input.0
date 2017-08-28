From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 2/2] dt-bindings: new binding for ps/2 gpio devices
Date: Mon, 28 Aug 2017 10:02:03 -0700
Message-ID: <20170828170203.GG12195@dtor-ws>
References: <20170821193142.29688-1-danilokrummrich@dk-develop.de>
 <20170821193142.29688-3-danilokrummrich@dk-develop.de>
 <20170825180323.g6pbqox5omeyuf4a@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170825180323.g6pbqox5omeyuf4a@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, rdunlap@infradead.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 25, 2017 at 01:03:23PM -0500, Rob Herring wrote:
> On Mon, Aug 21, 2017 at 09:31:42PM +0200, Danilo Krummrich wrote:
> > The PS/2 gpio device binding defines the gpio pins (data and clock)
> > as well as the interrupt which should be used to drive the ps/2 bus.
> > It is expected to get an interrupt on the falling edge of the clock
> > line.
> > 
> > Also it can be configured whether the host should support writing to
> > the device.
> > 
> > Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> > ---
> >  .../devicetree/bindings/serio/ps2-gpio.txt         | 23 ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thank you.

> 

-- 
Dmitry
