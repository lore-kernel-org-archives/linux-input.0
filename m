From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Thu, 11 Feb 2010 17:20:57 -0800
Message-ID: <20100212012057.GC6394@core.coreip.homeip.net>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
 <20100212003604.GA6394@core.coreip.homeip.net>
 <4B74A8F8.3010701@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:50214 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab0BLBVG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 20:21:06 -0500
Received: by ywh27 with SMTP id 27so1725519ywh.1
        for <linux-input@vger.kernel.org>; Thu, 11 Feb 2010 17:21:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B74A8F8.3010701@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

On Thu, Feb 11, 2010 at 08:03:52PM -0500, Rafi Rubin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >>  	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
> >>  	if (!nd) {
> >> @@ -255,14 +271,36 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >>  	if (!ret)
> >>  		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> >>  
> >> -	if (ret)
> >> +	if (ret) {
> >>  		kfree (nd);
> > 
> > What about hid_hw_stop()? Overall I'd rather see the standard error
> > unwinding path with gotos.
> 
> Cleaning up the probe function.  But it looks like the last caught error is from start, so is it fair to leave out stop?

Ah, yes, my bad.

-- 
Dmitry
