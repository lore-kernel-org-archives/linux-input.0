From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 02/20] Input: atmel_mxt_ts - only allow root to update
 firmware
Date: Tue, 20 Mar 2012 07:38:39 -0700
Message-ID: <4F68966F.9070303@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-3-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:42990 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754012Ab2CTOin (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 10:38:43 -0400
In-Reply-To: <1331640263-18935-3-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Bowens, Alan" <Alan.Bowens@atmel.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>

Daniel Kurtz wrote:
> Restrict permissions on the update_fw sysfs entry to read only for root
> only.
> 
> Also, update object permission to use a macro S_IRUGO macro instead of
> hard coded 0444.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>
