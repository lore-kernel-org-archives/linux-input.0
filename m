From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [v2] input: smb380 accelerometer driver
Date: Fri, 10 Sep 2010 16:47:51 -0400
Message-ID: <4C8A9977.9090101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24249 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab0IJUrx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Sep 2010 16:47:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Donggeun Kim <dg77.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 15 Jul 2010 08:58:42, Donggeun Kim wrote:
 > Changes from v1 to v2:
 > - clean up the code based on v1 feedback
 >
 > This patch supports driver for BOSCH SMB380 and BMA023 which are
 > accelerometers.
 >
 > Basically, this driver will read x, y, and z coordinate registers
 > from the device and report the values to users through sysfs
 > interface.

...

 > Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
 > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

[..snip ..]

https://patchwork.kernel.org/patch/112207/

Does anyone know the status of this patch? I'd be interested in having a 
driver for this device mainlined. Looks like it was posted a couple of 
months ago, but I didn't see any followup. If it's a candidate for being 
mainlined I have a small patch I'd like to add to it (support 'any 
motion' register).

Thanks.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
