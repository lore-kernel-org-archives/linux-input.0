From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: focaltech - mark focaltech_set_resolution() static
Date: Mon, 5 Sep 2016 10:33:46 -0700
Message-ID: <20160905173346.GB12404@dtor-ws>
References: <1472632661-32159-1-git-send-email-baoyou.xie@linaro.org>
 <5089277.G6NWohFGP5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33160 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935612AbcIERdu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Sep 2016 13:33:50 -0400
Content-Disposition: inline
In-Reply-To: <5089277.G6NWohFGP5@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, pali.rohar@gmail.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, xie.baoyou@zte.com.cn

On Wed, Aug 31, 2016 at 11:58:50AM +0200, Arnd Bergmann wrote:
> On Wednesday, August 31, 2016 4:37:41 PM CEST Baoyou Xie wrote:
> > We get 1 warning when building kernel with W=1:
> > drivers/input/mouse/focaltech.c:393:6: warning: no previous prototype for 'focaltech_set_resolution' [-Wmissing-prototypes]
> > 
> > In fact, this function is only used in the file in which it is
> > declared and don't need a declaration, but can be made static.
> > So this patch marks it 'static'.
> > 
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.


-- 
Dmitry
