From: =?UTF-8?q?Simon=20W=C3=B6rner?= <linux@simon-woerner.de>
Subject: HID: Add driver for synaptics keybard with broken rdesc
Date: Fri, 23 Jan 2015 20:03:29 +0100
Message-ID: <1422039810-26327-1-git-send-email-linux@simon-woerner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from brief.guru ([176.9.109.100]:36893 "EHLO brief.guru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbbAWTKc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jan 2015 14:10:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Synaptics keyboards (USB ID 06cb:2968) e.g. in Acer SW5-012
have the following issue:

- The report descriptor specifies an excessively large number of consumer
  usages (2^15), which is more than HID_MAX_USAGES. This prevents proper
  parsing of the report descriptor.

