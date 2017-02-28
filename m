From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] input: cpcap-pwrbutton: new driver
Date: Mon, 27 Feb 2017 18:18:38 -0600
Message-ID: <20170228001838.remv3klpgmtpyi2r@rob-hp-laptop>
References: <20170224085909.30559-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170224085909.30559-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 24, 2017 at 09:59:09AM +0100, Sebastian Reichel wrote:
> Motorola CPCAP is a PMIC found in multiple smartphones.
> This driver adds support for the power/on button and has
> been tested with Droid 4.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/input/cpcap-pwrbutton.txt  |  20 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/misc/Kconfig                         |  10 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/cpcap-pwrbutton.c               | 119 +++++++++++++++++++++
>  4 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 drivers/input/misc/cpcap-pwrbutton.c
