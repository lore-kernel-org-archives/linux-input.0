From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] input: lis3dh: Add driver for lis3dh accelerometer
Date: Mon, 26 Sep 2011 09:50:00 +0100
Message-ID: <4E803CB8.8070305@cam.ac.uk>
References: <1316512332-8336-1-git-send-email-dg77.kim@samsung.com> <4E786A38.8050109@cam.ac.uk> <20110924060918.GB30737@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:42210 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1IZIlj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 04:41:39 -0400
In-Reply-To: <20110924060918.GB30737@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Donggeun Kim <dg77.kim@samsung.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com, Eric Piel <eric.piel@tremplin-utc.net>

On 09/24/11 07:09, Dmitry Torokhov wrote:
> On Tue, Sep 20, 2011 at 11:26:00AM +0100, Jonathan Cameron wrote:
>>> +
>>> +enum lis3dh_interrupt_mode {
>>> +	LIS3DH_OR_COMBINATION = 0x00,
>>> +	LIS3DH_6D_MOVEMENT = 0x40,
>>> +	LIS3DH_AND_COMBINATION = 0x80,
>>> +	LIS3DH_6D_POSITION = 0xc0,
>>> +};
>> Enums seem silly when you don't have at least
>> vaguely consecutive values.  Why not just use defines?
> 
> Actually enums are not quite silly as compiler can warn you if you
> handle all possible cases in a switch() statement.
> 
> Thanks.
> 
Fair point, if that is happening.  Right now none of this stack of enums
seems to even be used and so I'm not sure which ones would make sense in
a switch (or if they should be there at all).
