From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/14] alps: bugfixes, cleanups and new hardware support
Date: Wed,  9 Jul 2014 17:24:05 +0200
Message-ID: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5814 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932397AbaGIPY1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

Hi All,

This series started out as a single patch to add support for a new model
of alps touchpad, called PROTO_V7 in this patchset.

While working on this I ended up doing some refactoring as preparation, which
I tested on a Rushmore alps touchpad, which lead to some bugfixes and more
cleanups, etc.

The result is a 14 patch patch-set, which:

1) Significantly improves multi-touch support on V3 and V4 models (including
   the Rushmore V3 variant)
2) Improves the code quality / readability quite a bit
3) Adds support for PROTO_V7

Regards,

Hans
