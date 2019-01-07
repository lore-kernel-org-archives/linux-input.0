From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/7] Input: tm2-touchkey: Add support for Aries and
 Midas
Date: Mon, 7 Jan 2019 11:53:31 -0800
Message-ID: <20190107195331.GC141497@dtor-ws>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 07, 2019 at 07:53:39PM +0100, Paweł Chmiel wrote:
> This patches adds support for Aries (Samsung i9000) and Midas (Samsung S3)
> based devices to TM2 Touchkey driver.

Applied the lot, thank you.

> 
> Changes from v2:
>   - Change property name from keycodes to linux,keycodes
> 
> Changes from v1:
>   - Added Reviewed-by to some patches
>   - Use ints for keycodes (they could be bigger than 255)
>   - Droped separate name changes
>   - Added missing const in few places
>   - Removed redundant cast
> 
> Jonathan Bakker (5):
>   Input: tm2-touchkey: Correct initial brightness
>   Input: tm2-touchkey: Allow specifying custom keycodes
>   Input: dt-bindings: tm2-touchkey: Document new keycodes property
>   Input: tm2-touchkey: Add support for aries touchkey variant
>   Input: dt-bindings: tm2-touchkey: Add support for aries touchkey
> 
> Simon Shields (2):
>   Input: tm2-touchkey: Add support for midas touchkey
>   Input: dt-bindings: tm2-touchkey: Add support for midas touchkey
> 
>  .../bindings/input/cypress,tm2-touchkey.txt   |   9 +-
>  drivers/input/keyboard/tm2-touchkey.c         | 132 +++++++++++++-----
>  2 files changed, 108 insertions(+), 33 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Dmitry
