From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] RMI4: improve trackpoint detection
Date: Thu, 18 Jan 2018 16:49:52 -0800
Message-ID: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40475 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbeASAt7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 Jan 2018 19:49:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

Hi,

The following patch series is hopefully improves trackpint detection
on systems using RMI4 and PS/2 guest modules. The issue was that we
were registering port too early, before RMI driver was ready to service
interrupts properly, so psmouse would try to get ID from the device and RMI
driver would still be initializing other functions and interrupts would still be
masked, so GetID would simply time out. Then we may or may not get interrupt
from trackpoint and run through the detection again, but probably much later.

Please take a look and hpefully give it a try. Damjan, I hope it might fix your
issue with trackpoint appearing much much later.

Thanks!

-- 
Dmitry

