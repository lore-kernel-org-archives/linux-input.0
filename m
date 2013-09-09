From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/7] HID: sony: validate HID output report details
Date: Mon, 9 Sep 2013 14:39:34 +0200
Message-ID: <CAN+gG=FEJ-7cK1teAzuCxDBsBmk5d45A6zUGLbejWSHf9COJdg@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<1378312645-27736-4-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:63144 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab3IIMjf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 08:39:35 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so4930044lbd.16
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 05:39:34 -0700 (PDT)
In-Reply-To: <1378312645-27736-4-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, stable@kernel.org

On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
> This driver must validate the availability of the HID output report and
> its size before it can write LED states via buzz_set_leds(). This stops
> a heap overflow that is possible if a device provides a malicious HID
> output report:
>
> [  108.171280] usb 1-1: New USB device found, idVendor=054c, idProduct=0002
> ...
> [  117.507877] BUG kmalloc-192 (Not tainted): Redzone overwritten
>
> CVE-2013-2890
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---

The tests shows that the device is still working with the fix :)

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
