From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: joystick - use sizeof(VARIABLE) in
 documentation
Date: Mon, 16 Dec 2013 01:51:41 -0800
Message-ID: <20131216095140.GA15405@core.coreip.homeip.net>
References: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
 <1387184235-20169-3-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41072 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3LPJvt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 04:51:49 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so5218774pbb.16
        for <linux-input@vger.kernel.org>; Mon, 16 Dec 2013 01:51:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387184235-20169-3-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

Hi Antonio,

On Mon, Dec 16, 2013 at 09:57:15AM +0100, Antonio Ospite wrote:
> @@ -181,7 +181,7 @@ at a time using the typical read(2) functionality. For that, you would
>  replace the read above with something like
>  
>  	struct js_event mybuffer[0xff];
> -	int i = read (fd, mybuffer, sizeof(struct mybuffer));
> +	int i = read (fd, mybuffer, ARRAY_SIZE(mybuffer));
>  

This is wrong, as ARRAY_SIZE(mybuffer) would be 0xff and not the size of
buffer in bytes. I'll fix it up.

Thanks.

-- 
Dmitry
