From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] Input: goodix - Tweak configuration to use passed in
 touchscreen resolution
Date: Wed, 26 Oct 2016 18:10:23 -0500
Message-ID: <20161026231023.ate6tffbmtlx6mng@rob-hp-laptop>
References: <20161020195917.20051-1-fcooper@ti.com>
 <20161020195917.20051-4-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161020195917.20051-4-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: dmitry.torokhov@gmail.com, hadess@hadess.net, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com
List-Id: linux-input@vger.kernel.org

On Thu, Oct 20, 2016 at 02:59:16PM -0500, Franklin S Cooper Jr wrote:
> Some goodix touchscreen controllers aren't programed properly to match the
> display panel it is used on. Although the defaults may largely work it is
> also likely that the screen resolution will be incorrect. Therefore,
> add support to allow via DT for the touchscreen resolution to be set and
> reprogram the controller to use this updated resolution.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/goodix.c                 | 26 +++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
