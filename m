From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] i2c-hid: don't push static constants on stack for %*ph
Date: Fri, 2 Aug 2013 14:51:23 +0200
Message-ID: <CAN+gG=FQqAGV1ykq9RBzwkbp6vLAJwLP1L1y76NcyUP_iYZ6cQ@mail.gmail.com>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:61429 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3HBMvZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Aug 2013 08:51:25 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so402612lab.41
        for <linux-input@vger.kernel.org>; Fri, 02 Aug 2013 05:51:23 -0700 (PDT)
In-Reply-To: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, Aug 2, 2013 at 1:07 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There is no need to pass constants via stack. The width may be explicitly
> specified in the format.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Andy,
Benjamin
