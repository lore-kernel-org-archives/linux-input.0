From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 5/7] HID: LG: validate HID output report details
Date: Mon, 9 Sep 2013 15:22:35 +0200
Message-ID: <CAN+gG=HppwzbLH74G=BmEUtQ06sQWj-n7Msguj9BAQ+n=EKkJg@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<1378312645-27736-6-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36882 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3IINWh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 09:22:37 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so4978345lbd.16
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 06:22:36 -0700 (PDT)
In-Reply-To: <1378312645-27736-6-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, stable@kernel.org

On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
> A HID device could send a malicious output report that would cause the
> lg, lg3, and lg4 HID drivers to write beyond the output report allocation
> during an event, causing a heap overflow:
>
> [  325.245240] usb 1-1: New USB device found, idVendor=046d, idProduct=c287
> ...
> [  414.518960] BUG kmalloc-4096 (Not tainted): Redzone overwritten
>
> Additionally, while lg2 did correctly validate the report details, it was
> cleaned up and shortened.
>
> CVE-2013-2893
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---

To me, the patch looks good.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
