From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] input: st1232: Add reset pin handling
Date: Mon, 8 Apr 2013 10:39:02 +0900
Message-ID: <20130408013902.GC13103@verge.net.au>
References: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

On Sat, Apr 06, 2013 at 03:18:45PM +0200, Bastian Hecht wrote:
> We add the possiblity to hand over a GPIO number for the reset pin.
> This way we can remove existing board code that takes care of it and
> group this information properly in the platform data or in the device
> tree confguration.
> 
> The implementation is analogous to the cy8ctmg110 driver, thanks.

Laurent, could I get a review from you of this and the following patch?
