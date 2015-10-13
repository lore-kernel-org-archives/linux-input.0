From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] HID: hiddev: change hiddev_connect() to return bool
Date: Tue, 13 Oct 2015 10:49:49 +0900
Message-ID: <CAJKOXPcq8BuVENk=eDAyxyAnRy4YUZy8ibrXxgGb3RZzk55AZg@mail.gmail.com>
References: <1444395633-12672-1-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35423 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbbJMBtu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 21:49:50 -0400
In-Reply-To: <1444395633-12672-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

2015-10-09 22:00 GMT+09:00 Luis de Bethencourt <luisbg@osg.samsung.com>:
> Since hid_connect() only cares about hiddev_connect() succeeding or
> failing, there is no need for this function to return an int and it can
> return a bool instead.

It can return bool but it would not be in line with kernel coding
style. The hiddev_connect() I believe is an action, so "the function
should return an error-code integer.".

Best regards,
Krzysztof

>
> Suggested-by: Jiri Kosina <jikos@kernel.org>
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>
> Hi,
>
> No idea why my local build did not complain about the obvious mistake
> on the previous version of the patch.
>
> Sorry about that,
> Luis
>
>  drivers/hid/hid-core.c      |  2 +-
>  drivers/hid/usbhid/hiddev.c | 10 +++++-----
>  include/linux/hid.h         |  2 +-
>  include/linux/hiddev.h      |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
