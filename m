From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 0/4] Migrations to hid-multitouch
Date: Tue,  8 Mar 2011 17:32:55 +0100
Message-ID: <1299601979-4871-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:49740 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab1CHQdk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 11:33:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <ch>

Hi guys,

As mentioned on the list, I think that the following drivers can safely be moved to hid-multitouch:
3M, Stantum and Cando.

This let Quanta and Mosart in the queue.

In addition, I also added the auto-detection of the maximum contact number a device can handle based on the report descriptors.

Cheers,
Benjamin


