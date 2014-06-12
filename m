From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v2 0/1] Input: Support in the elantech driver of the trackpoint present on for instance Lenovo L530
Date: Thu, 12 Jun 2014 20:15:00 +0200
Message-ID: <1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
References: <20140214205126.GB15526@lantern>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140214205126.GB15526@lantern>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org
List-Id: linux-input@vger.kernel.org

This patch adds support for trackpoint on elantech driver for v3 models

Changes since v1:
* New patch now with reference to 3.14rc1
* Added etd->trackpoint_present to indicate presence of trackpoint (based
  on MSB of etd->capabilities[0])
* trackpoint will only be registered now when MSB of etd->capabilities[0] is
  set; got confirmation that this is the indicator of trackpoint
* Added input_unregister_device/input_free_device in elantech_disconnect()
* Fixed a bug in cleaning up when elantech_init fails
* Rename commit to be more specific (now also applicable to future elantech
  v3 models with trackpoint)
* input device name 'TPPS/2 IBM TrackPoint' changed to
  'Elantech PS/2 TrackPoint', this patch is not ibm/lenovo specific!
* dev2 renamed to tp_dev to indicate that this is the trackpoint device
* etd->phys renamed to etd->tp_phys
* Added Lenovo 530 and Fujitsu H730 to the laptop list because those are now
  also known.
* Added psmouse_reset at the end of elantech_init when it fails
* Added warning when trackpoint packets are received with no trackpoint detected

The patch is also available from:
https://github.com/ulrikdb/linux/commit/74f8d3a9307c109ae40c02072dc9c16d3557c3d4

Ulrik De Bie (1):
  elantech: Add support for trackpoint found on some v3 models

 drivers/input/mouse/elantech.c | 104 +++++++++++++++++++++++++++++++++++++++--
 drivers/input/mouse/elantech.h |   4 ++
 2 files changed, 105 insertions(+), 3 deletions(-)

-- 
2.0.0.rc2
