From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 07/20] Input: atmel_mxt_ts - add backupnv sysfs entry
Date: Tue, 20 Mar 2012 08:01:36 -0700
Message-ID: <4F689BD0.7090002@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-8-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:34755 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758036Ab2CTPBk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:01:40 -0400
In-Reply-To: <1331640263-18935-8-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Daniel Kurtz wrote:
> Writing to the object sysfs entry permits individual object table entries
> to be modified in the device RAM at run time.  To permanently save
> the settings, they must be written to Non-Volatile memory (NVM).
> This patch adds a write-only sysfs entry to allow userspace to save
> current settings to NVM, but restricts access to root.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

The process to update the stored chip configuration should be:

1) Change config setting
2) Backup (with delay)
3) Reset (with delay)
4) Get driver to re-read resolution etc

So I am worried that this is a half solution, and will lead to confusion.

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
