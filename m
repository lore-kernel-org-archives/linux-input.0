From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 01/15] Input: synaptics-rmi4 - fix checkpatch.pl, sparse
 and GCC warnings
Date: Wed, 5 Feb 2014 17:36:09 -0800
Message-ID: <52F2E709.5060007@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <52F172DC.5090900@synaptics.com> <20140206010938.GA27770@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:27501 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbaBFBgK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:36:10 -0500
In-Reply-To: <20140206010938.GA27770@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org

On 02/05/2014 05:09 PM, Dmitry Torokhov wrote:
> On Tue, Feb 04, 2014 at 03:08:12PM -0800, Christopher Heiny wrote:
>> >On 01/23/2014 04:00 PM, Courtney Cavin wrote:
>>> > >Cc: Christopher Heiny<cheiny@synaptics.com>
>>> > >Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>>> > >Signed-off-by: Courtney Cavin<courtney.cavin@sonymobile.com>
>>> > >---
>>> > >  drivers/input/rmi4/rmi_bus.c    |  4 ++--
>>> > >  drivers/input/rmi4/rmi_bus.h    |  2 +-
>>> > >  drivers/input/rmi4/rmi_driver.c | 17 ++++++++++++-----
>>> > >  drivers/input/rmi4/rmi_f11.c    |  4 +++-
>>> > >  4 files changed, 18 insertions(+), 9 deletions(-)
>>> > >
>>> > >diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
>>> > >index 96a76e7..8a939f3 100644
>>> > >--- a/drivers/input/rmi4/rmi_bus.c
>>> > >+++ b/drivers/input/rmi4/rmi_bus.c
>>> > >@@ -37,7 +37,7 @@ static void rmi_release_device(struct device *dev)
>>> > >  	kfree(rmi_dev);
>>> > >  }
>>> > >
>>> > >-struct device_type rmi_device_type = {
>>> > >+static struct device_type rmi_device_type = {
>>> > >  	.name		= "rmi_sensor",
>>> > >  	.release	= rmi_release_device,
>>> > >  };
>> >
>> >This struct is used by diagnostic modules to identify sensor
>> >devices, so it cannot be static.
 >
> Then we need to declare it somewhere or provide an accessor function.

Currently it's in a header not included in the patches.  We'll move it 
to rmi_bus.h.
