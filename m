From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 2/2] input: cpcap-pwrbutton: new driver
Date: Thu, 2 Mar 2017 10:01:17 -0800
Message-ID: <20170302180116.GR20572@atomide.com>
References: <20170224085909.30559-1-sre@kernel.org>
 <20170302002242.21819-1-sre@kernel.org>
 <20170302002242.21819-2-sre@kernel.org>
 <20170302012004.GI30349@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302012004.GI30349@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [170301 17:21]:
> On Thu, Mar 02, 2017 at 01:22:42AM +0100, Sebastian Reichel wrote:
> > Motorola CPCAP is a PMIC found in multiple smartphones.
> > This driver adds support for the power/on button and has
> > been tested in Droid 4.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> > Changes since PATCHv1:
> >  - Fix device for devm_request_threaded_irq()
> >  - Add Acked-By from Rob Herring (for the DT binding)
> >  - Use newly introduced cpcap_sense_virq to sense the IRQ pin
> 
> OK, so will this be merged through MFD? If so:
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Ideally we'd have an immutable branch against v4.11-rc1 when out
with just these two patches somewhere that can get merged in as
needed to MFD or input tree.

Anyways, this driver still works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
