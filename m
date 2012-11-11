From: Stefan Achatz <stefan_achatz@web.de>
Subject: [PATCH 0/7] HID: roccat: Finishing cleanup and reset support
Date: Sun, 11 Nov 2012 06:20:46 +0100
Message-ID: <1352611246.2463.214.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patchset finishes current cleanups and unifications.

Device reset is now implemented for all devices that support that
feature.

A couple sysfs attributes have been deprecated and got replaced to unify
the ABI as good as it gets with design decisions made in the past.

The next release of userland tools will only use these obsolete
attributes as fallback. When that version is out, I will add all actual
sysfs attributes from ABI/obsolete/sysfs-driver-hid-roccat-* to
feature-removal-schedule.txt.

