From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH 0/1] psmouse - focaltech pass finger width to userspace
Date: Fri, 24 Apr 2015 00:43:31 +0300
Message-ID: <1429825412-8499-1-git-send-email-hanipouspilot@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35962 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030809AbbDWVnr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 17:43:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>, Dmitry Tunin <hanipouspilot@gmail.com>

Now I made it in a correct way. No need to count fingers.
Just send width after an abs packet is received.

