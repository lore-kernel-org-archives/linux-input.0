From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH 3/3] HID: hid-sensor-hub: Call hid_hw_close() before
 hid_hw_stop()
Date: Mon, 17 Sep 2012 15:20:38 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A919D527D2@ORSMSX108.amr.corp.intel.com>
References: <1347573801.8974.2.camel@phoenix>
 <1347574001.8974.6.camel@phoenix>
 <4FA419E87744DF4DAECD5BCE1214B7A919D523B1@ORSMSX108.amr.corp.intel.com>
 <alpine.LNX.2.00.1209171257260.31149@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55994 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756502Ab2IQPUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 11:20:41 -0400
In-Reply-To: <alpine.LNX.2.00.1209171257260.31149@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Axel Lin <axel.lin@gmail.com>, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Alex,

Can you resubmit your patches merging 2/3 and 3/3?

Thanks,
Srinivas

-----Original Message-----
From: Jiri Kosina [mailto:jkosina@suse.cz] 
Sent: Monday, September 17, 2012 3:58 AM
To: Pandruvada, Srinivas
Cc: Axel Lin; Jonathan Cameron; linux-input@vger.kernel.org
Subject: RE: [PATCH 3/3] HID: hid-sensor-hub: Call hid_hw_close() before hid_hw_stop()

On Thu, 13 Sep 2012, Pandruvada, Srinivas wrote:

> I think you can merge this patch with your patch 2/3 as both are 
> addressing hid_hw_close and hid_hw_stop.

Agreed. In addition to that, I am fine with the changes. As this whole lot is going through Jonathan to Greg, I just add my

	Acked-by: Jiri Kosina <jkosina@suse.cz>

and let Jonathan take it. Thanks,

--
Jiri Kosina
SUSE Labs
