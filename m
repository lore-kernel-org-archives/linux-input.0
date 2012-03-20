From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 13/20] Input: atmel_mxt_ts - parse vector field of data
 packets
Date: Tue, 20 Mar 2012 08:23:05 -0700
Message-ID: <4F68A0D9.9040400@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-14-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:50652 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755008Ab2CTPXI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:23:08 -0400
In-Reply-To: <1331640263-18935-14-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Daniel Kurtz wrote:
> The atmel_mxt_ts T9 data contains information orientation in its 'vector'
> field. Parse and debug print its contents, although its value isn't
> actually used yet.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Fair enough.

Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
