From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Tue, 12 Sep 2017 09:17:27 -0500
Message-ID: <20170912141727.im7axya5ouxxtrl4@rob-hp-laptop>
References: <1503392618-26853-1-git-send-email-anthony.kim@hideep.com>
 <1505114862-32489-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505114862-32489-1-git-send-email-anthony.kim@hideep.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Kim <anthony.kim@hideep.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 11, 2017 at 04:27:42PM +0900, Anthony Kim wrote:
> The HiDeep touchscreen device is a capacitive multi-touch controller
> mainly for multi-touch supported devices use. It use I2C interface for
> communication to IC and provide axis X, Y, Z locations for ten finger
> touch through input event interface to userspace.
> 
> It support the Crimson and the Lime two type IC. They are different
> the number of channel supported and FW size. But the working protocol
> is same.
> 
> Signed-off-by: Anthony Kim <anthony.kim@hideep.com>
> ---
>  .../bindings/input/touchscreen/hideep.txt          |   42 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |   11 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/hideep.c                 | 1274 ++++++++++++++++++++
>  5 files changed, 1329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>  create mode 100644 drivers/input/touchscreen/hideep.c
