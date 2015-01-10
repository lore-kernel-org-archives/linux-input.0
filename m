From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/3] input: misc: Support NI Ettus Research USRP E3x0
 Button
Date: Sat, 10 Jan 2015 14:16:26 -0800
Message-ID: <20150110221626.GA9345@dtor-ws>
References: <1420761571-22903-1-git-send-email-moritz.fischer@ettus.com>
 <1420761571-22903-2-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57960 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbbAJWQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Jan 2015 17:16:31 -0500
Content-Disposition: inline
In-Reply-To: <1420761571-22903-2-git-send-email-moritz.fischer@ettus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Moritz,

On Fri, Jan 09, 2015 at 12:59:29AM +0100, Moritz Fischer wrote:
> +static struct platform_driver e3x0_button_driver = {
> +	.driver		= {
> +		.name	= "e3x0-button",
> +		.of_match_table = of_match_ptr(e3x0_button_match),

You forgot to assign .pm pointer here. I fixed it up and applied the
driver.

Thanks.

-- 
Dmitry
