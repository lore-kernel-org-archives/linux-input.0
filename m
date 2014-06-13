From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v3 0/2] Input: Support in the elantech driver of the trackpoint present on for instance Lenovo L530
Date: Fri, 13 Jun 2014 23:21:11 +0200
Message-ID: <1402694473-11518-1-git-send-email-ulrik.debie-os@e2big.org>
References: <20140613205547.GA5244@lantern>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140613205547.GA5244@lantern>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org
List-Id: linux-input@vger.kernel.org

Patch 1 adds support for trackpoint on elantech driver for v3 models.
Patch 2 adds a psmouse_reset when the elantech probes fails. Patch 2 depends on Patch 1.


Changes since v2:
* psmouse_reset change is now moved to a separate patch
* comments/white spaces/newlines  cleanup
* Unexpected trackpoint message warning now only printed once
* removed some unnecessary casts
* Deleted etd->trackpoint_present and use instead etd->tp_dev to indicate the
  presence of a trackpoint
* Propagate the error when elantech_init fails

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

The patches are also available from:
https://github.com/ulrikdb/linux/commit/f8570efe466fb835b76f11fdbaf277fea9999a42
https://github.com/ulrikdb/linux/commit/69ab8ef8cf96237a90b393607727d080930d4469


Ulrik De Bie (2):
  elantech: Add support for trackpoint found on some v3 models
  elantech: Call psmouse_reset when elantech probe fails

 drivers/input/mouse/elantech.c | 120 +++++++++++++++++++++++++++++++++++++++--
 drivers/input/mouse/elantech.h |   3 ++
 2 files changed, 119 insertions(+), 4 deletions(-)

-- 
2.0.0
