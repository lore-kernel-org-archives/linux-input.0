From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 0/1] Input: joydev blacklist feature
Date: Thu,  5 Oct 2017 18:03:32 -0700
Message-ID: <20171006010333.61496-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:50176 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdJFBDj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 21:03:39 -0400
Received: by mail-qk0-f179.google.com with SMTP id o187so14298439qke.7
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 18:03:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

The joydev changes introduced by this patch are the result of a discussion
on linux-input about handling of features in newer devices, which classic
joydev applications may not pick up and confuse. The original motivation
was dualshock 3 /4 and thq udraw devices, which expose motion sensors
on a subdevice. These got picked up by joydev and confused older applications
and users and has been a regression since 4.12.

The original patch proposed to filter out motion sensor capability from joydev,
but this was 'too wide' of a filter. Ultimately Dmitry suggested for joydev
to reject certain devices.

This patch introduces an initial blacklist mechanism for joydev. It is used
to filter out the motion sensor subdevice on dualshock 3 / 4 and thq udraw.

We hope this feature could still make it into 4.14 to minimize impact on our
users as this will be a long LTS release.

Thanks,
Roderick

Roderick Colenbrander (1):
  Input: joydev - blacklist ds3/ds4/udraw motion sensors

 drivers/input/joydev.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

-- 
2.13.6

