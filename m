From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Date: Wed, 10 Apr 2013 23:38:00 +0200
Message-ID: <CABYn4sx+9aOTsKfTHOcEtBH2U9V641tmbvvYmEGujpacKSD2HA@mail.gmail.com>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
	<20130410065114.GA21515@core.coreip.homeip.net>
	<3156128.fKWFDgdS29@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:43318 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab3DJViC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Apr 2013 17:38:02 -0400
In-Reply-To: <3156128.fKWFDgdS29@avalon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi all,

2013/4/10 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Dmitry,
>
> On Tuesday 09 April 2013 23:51:14 Dmitry Torokhov wrote:
>> On Mon, Apr 08, 2013 at 02:52:26PM +0200, Bastian Hecht wrote:
>
> [snip]
>
>> > +           error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
>>
>> Frankly I do not like mixing managed and noon-managed resources. Maybe
>> the entire driver needs to be converted to managed resources?
>
> I've just sent a patch to do so.

Thanks Laurent! I've tested it - works fine.

Dimitri, I've addressed your suggestions and use gpio_valid and have
reordered the probing for platform and OF data. Thanks for your
feedback. I've based my changes on top of it and will post it shortly.

Cheers,

 Bastian
