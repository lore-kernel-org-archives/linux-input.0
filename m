From: Cedric Sodhi <manday@gmx.net>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 16:40:49 +0100
Message-ID: <20111116154049.GA8444@slate>
References: <20111116095030.GC3335@slate>
 <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
 <20111116102514.GA3831@slate>
 <CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
 <20111116145518.GA7080@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:46013 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751845Ab1KPPlM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 10:41:12 -0500
Content-Disposition: inline
In-Reply-To: <20111116145518.GA7080@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

Thanks to Benjamin's help and his neat patch which allows tempering with
quirks through sysfs, I got the device

eGalax 0eef:a001

to work. It works with the quirks

MT_QUIRK_SLOT_IS_CONTACTID | MT_QUIRK_ALWAYS_VALID ( = 18 )

so, using Benjamin's interface:

(1) Adding the device with
$ cd '/sys/modules/hid_multitouch/driver/hid:hid-multitouch'
$ echo "3 0eef a001 1" > new_id

(2) Setting the quirks with
$ echo 18 > '0003:0EEF:A001.0001/quirks'

That's it. The device works!

regards,
Cedric
