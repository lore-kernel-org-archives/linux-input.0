From: Medvedev Yuriy <goodking1987@gmail.com>
Subject: hiddev and hidraw, work together
Date: Wed, 28 Oct 2015 22:17:52 +0100
Message-ID: <CAEhjxfW9DxBtFE+cTkvDUX_W+BXZLE1P+2vZdS_OqnGOGZxhAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35331 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbJ1VSN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2015 17:18:13 -0400
Received: by wicll6 with SMTP id ll6so212560722wic.0
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2015 14:18:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi. I have three processes which communicate with usb hid device.
Until now those processes used hiddev interface for this purpose. Now
I need to change hiddev to hidraw in one of those processes, and I'm
using hidapi library for it. Separately the processes work fine, but
when working together the process which is using hidraw is unable to
read data from the device, or it reads some trash instead of data. My
question is - is it possible to use hiddev and hidraw together to
access the same device? OS Linux Fedora
