From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH v4 0/2] Input: Support in the elantech driver of the
 trackpoint present on for instance Lenovo L530
Date: Mon, 14 Jul 2014 21:03:08 +0200
Message-ID: <20140714190307.GA6080@lantern>
References: <CANq1E4S5xVuWO3THy2rB5O_8fsLeYCWAres2Xk5Pf1j1_Po=og@mail.gmail.com>
 <1402955589-23709-1-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:54452 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbaGNTDS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2014 15:03:18 -0400
Content-Disposition: inline
In-Reply-To: <1402955589-23709-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

Hi Dmitry,

could you please give feedback on this set of 2 patches ?
They have been updated and reviewed and this patch set v4 is 1 month old now.

I have some other patches waiting to make Fujitsu H730 work too 
but it will rely for part of the functionality on this patch.

Thanks for your time and feedback !
Ulrik


On Mon, Jun 16, 2014 at 11:53:07PM +0200, Ulrik De Bie wrote:
> Date:	Mon, 16 Jun 2014 23:53:07 +0200
> From: Ulrik De Bie <ulrik.debie-os@e2big.org>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David
>  Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org
> Subject: [PATCH v4 0/2] Input: Support in the elantech driver of the
>  trackpoint present on for instance Lenovo L530
> X-Mailer: git-send-email 2.0.0
> X-Mailing-List:	linux-input@vger.kernel.org
> 
> Patch 1 adds support for trackpoint on elantech driver for v3 models.
> Patch 2 adds a psmouse_reset when the elantech probes fails. Patch 2 depends 
> on Patch 1.
> 
> Changes since v3:
> * Patch1: added (correct) error after input_allocate_device failure in elantech_init()
> * Patch2: added more explanation to the why 
> 
> Changes since v2:
> * psmouse_reset change is now moved to a separate patch
> * comments/white spaces/newlines  cleanup
> * Unexpected trackpoint message warning now only printed once
> * removed some unnecessary casts
> * Deleted etd->trackpoint_present and use instead etd->tp_dev to indicate the
>   presence of a trackpoint
> * Propagate the error when elantech_init fails
> 
> Changes since v1:
> * New patch now with reference to 3.14rc1
> * Added etd->trackpoint_present to indicate presence of trackpoint (based
>   on MSB of etd->capabilities[0])
> * trackpoint will only be registered now when MSB of etd->capabilities[0] is
>   set; got confirmation that this is the indicator of trackpoint
> * Added input_unregister_device/input_free_device in elantech_disconnect()
> * Fixed a bug in cleaning up when elantech_init fails
> * Rename commit to be more specific (now also applicable to future elantech
>   v3 models with trackpoint)
> * input device name 'TPPS/2 IBM TrackPoint' changed to
>   'Elantech PS/2 TrackPoint', this patch is not ibm/lenovo specific!
> * dev2 renamed to tp_dev to indicate that this is the trackpoint device
> * etd->phys renamed to etd->tp_phys
> * Added Lenovo 530 and Fujitsu H730 to the laptop list because those are now
>   also known.
> * Added psmouse_reset at the end of elantech_init when it fails
> * Added warning when trackpoint packets are received with no trackpoint detected
> 
> The patches are also available from:
> https://github.com/ulrikdb/linux/commit/53d8424bc2143d34c2be76064892079fe1917a9e
> https://github.com/ulrikdb/linux/commit/cf12fcc6cdf51a7aad48d056750478aecd9d7eca
> 
> 
> Ulrik De Bie (2):
>   elantech: Add support for trackpoint found on some v3 models
>   elantech: Call psmouse_reset when elantech probe fails
> 
>  drivers/input/mouse/elantech.c | 123 +++++++++++++++++++++++++++++++++++++++--
>  drivers/input/mouse/elantech.h |   3 +
>  2 files changed, 122 insertions(+), 4 deletions(-)
> 
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
