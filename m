From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH] Input: stmfts - acknowledge that setting brightness is a
 blocking call
Date: Thu, 7 Feb 2019 09:36:44 +0200
Message-ID: <20190207073644.GA3721@jack.zhora.eu>
References: <20190205224642.GA182156@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205224642.GA182156@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Andi Shyti <andi@etezian.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, Feb 05, 2019 at 02:46:42PM -0800, Dmitry Torokhov wrote:
> We need to turn regulators on and off when switching brightness, and
> that may block, therefore we have to set stmfts_brightness_set() as
> LED's brightness_set_blocking() method.
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Andi Shyti <andi@etezian.org>

Thanks,
