From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] mfd: cpcap: implement irq sense helper
Date: Thu, 2 Mar 2017 07:17:32 -0800
Message-ID: <20170302151732.GN20572@atomide.com>
References: <20170224085909.30559-1-sre@kernel.org>
 <20170302002242.21819-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302002242.21819-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170301 16:24]:
> CPCAP can sense if IRQ is currently set or not. This
> functionality is required for a few subdevices, such
> as the power button and usb phy modules.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv1:
>  - Newly introduced patch

Works for me:

Acked-by: Tony Lindgren <tony@atomide.com>
