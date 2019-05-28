From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/8] Fix Elan I2C touchpads in latest generation from
 Lenovo
Date: Mon, 27 May 2019 18:46:26 -0700
Message-ID: <20190528014626.GB193221@dtor-ws>
References: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, May 24, 2019 at 03:50:38PM +0200, Benjamin Tissoires wrote:
> Here comes the v3.
> 
> Very few changes from v2:
> - dropped the last 2 patches where I tried to be smart, and it turns out
>   that it was not very a good idea
> - also removed the only other blacklisted model, as it has been tested with
>   the v2 and it is also now working properly

Applied the lot, thank you.

> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (8):
>   Input: elantech - query the min/max information beforehand too
>   Input: elantech - add helper function elantech_is_buttonpad()
>   Input: elantech - detect middle button based on firmware version
>   dt-bindings: add more optional properties for elan_i2c touchpads
>   Input: elan_i2c - do not query the info if they are provided
>   Input: elantech/SMBus - export all capabilities from the PS/2 node
>   Input: elan_i2c - handle physical middle button
>   Input: elantech: remove P52 and P72 from SMBus blacklist
> 
>  .../devicetree/bindings/input/elan_i2c.txt    |  11 +
>  drivers/input/mouse/elan_i2c_core.c           |  72 +++-
>  drivers/input/mouse/elantech.c                | 320 ++++++++++--------
>  drivers/input/mouse/elantech.h                |   8 +
>  4 files changed, 246 insertions(+), 165 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
Dmitry
