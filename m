From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - Fix double URB submission races
Date: Wed, 29 Jul 2015 23:45:45 -0700
Message-ID: <20150730064545.GA35939@dtor-ws>
References: <1438205243-14722-1-git-send-email-labbott@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36253 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbG3Gpu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 02:45:50 -0400
Content-Disposition: inline
In-Reply-To: <1438205243-14722-1-git-send-email-labbott@fedoraproject.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laura Abbott <labbott@fedoraproject.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hi Laura,

On Wed, Jul 29, 2015 at 02:27:23PM -0700, Laura Abbott wrote:
@@ -791,6 +796,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
>  {
>  	struct usb_xpad *xpad = input_get_drvdata(dev);
>  
> +	if (test_and_set_bit(OUT_IRQ_SUBMITTED, &xpad->odata_flags))
> +		return 0;
> +

So this results in basically ignoring the request if urb is "busy" which
is not the best way of handling this. You need to note that there is
pending effect to be played and submit it after currently executing
request completes.

The same needs to be done for led toggling request.

Thanks.

-- 
Dmitry
