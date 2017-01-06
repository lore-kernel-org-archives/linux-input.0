From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: remove use of DRIVER_LICENSE
Date: Fri, 6 Jan 2017 09:06:37 +0100
Message-ID: <20170106080637.GD15702@mail.corp.redhat.com>
References: <20170105190704.56654-1-grundler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966693AbdAFIGn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Jan 2017 03:06:43 -0500
Content-Disposition: inline
In-Reply-To: <20170105190704.56654-1-grundler@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Grant Grundler <grundler@google.com>

On Jan 05 2017 or thereabouts, Grant Grundler wrote:
> Local "#define DRIVER_LICENSE" obfuscates which license is used
> in MODULE_LICENSE().  "fgrep -R MODULE_LICENSE" is more informative
> when the string is hard coded in MODULE_LICENSE.
> 
> Signed-off-by: Grant Grundler <grundler@google.com>
> ---
> Most of the kernel already uses hard coded strings.
> The few places that don't are easy to fix.

FWIW:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

