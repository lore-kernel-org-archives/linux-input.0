From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/4] input: Add support for special keys on ms office kb
Date: Wed, 29 Jan 2014 17:57:40 +0100
Message-ID: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbaA2Q5v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 11:57:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi All,

A member of my local hackerspace has donated a Microsoft Office keyboard to
me. This keyboard has lots of special keys, some of which don't work
and a scrollwheel which does not work. This patch-set adds support for the
scrollwheel and the non working special-keys.

Regards,

Hans
