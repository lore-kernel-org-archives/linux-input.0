From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH]input: Change timer function to workqueue for gpio_keys
 driver
Date: Thu, 25 Jun 2009 23:48:46 +0800
Message-ID: <20090625234846.1b987069@dxy.sh.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758843AbZFYPyB@vger.kernel.org>
In-Reply-To: <1245944528.20530.145.camel@jani-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>
List-Id: linux-input@vger.kernel.org

On Thu, 25 Jun 2009 23:42:08 +0800
Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:

> On Thu, 2009-06-25 at 17:09 +0200, ext Alek Du wrote:
> > On Thu, 25 Jun 2009 23:05:55 +0800
> > Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:
> > > Actually scrap that, the input layer already ignores events with no
> > > state changes, right?
> > > 
> > Yes, correct. I just want to reply your previous mail, but seems you find that. :-)
> 
> The point about your patch breaking debouncing is still valid, though.
> 
>
How? If IRQ triggered then the delay work scheduled, after debouncing time, in work, it checks GPIO pin state again,
if pin is active, send "1" to input layer -- key pressed, if de-active, send "0" -- no event. 

I really did test on my board, could you also try it out?

Thanks,
Alek
> BR,
> Jani.
> 
> 
