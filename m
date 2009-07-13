From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xpad: If the outgoing request was sent successfully
	don't try to send it again
Date: Sun, 12 Jul 2009 21:06:49 -0700
Message-ID: <20090713040648.GI10819@dtor-d630.eng.vmware.com>
References: <74d457500906301556y7aacdf12haacc749fc0f883d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:53850 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZGMEGy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 00:06:54 -0400
Received: by rv-out-0506.google.com with SMTP id f6so555715rvb.1
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2009 21:06:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <74d457500906301556y7aacdf12haacc749fc0f883d2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Gruber <lists.mg@googlemail.com>
Cc: linux-input@vger.kernel.org

On Wed, Jul 01, 2009 at 12:56:32AM +0200, Michael Gruber wrote:
> From: Michael Gruber <lists.mg@googlemail.com>
> 
> This avoids an infinite loop.
> 
> Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
> 
> ---
> 
> Now my LED will finally stop blinking...

Applied, thank you Michael.

-- 
Dmitry
