From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/7] HID: zeroplus: validate output report details
Date: Mon, 9 Sep 2013 14:36:51 +0200
Message-ID: <CAN+gG=EfypjWh=on3czfEUOOAP372QUJtRrTgOzEjD7MvyWn5w@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<1378312645-27736-3-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:58662 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab3IIMgx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 08:36:53 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so4947872lab.0
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 05:36:51 -0700 (PDT)
In-Reply-To: <1378312645-27736-3-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, stable@kernel.org

On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
> The zeroplus HID driver was not checking the size of allocated values
> in fields it used. A HID device could send a malicious output report
> that would cause the driver to write beyond the output report allocation
> during initialization, causing a heap overflow:
>
> [ 1442.728680] usb 1-1: New USB device found, idVendor=0c12, idProduct=0005
> ...
> [ 1466.243173] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten
>
> CVE-2013-2889
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---

I don't have the report descriptor available, but the patch seems ok.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Cheers,
Benjamin
