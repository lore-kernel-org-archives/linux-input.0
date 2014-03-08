From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] input: synaptics add manual min/max quirk for ThinkPad X240
Date: Sat,  8 Mar 2014 12:35:20 +0100
Message-ID: <1394278521-6870-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaCHLfk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 8 Mar 2014 06:35:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Stephen Chandler Paul <thatslyude@gmail.com>

Hi All,

Here is a follow up patch to Benjamin's quirk patch, which adds the
necessary min/max overrides for the ThinkPad X240

As such this patch depends on Benjamin's patch going in first.

Regards,

Hans
