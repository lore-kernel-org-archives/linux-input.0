From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC 0/2] Add EVIOC mechanism to extract the MT slot state
Date: Thu, 27 Jan 2011 11:35:45 +0100
Message-ID: <1296124547-3323-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:33424 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab1A0Kfz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 05:35:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pingc@wacom.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina>

Hi guys,

This patchset is a rework of Henrik's original work.
Henrik, I kept your signed-off-by, please tell me if it's ok with you.
I just changed the method call (and signature) for it to be compliant with the new EVIOC handling.

I'm not very happy with it (for instance, there is a call of an mt stuff in generic input), but it's a start.

Cheers,
Benjamin



