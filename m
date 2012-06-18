From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 22/22 v4] Input: atmel_mxt_ts - parse T6 reports
Date: Mon, 18 Jun 2012 16:09:53 +0100
Message-ID: <4FDF44C1.70500@itdev.co.uk>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org> <1339992522-22073-23-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:46536 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751294Ab2FRPJz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 11:09:55 -0400
In-Reply-To: <1339992522-22073-23-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org

Daniel Kurtz wrote:
> The normal messages sent after boot or NVRAM update are T6 reports,
> containing a status, and the config memory checksum.  Parse them and dump
> a useful info message.

This can cause a lot of dmesg output - for instance you get 2 messages per
calibration, and the chip can trigger them itself if noise suppression or
anti-touch calibration are enabled. So perhaps dev_dbg()?

-- 
Nick Dyer
Software Engineer, ITDev Ltd
