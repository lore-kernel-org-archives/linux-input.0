From: Richard Pospesel <pospeselr@gmail.com>
Subject: (unknown)
Date: Wed, 17 Feb 2016 08:39:30 -0800
Message-ID: <1455727171-23995-1-git-send-email-pospeselr@gmail.com>
References: <56C40474.5050803@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36207 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422903AbcBQQjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2016 11:39:44 -0500
Received: by mail-pf0-f169.google.com with SMTP id e127so14145787pfe.3
        for <linux-input@vger.kernel.org>; Wed, 17 Feb 2016 08:39:43 -0800 (PST)
Subject: 
In-Reply-To: <56C40474.5050803@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pospeselr@gmail.com, chris@diamand.org, linux-input@vger.kernel.org


Fixed the line length issues per offline discussion with Chris.
---
Input: BYD: added absolute touch event support to BYD touchpad driver

Implemented absolute position and touch reporting. Now BYD touchpads will use
the synaptics/libinput xorg touchpad drivers. Added documentation for all
known gesture packets and initialization commands.

Signed-off-by: Richard Pospesel <pospeselr@gmail.com>

