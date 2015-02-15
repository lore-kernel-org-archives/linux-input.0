From: Thomas Sanchez <thomas.sanchz@gmail.com>
Subject: [PATCH v3] drivers: input: mouse: Add Foxconn's CNTouch driver
Date: Sun, 15 Feb 2015 13:39:31 +0100
Message-ID: <1424003972-25643-1-git-send-email-thomas.sanchz@gmail.com>
References: <20150201045058.GC24292@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:57833 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbBOMj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Feb 2015 07:39:57 -0500
Received: by mail-wi0-f177.google.com with SMTP id bs8so20982544wib.4
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2015 04:39:56 -0800 (PST)
In-Reply-To: <20150201045058.GC24292@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi,
Sorry for the delay. I fixed every comments in your code review. I also
changed the code to use __set_bit which is easier to read IMHO.

About wether it is an HID compatible device, I took a quick glance but
it is not really easy to see... I plan to try out today.

In the meantime here is the patch in case of it is not possible to use
the HID interface.

Thanks,
Cheers,

