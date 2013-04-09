From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Date: Tue, 9 Apr 2013 11:23:51 +0200
Message-ID: <CABYn4sxYo6h5ZLQRPJcQ1iGhgGFLTaK9y=vNfcHa_4ED1FuKYA@mail.gmail.com>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
	<2096590.pSU6Gke5Ke@avalon>
	<20130409082833.GE18478@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130409082833.GE18478@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Simon,

2013/4/9 Simon Horman <horms@verge.net.au>:
> On Mon, Apr 08, 2013 at 04:17:20PM +0200, Laurent Pinchart wrote:
>> Hi Bastian,
>>
>> Thanks for the patch.
>>
>> On Monday 08 April 2013 14:52:26 Bastian Hecht wrote:
>> > We add the possiblity to hand over a GPIO number for the reset pin.
>> > This way we can remove existing board code that takes care of it and
>> > group this information properly in the platform data or in the device
>> > tree confguration.
>> >
>> > The implementation is analogous to the cy8ctmg110 driver, thanks.
>> >
>> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Bastian, I'm unclear on which tree this will go through.
> Please let me know if it is mine.

To be honest, no idea. If it doesn't have to be a maintainer of
linux-input, I would be glad if you could take up that patch in your
tree, yes. And for your information, I don't rely on it until the pfc
DT version is merged. Then it would be nice to have it for the
touchscreen in the arma reference implementation.

Thanks,
 Bastian
