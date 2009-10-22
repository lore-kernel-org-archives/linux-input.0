From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [RFC PATCH 0/1] new keycodes
Date: Thu, 22 Oct 2009 12:32:19 +0300
Message-ID: <cover.1256200562.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30190 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZJVJc0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2009 05:32:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com

Hi Dmitry -

Here's a proposal for a few new keycodes. Do you prefer to have such
additions in a patch set that actually uses them, instead of preparing
for the future like this? Basically I'd just like to have some
confirmation that you're not opposed to these before I do something
that relies on them.


BR,
Jani.


Jani Nikula (1):
  Input: add new keycodes useful in mobile devices

 include/linux/input.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

