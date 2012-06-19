From: Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH 0/2] drivers/input/mouse, drivers/platform/x86: add Lenovo
 IdeaPad Z570 support
Date: Tue, 19 Jun 2012 22:20:37 +0300
Message-ID: <1340133637.3636.8.camel@lenovo-ideapad-z570.olymp.linuxd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Ike Panhc <ike.pan@canonical.com>
List-Id: linux-input@vger.kernel.org

Hello,

This series of patches should improve support of Lenovo IdeaPad Z570 laptop.
Also, the first patch adds two exported functions to psmouse module which
allow other modules activate and deactivate PS/2 mouse or touchpad. The
reasons of this are described in the following message.

 Documentation/ABI/testing/sysfs-platform-ideapad-laptop |   12 +
 drivers/input/mouse/psmouse-base.c                      |   43 +++++
 drivers/platform/x86/ideapad-laptop.c                   |  117 +++++++++++++++-
 include/linux/input/psmouse.h                           |    7 
 4 files changed, 175 insertions(+), 4 deletions(-)

Thanks
