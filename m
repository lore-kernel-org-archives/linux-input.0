From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Fri,  6 Feb 2015 15:04:28 -0500
Message-ID: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This is the second episode of the Lenovo 2015 party :)

Thanks to Andrew, we now have an idea within the driver of what are the extra
buttons aimed for, and the patch series looks cleaner.
Many thanks for your help.

I marked only patches 1/7, 2/7 and 3/7 as stable because they are really
stable fixes. Without the rest of the series, user-space can cope with the
kernel result, and so there is IMO no need to backport too many patches in
stable. I bet distributions will cherry-pick the rest of the series however.

Cheers,
Benjamin

Benjamin Tissoires (7):
  Input: synaptics - fix middle button on Lenovo 2015 products
  Input: synaptics - handle spurious release of trackstick buttons
  Input: synaptics - do not retrieve the board id on old firmwares
  Input: synaptics - retrieve the extended capabilities in query $10
  Input: synaptics - remove TOPBUTTONPAD property for Lenovos 2015
  Input: synaptics - re-route tracksticks buttons on the Lenovo 2015
    series
  Input: synaptics - Remove X1 Carbon 3rd gen from the topbuttonpad list

 drivers/input/mouse/synaptics.c | 129 +++++++++++++++++++++++++++++-----------
 drivers/input/mouse/synaptics.h |  28 +++++++++
 2 files changed, 122 insertions(+), 35 deletions(-)

-- 
2.1.0
