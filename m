From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH]input: Change timer function to workqueue for gpio_keys
 driver
Date: Fri, 26 Jun 2009 00:23:45 +0800
Message-ID: <20090626002345.07928230@dxy.sh.intel.com>
References: <20090608152420.0e76c302@dxy.sh.intel.com>
	<5d5443650906121040n3f36c99eka01f5eb5274ee6ff@mail.gmail.com>
	<359ed6810906250329x70cf380cy278f23e3ebc6a829@mail.gmail.com>
	<20090625210642.432e08a5@dxy.sh.intel.com>
	<1245936693.20530.107.camel@jani-desktop>
	<20090625220826.1fa7413e@dxy.sh.intel.com>
	<1245941565.20530.134.camel@jani-desktop>
	<1245942355.20530.141.camel@jani-desktop>
	<20090625230949.53beda65@dxy.sh.intel.com>
	<1245944528.20530.145.camel@jani-desktop>
	<20090625234846.1b987069@dxy.sh.intel.com>
	<1245946154.9103.742.camel@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7975 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbZFYQ2n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2009 12:28:43 -0400
In-Reply-To: <1245946154.9103.742.camel@pcarmody-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>
Cc: "Nikula Jani.1 (EXT-Nixu/Helsinki)" <ext-jani.1.nikula@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>

On Fri, 26 Jun 2009 00:09:14 +0800
Phil Carmody <ext-phil.2.carmody@nokia.com> wrote:

> If you stopped calling the delay after the first transition "debouncing
> time" and simply called it a "delay" you might more easily see that it
> does *no* debouncing at all. Imagine putting noise on the line
> constantly - the original code's timer would never expire. Your timer
> will expire after a delay, and while the line is still toggling
> frantically - you've not debounced.

I don't know if it is really meaningful if you want to handle such pool signal... 
Ok, if you want to handle this ultimate case, will this patch work?

        BUG_ON(irq != gpio_to_irq(button->gpio));

+       cancel_delayed_work_sync(&bdata->work);
        delay = button->debounce_interval ?
                        msecs_to_jiffies(button->debounce_interval) : 0;
        schedule_delayed_work(&bdata->work, delay);

Alek
> Please investigate the meaning and implications of "debouncing" before
> claiming your code does it.
> 
> Phil
> 
