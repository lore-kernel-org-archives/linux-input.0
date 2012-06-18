From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 14/22 v4] Input: atmel_mxt_ts - don't re-read matrix after
 applying pdata
Date: Mon, 18 Jun 2012 16:03:33 +0100
Message-ID: <4FDF4345.40508@itdev.co.uk>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org> <1339992522-22073-15-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:33041 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752526Ab2FRPDh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 11:03:37 -0400
In-Reply-To: <1339992522-22073-15-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org

Daniel Kurtz wrote:
> The matrix x/y size in the Info ID Block represents the number of x/y
> trace lines on the device.  There is no need to re-read them after
> applying pdata config, since pdata only configures the object table
> etnries.  The matrix size read from the ID can only be updated by a
> firmware update.

This isn't correct. For example, mXT224 can be configured as 16x14, 17x13,
18x12, etc. This only takes effect when the chip is reset, which is why it
is necessary to re-read them after applying the config.

cheers

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
