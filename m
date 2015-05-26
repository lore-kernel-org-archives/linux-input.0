From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:keyboard:samsung-keypad - Fix for correct return
 type
Date: Tue, 26 May 2015 13:41:33 -0700
Message-ID: <20150526204133.GA27149@dtor-ws>
References: <1432573204-2923-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34735 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbEZUli (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 16:41:38 -0400
Content-Disposition: inline
In-Reply-To: <1432573204-2923-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Ferruh Yigit <fery@cypress.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 25, 2015 at 10:30:04PM +0530, Shailendra Verma wrote:
> The return type of the function samsung_keypad_report() is bool but we are
> returning the unsigned int value.So changing the unsigned int to bool type
> and initializing with false.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/input/keyboard/samsung-keypad.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index 6b9fdf6..44b1ba9 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -112,7 +112,7 @@ static bool samsung_keypad_report(struct samsung_keypad *keypad,
>  	struct input_dev *input_dev = keypad->input_dev;
>  	unsigned int changed;
>  	unsigned int pressed;
> -	unsigned int key_down = 0;
> +	bool key_down = false;

No, this causes conversion bool->unsigned int->bool on every iteration
of the loop.

Thanks.

-- 
Dmitry
