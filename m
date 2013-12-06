From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 3.4-stable][CVE] HID: picolcd_core: validate output report details
Date: Fri, 6 Dec 2013 08:44:12 -0800
Message-ID: <CAGXu5j+Mei+aNWcm_VUd6ReUOgB=x-anjVaEAcRaWuYa6F5S5A@mail.gmail.com>
References: <1386323162-7676-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:50637 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab3LFQoN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Dec 2013 11:44:13 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so1000571obc.15
        for <linux-input@vger.kernel.org>; Fri, 06 Dec 2013 08:44:13 -0800 (PST)
In-Reply-To: <1386323162-7676-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "# 3.4.x" <stable@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, guohanjun@huawei.com

On Fri, Dec 6, 2013 at 1:46 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Hi Kees, Jiri or Greg,
>
> This patch has been backported to 3.2 stable tree.
> It is a CVE bugfix, and looks applicable to stable-3.4.
> It prevents from triggering a NULL dereference during
> atrr file writing if a HID device send a malicious output
> report.
>
> NOTE:
> Rename file drivers/hid/hid-picolcd_core.c
>         ->  drivers/hid/hid-picolcd.c.

Ah! Good call, yes. This should be applied to stable-3.4. Thanks for
fixing it up!

-Kees

-- 
Kees Cook
Chrome OS Security
