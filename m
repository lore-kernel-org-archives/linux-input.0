From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Mon, 27 Jul 2015 15:43:00 -0700
Message-ID: <20150727224300.GG3613@dtor-ws>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add device tree bindings for the DA9062 OnKey driver component
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> Changes in V3:
>  - Child driver specifics separated out into separate document
>    in this case ../input/da9062-onkey.txt
> Changes in V2:
>  - No change
> 
> This patch applies against linux-next and next-20150708 
> 
> 
>  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++

I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
9063, folded into the onkey patch and applied.

Thanks.
 
-- 
Dmitry
