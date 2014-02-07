From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v2 0/3] input: appletouch: fixes for jagged/uneven cursor
 movement
Date: Thu, 06 Feb 2014 18:38:06 -0600
Message-ID: <52F42AEE.3040505@gmail.com>
References: <52D9DE7A.7040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:53075 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbaBGAiI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 19:38:08 -0500
Received: by mail-ie0-f173.google.com with SMTP id e14so1242263iej.32
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 16:38:08 -0800 (PST)
In-Reply-To: <52D9DE7A.7040509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

These patches address some usability issues by dialing back the fuzz and threshold parameters, by implementing some smoothing for the sensor data and by discarding movements that directly coincide with a change in the number of fingers detected on the touchpad.

Changes since last time:

1/3: Remove extraneous cleanup - I'll submit a separate patch another day
2/3: Apply smoothing to the sensor data before position calculation, eliminating the need to toss values based on a threshold; simplify formula for averaging with prior values

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>

 drivers/input/mouse/appletouch.c |  131 ++++++++++++++++++++++++++------------
 1 file changed, 92 insertions(+), 39 deletions(-)
