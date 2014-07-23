From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/5] hid: huion: Use "tablet" instead of specific model
Date: Wed, 23 Jul 2014 10:30:02 -0400
Message-ID: <CAN+gG=GNq-dcKfxq-ndknfWCr4apmWhfd65-ifbukXosgj-hFQ@mail.gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
	<1406119378-24551-2-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36480 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964AbaGWOaD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 10:30:03 -0400
Received: by mail-la0-f42.google.com with SMTP id pv20so991328lab.1
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 07:30:02 -0700 (PDT)
In-Reply-To: <1406119378-24551-2-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Wed, Jul 23, 2014 at 8:42 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Use word "tablet" in identifiers and comments instead of referring to specific
> Huion tablet model name, as the product ID is used by at least several tablet
> models.
>
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
