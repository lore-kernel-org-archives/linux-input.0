From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Date: Wed, 10 Apr 2013 11:11:27 +0200
Message-ID: <3156128.fKWFDgdS29@avalon>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com> <20130410065114.GA21515@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130410065114.GA21515@core.coreip.homeip.net>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Tuesday 09 April 2013 23:51:14 Dmitry Torokhov wrote:
> On Mon, Apr 08, 2013 at 02:52:26PM +0200, Bastian Hecht wrote:

[snip]

> > +		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
> 
> Frankly I do not like mixing managed and noon-managed resources. Maybe
> the entire driver needs to be converted to managed resources?

I've just sent a patch to do so.

-- 
Regards,

Laurent Pinchart

