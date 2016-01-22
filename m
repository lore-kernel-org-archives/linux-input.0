From: Prabhu Chawandi <foss.chaws@gmail.com>
Subject: Creating multiple event nodes for A composite HID Device.
Date: Fri, 22 Jan 2016 12:58:39 +0530
Message-ID: <CAKafyqpeJi+ZZccawr4EJFEO02a_jZk02XS-xZ_is8D0ZGd=Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34967 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbcAVH2k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2016 02:28:40 -0500
Received: by mail-io0-f170.google.com with SMTP id 77so79773651ioc.2
        for <linux-input@vger.kernel.org>; Thu, 21 Jan 2016 23:28:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

  Is it possible to make Linux to create a separate /dev/input/eventX
node for all the device composited ?

Example: if my device is supporting Mouse, KBD and Consumer

if I want to create three event nodes for each, like /dev/input/event1
/dev/input/event2 /dev/input/event3.

How can I do if I am using bluetooth Smart HID device ? Please share your input.

thanks in advance.
