From: Nikola Pajkovsky <npajkovs@redhat.com>
Subject: Re: [PATCH 5/5] HID: hid-lenovo-tpkbd, remove doubled hid_get_drvdata
Date: Fri, 05 Apr 2013 01:05:35 +0200
Message-ID: <m36201vqv4.fsf@redhat.com>
References: <1365107532-32721-1-git-send-email-jslaby@suse.cz>
	<1365107532-32721-5-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31158 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764464Ab3DDXGW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Apr 2013 19:06:22 -0400
In-Reply-To: <1365107532-32721-5-git-send-email-jslaby@suse.cz> (Jiri Slaby's
	message of "Thu, 4 Apr 2013 22:32:12 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Jiri Slaby <jslaby@suse.cz> writes:

> In pointer_press_speed_show, we do
>     data_pointer = hid_get_drvdata(hdev);
> twice in a row. Remove one of those.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/hid/hid-lenovo-tpkbd.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Nikola Pajkovsky <npajkovs@redhat.com>

-- 
Nikola
