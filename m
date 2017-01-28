From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v3 0/2] Synaptics RMI4 sysfs attributes
Date: Sat, 28 Jan 2017 19:06:00 +0000
Message-ID: <1485630362-27423-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:35254 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbdA1TH2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 28 Jan 2017 14:07:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Healy <cphealy@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi Dmitry-

Here are a couple of patches to add sysfs attributes useful in implementing a
firmware update system on Synaptics RMI4.

Changes in v3:
- Improved commit message and added Acks/Testeds.
- Stopped reporting 0 on success at Benjamin Tissoires' suggestion.
Changes in v2:
- Fixed bug in handling of update status in F34v7

regards

Nick Dyer

