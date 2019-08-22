From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [Resubmit] Read battery voltage from Logitech Gaming mice
Date: Thu, 22 Aug 2019 16:18:44 -0400
Message-ID: <20190822201849.28924-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lains@archlinux.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Resumitting this after having rebased it against the latest changes.

The gaming line of Logitech devices doesn't use the old hidpp20
feature for battery level reporting. Instead, they report the 
current voltage of the battery, in millivolts.

This patch set handles this case by adding a quirk to the 
devices we know to have this new feature, in both wired 
and wireless mode.

This version of the patch set is better split, as well as adding the
quirk to make sure we don't needlessly probe every device connected.
