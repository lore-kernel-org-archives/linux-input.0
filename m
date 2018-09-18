From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: uinput - allow for max == min during
 input_absinfo validation
Date: Tue, 18 Sep 2018 10:05:07 -0700
Message-ID: <20180918170507.GD177805@dtor-ws>
References: <20180918052256.GA23446@jelly>
 <19cbcf47-4ab4-7dd0-392a-9a47b7264999@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19cbcf47-4ab4-7dd0-392a-9a47b7264999@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 18, 2018 at 01:13:47PM +0200, Martin Kepplinger wrote:
> On 9/18/18 7:22 AM, Peter Hutterer wrote:
> > These values are inclusive, so a range of 1 requires min == max.
> > 
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> 
> true, nice catch.
> 
> Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Applied, thank you.

-- 
Dmitry
