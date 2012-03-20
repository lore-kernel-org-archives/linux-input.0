From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 17/20] Input: atmel_mxt_ts - use cached T9 reportid range
 in isr
Date: Tue, 20 Mar 2012 08:30:34 -0700
Message-ID: <4F68A29A.7060700@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-18-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:42147 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755008Ab2CTPal (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:30:41 -0400
In-Reply-To: <1331640263-18935-18-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

Daniel Kurtz wrote:
> Streamline interrupt processing by caching the T9 reportid range when
> first initializing the object table.
> 
> Note: the cached T9 reportid's are initialized to 0, which is an invalid
> reportid.  Thus, the checks in the interrupt handler will always fail
> for devices that do not support the T9 object.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

You need to support the case where there are multiple T9 instances.

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
