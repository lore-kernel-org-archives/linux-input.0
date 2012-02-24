From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: psmouse:  create an 'enabled' sysfs attribute to
 squelch mouse
Date: Fri, 24 Feb 2012 00:21:58 -0800
Message-ID: <20120224082158.GA18291@core.coreip.homeip.net>
References: <20120217180634.6162196e@debxo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120217180634.6162196e@debxo>
Sender: linux-kernel-owner@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Fox <pgf@laptop.org>, Martin Langhoff <martin@laptop.org>
List-Id: linux-input@vger.kernel.org

Hi Andres,

On Fri, Feb 17, 2012 at 06:06:34PM -0800, Andres Salomon wrote:
> 
> From: Paul Fox <pgf@laptop.org>
> 
> on OLPC XO laptops, at least one model of touchpad (sentelic)
> emits continuous jittery motion reports when the laptop is
> configured in "ebook" mode.  the touchpad is inaccessible in
> that configuration, so we simply disable it.
> 
> these motion reports will wake the SoC when put to sleep, so simply
> ignoring the events is not a possibilty; the device must be disabled.

Can you switch the AUX serio port into manual bind mode (viqa sysfs) and
simply connect/disconnect the touchpad as needed (again via sysfs)?

Thanks.

-- 
Dmitry
