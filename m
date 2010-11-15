From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 0/3] HID: roccat: finishing usage of
 sysfs_create_bin_group()
Date: Mon, 15 Nov 2010 21:32:41 +0100
Message-ID: <1289853161.2188.44.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:57406 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752113Ab0KOUco (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 15:32:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

These patches are against the newest roccat file versions (after
applying everything I released the last days).
They fix some inattentive (though not critical) failures from previous
patches and change hid-roccat-koneplus and hid-roccat-pyra to use the
new sysfs_create_bin_group()
koneplus should be finished now (until I find errors)

Stefan

