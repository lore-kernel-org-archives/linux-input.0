From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] synaptics: Change min/max quirk table to pnp-id matching
Date: Fri, 16 May 2014 20:46:46 +0200
Message-ID: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

After seeing how happy you were with the last quirk patch for the synaptics
driver I thought it was time to make things somewhat better, hence this
patch set.

Most of the affected models share pnp-ids for the touchpad. So switching
to pnp-ids give us 2 advantages:
1) It shrinks the quirk list
2) It will lower the new quirk addition frequency

Note that this will not get rid of the need to add a new quirk every now
and then, but it should significantly reduce the frequency with which we add
them.

This has been tested on a T440s.

Since I would also like to avoid the need to still add new quirks to stable,
and since the prereqs are also all in stable, I've also put a CC stable on
this series.

Regards,

Hans
