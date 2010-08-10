From: "Arce, Abraham" <x0066660@ti.com>
Subject: Dual touchscreen implementation
Date: Tue, 10 Aug 2010 18:16:27 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043F6195B1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab0HJXQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Aug 2010 19:16:30 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7ANGTM7030603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Tue, 10 Aug 2010 18:16:29 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7ANGTTr019747
	for <linux-input@vger.kernel.org>; Tue, 10 Aug 2010 18:16:29 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7ANGTfI004656
	for <linux-input@vger.kernel.org>; Tue, 10 Aug 2010 18:16:29 -0500 (CDT)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

I am working in a board with dual display/touchscreen. I have searched within drivers/input/touchscreen for some examples on how to implement the functionality to configure driver and behave as a single touchscreen if 2 sensors are present, no specific example found

My idea is to create an attribute "virtualized" to enable/disable virtualization in the second touchscreen

+ static DEVICE_ATTR(virtualized, S_IRUGO | S_IWUSR,
+ 		   syn_show_attr_virtualized, syn_store_attr_virtualized);


In the function which reports the values to input subsystem we can then decide to make the second one as an extension of the first touchscreen if

* virtualized is set to 1
* and touchscreen sensor is the second one


 + if (ts->virtualized && dev_name(&sensor->dev == '2')
 +	data->x = ts->touch_caps.max_x + d->x;
 [..]
 + input_report_abs(idev, ABS_x, data->x);


I'd appreciate any comments on this approach...

Best Regards
Abraham

