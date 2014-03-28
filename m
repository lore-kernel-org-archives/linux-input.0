From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] input: Add new driver for ARM CLPS711X keypad
Date: Fri, 28 Mar 2014 09:42:28 -0700
Message-ID: <20140328164228.GA7582@core.coreip.homeip.net>
References: <1395165739-17378-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:51927 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaC1Qmc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 12:42:32 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so5121984pdj.27
        for <linux-input@vger.kernel.org>; Fri, 28 Mar 2014 09:42:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1395165739-17378-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Tue, Mar 18, 2014 at 10:02:19PM +0400, Alexander Shiyan wrote:
> +	err = input_register_polled_device(poll_dev);
> +	if (!err) {
> +		/* Report initial state */
> +		clps711x_keypad_poll(poll_dev);
> +
> +		return 0;
> +	}

The polled device core will report initial state when input device is
opened (as long as polling is enabled) so I removed this cunk and
applied the rest.

Thanks.

-- 
Dmitry
