From: <gregkh@linuxfoundation.org>
Subject: patch "input: tsc2007 - drop the driver_module assignment in iio interface." added to staging-next
Date: Mon, 25 Sep 2017 13:22:40 +0200
Message-ID: <150633856012390@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933200AbdIYLYR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Sep 2017 07:24:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@kernel.org, Jonathan.Cameron@huawei.com, dmitry.torokhov@gmail.com, lars@metafoo.de, linux-input@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    input: tsc2007 - drop the driver_module assignment in iio interface.

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 4749b0a28feddeaeffa8044cd3ae1711cc15c8da Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 23 Jul 2017 17:26:19 +0100
Subject: input: tsc2007 - drop the driver_module assignment in iio interface.

This is now handled via some macro magic during the register.  The
field in iio_info will be removed shortly.

Cc: Linux Input <linux-input@vger.kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/input/touchscreen/tsc2007_iio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
index 27b25a9fce83..e27a956f5f2b 100644
--- a/drivers/input/touchscreen/tsc2007_iio.c
+++ b/drivers/input/touchscreen/tsc2007_iio.c
@@ -104,7 +104,6 @@ static int tsc2007_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tsc2007_iio_info = {
 	.read_raw = tsc2007_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 int tsc2007_iio_configure(struct tsc2007 *ts)
-- 
2.14.1


