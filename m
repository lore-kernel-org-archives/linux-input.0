From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 0/8] HID: roccat: Bugfixes, code deduplication, support for
 Kova[+], ioctl for chardev
Date: Sun, 30 Jan 2011 13:38:17 +0100
Message-ID: <1296391097.2283.179.camel__37798.159736167$1296391126$gmane$org@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:47048 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab1A3MiX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jan 2011 07:38:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil>

This patchset contains:

- new hid_erro macros are used instead of dev_err
- module hid-roccat-common begins to contain code
  duplicated in the roccat device drivers.
  This contains just 2 functions for now, but more
  will come in the near future.
- Support for Kova[+] was added.
- Roccat chardev was refactured to support only one
  report size per device which can be retreived
  with a new ioctl
- A bug was fixed where Kone[+] froze occasionally
  on initialization
- A NULL pointer dereference was fixed that occured
  when unloading the module while a device was
  still present
- A bug was fixed that prevented roccat chardev
  from removing devices from its list.

