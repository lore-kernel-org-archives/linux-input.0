From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Date: Mon, 29 Jul 2019 19:26:07 +0200
Message-ID: <20190729172607.GB755@penguin>
References: <1564415994-22871-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1564415994-22871-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Enrico,

On Mon, Jul 29, 2019 at 05:59:53PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Support the recently introduced gpio lookup tables for
> attaching to gpio lines. So, harcoded gpio numbers aren't
> needed anymore.
> 
> changes v3:
>     * fix printf string in gpio_keys_polled_get_gpiod()
>     * fix unused variable 'error' in gpio_keys_polled_get_gpiod()
>     * fix uninitialized variable in gpio_keys_polled_get_gpiod_fwnode()

As I think I mentioned a while back I would prefer to get gpiolob
support swnode-backed properties so that the driver would not need to
know about differences between ACPI, DT and static board files.

I just recently re-posted patches for this, let's see if we can get them
landed in the kernel.

Thanks.

-- 
Dmitry
