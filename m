From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Date: Fri, 19 Apr 2019 07:48:11 +0000
Message-ID: <20190419074811.7rkq3p6t7s56g4fo@penguin>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-4-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555444645-15156-4-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Enrico,

On Tue, Apr 16, 2019 at 09:57:24PM +0200, Enrico Weigelt, metux IT consult wrote:
> Support the recently introduced gpio lookup tables for
> attaching to gpio lines. So, harcoded gpio numbers aren't
> needed anymore.

I would prefer if gpiod API could parse static board data/gpio lookup
tables for child nodes, instead of adding this to gpio-keys. Now that
Heikki Krogerus work on software nodes has landed I need to resurrect
my patch to gpiolib.

Thanks.

-- 
Dmitry
