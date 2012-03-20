From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 16/20] Input: atmel_mxt_ts - refactor get info
Date: Tue, 20 Mar 2012 08:21:51 -0700
Message-ID: <4F68A08F.6020908@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-17-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:52844 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755536Ab2CTPVy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:21:54 -0400
In-Reply-To: <1331640263-18935-17-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Bowens, Alan" <Alan.Bowens@atmel.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>

Daniel Kurtz wrote:
> Read whole info block in one i2c transaction.
> And then re-read the matrix size after applying pdata config, since
> it may have changed.
> Note, however, that the matrix x & y size are just displayed for
> information purposes.  They aren't actually used by the driver itself.
>
> Also, parse and info print the firmware major and minor version numbers.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
