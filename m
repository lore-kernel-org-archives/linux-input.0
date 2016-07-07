From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH 0/1] hid: Add support for the Elecom DEFT trackball
Date: Wed,  6 Jul 2016 21:58:24 -0400
Message-ID: <20160707015825.17915-1-yshuiv7@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36806 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcGGB6k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2016 21:58:40 -0400
Received: by mail-qk0-f173.google.com with SMTP id 82so3464771qko.3
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2016 18:58:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yshuiv7@gmail.com
Cc: linux-input@vger.kernel.org

Hi,

The Elecom DEFT is a trackball mouse, a picture can be found here [1].
As you can see, there're three Fn keys at the top of the mouse. These
keys doesn't work on current Linux kernel. Complains from several users
can be found on the internet [1][2].

The problem is in the HID report sent by the device, only 5 standard
buttons are reported. There's an additional 3*1 bit item without any
usage page in the report, which corresponds to the Fn buttons. This
patch remove that item, and change the number of standard buttons to 8.

[1]: http://xahlee.info/kbd/elecom_trackball.html
[2]: https://www.reddit.com/r/Trackballs/comments/4pu3cv/elecom_mdt2_fn_buttons_on_linux/

Regards,
Yuxuan Shui
