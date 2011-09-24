From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: lis3dh: Add driver for lis3dh accelerometer
Date: Fri, 23 Sep 2011 23:09:18 -0700
Message-ID: <20110924060918.GB30737@core.coreip.homeip.net>
References: <1316512332-8336-1-git-send-email-dg77.kim@samsung.com>
 <4E786A38.8050109@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64012 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab1IXGJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Sep 2011 02:09:24 -0400
Received: by yib18 with SMTP id 18so3112381yib.19
        for <linux-input@vger.kernel.org>; Fri, 23 Sep 2011 23:09:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E786A38.8050109@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Donggeun Kim <dg77.kim@samsung.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com, Eric Piel <eric.piel@tremplin-utc.net>

On Tue, Sep 20, 2011 at 11:26:00AM +0100, Jonathan Cameron wrote:
> > +
> > +enum lis3dh_interrupt_mode {
> > +	LIS3DH_OR_COMBINATION = 0x00,
> > +	LIS3DH_6D_MOVEMENT = 0x40,
> > +	LIS3DH_AND_COMBINATION = 0x80,
> > +	LIS3DH_6D_POSITION = 0xc0,
> > +};
> Enums seem silly when you don't have at least
> vaguely consecutive values.  Why not just use defines?

Actually enums are not quite silly as compiler can warn you if you
handle all possible cases in a switch() statement.

Thanks.

-- 
Dmitry
