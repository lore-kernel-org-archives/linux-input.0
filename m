From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] Input: gpio_keys - replace timer and workqueue with
 delayed workqueue
Date: Mon, 15 Dec 2014 12:20:49 +0200
Message-ID: <1418638849.17201.65.camel@linux.intel.com>
References: <20141208071930.GA20802@dtor-ws>
	 <20141208072124.GA21031@dtor-ws>
	 <1418236376.17201.57.camel@linux.intel.com>
	 <20141213190926.GD22702@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50242 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbaLOKUt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2014 05:20:49 -0500
In-Reply-To: <20141213190926.GD22702@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, Linus Walleij <linus.walleij@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Alexander Shiyan <shc_work@mail.ru>, Laxman Dewangan <ldewangan@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2014-12-13 at 11:09 -0800, Dmitry Torokhov wrote:
> Hi Andy,
> 
> On Wed, Dec 10, 2014 at 08:32:56PM +0200, Andy Shevchenko wrote:
> > On Sun, 2014-12-07 at 23:21 -0800, Dmitry Torokhov wrote:
> > > We do not need to roll our own implementation of delayed work now that we
> > > have proper implementation of mod_delayed_work.
> > > 
> > > For interrupt-only driven buttons we retain the timer, but we rename
> > > it to release_timer to better reflect its purpose.
> > 
> > At least it doesn't break the driver on Intel Medfield device.
> > 
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you for testing it. Assume it is for both patches, right?

Right.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

