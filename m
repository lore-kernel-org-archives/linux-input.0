From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH] Input: tm2-touchkey - acknowledge that setting
 brightness is a blocking call
Date: Thu, 7 Feb 2019 09:42:51 +0200
Message-ID: <20190207074251.GB3721@jack.zhora.eu>
References: <20190206181616.GA204279@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206181616.GA204279@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, Jonathan Bakker <xc-racer2@live.ca>, Andi Shyti <andi@etezian.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, Feb 06, 2019 at 10:16:16AM -0800, Dmitry Torokhov wrote:
> We need to access I2C bus when switching brightness, and that may block,
> therefore we have to set stmfts_brightness_set() as LED's
> brightness_set_blocking() method.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

same here:

Acked-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
