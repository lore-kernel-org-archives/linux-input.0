From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Fri, 22 May 2015 10:32:40 +0900
Message-ID: <20150522013239.GE27511@verge.net.au>
References: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
 <1432208546-18615-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432208546-18615-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 21, 2015 at 01:42:25PM +0200, Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> DT nodes should use the more specific adi,adxl345 and adi,adxl346
> compatible values instead. As the ADXL346 is backward-compatible with
> the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
> in that order.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add Acked-by.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

