From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 08/20] Input: atmel_mxt_ts - store actual size and instance
Date: Tue, 20 Mar 2012 08:05:42 -0700
Message-ID: <4F689CC6.7020706@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-9-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:33620 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753526Ab2CTPFq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:05:46 -0400
In-Reply-To: <1331640263-18935-9-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Bowens, Alan" <Alan.Bowens@atmel.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>

Daniel Kurtz wrote:
> These two object table entry fields are reported 1 less than their value.
> So add 1 once, when building the object table, instead of every time
> these fields are accessed.

As per the patch I sent you which does the same thing, you will need to
change the size and instances from u8 to u16.

see
https://github.com/atmel-maxtouch/linux/commit/2643b0a753de5fd607ea6e131aacf5bd69dd8e27

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
