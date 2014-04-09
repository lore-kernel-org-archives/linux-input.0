From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Wed,  9 Apr 2014 10:47:48 +0200
Message-ID: <1397033270-29597-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaDIIr5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 04:47:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi All,

It seems that in our last discussion of this patch-set we ended up agreeing
that this really is something which we want to have since Windows drivers use
on PNP IDs to distguinish between various models and using the same mechanism
as windows is the best way to avoid surprises.

So here is a resend with the intent to get this merged now that we agree on
this.

Thanks & Regards,

Hans
