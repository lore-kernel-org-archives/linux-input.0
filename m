From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 11/20] Input: atmel_mxt_ts - refactor mxt_object_show
Date: Tue, 20 Mar 2012 08:11:13 -0700
Message-ID: <4F689E11.5090202@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-12-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:52005 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754896Ab2CTPLR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:11:17 -0400
In-Reply-To: <1331640263-18935-12-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

Daniel Kurtz wrote:
> Read each object with a single i2c transaction instead of byte-by-byte.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
