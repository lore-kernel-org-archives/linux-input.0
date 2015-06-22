From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - enable ELAN0600 acpi panels
Date: Mon, 22 Jun 2015 14:37:16 -0700
Message-ID: <20150622213716.GE2350@dtor-ws>
References: <1427837698-419-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150403210544.GC19867@dtor-ws>
 <7C88A00C-F6E1-4FCD-8E77-7969BEB3F7C1@emc.com.tw>
 <20150611201948.GE32361@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:32895 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbbFVVhU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2015 17:37:20 -0400
Received: by ieqy10 with SMTP id y10so36020271ieq.0
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2015 14:37:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150611201948.GE32361@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: duson <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>, Alessio Treglia <alessio@debian.org>, =?iso-8859-1?Q?J=FCrgen?= Bausa <Juergen.Bausa@online.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.com

On Thu, Jun 11, 2015 at 04:19:48PM -0400, Benjamin Tissoires wrote:
> On Apr 09 2015 or thereabouts, duson wrote:
> > Hi Dmitry,
> > 
> > Sorry later for reply. If touchpad is designed for Window OS, 
> > the firmware will support standard HID mouse format (non-driver) and elan raw data format (with driver).
> > 
> > So, if user change OS from Window to Linux, touchpad will work fine under HID format.
> > 
> 
> Well, Jurgen reported a ELAN0100 (04F3:0401) which is similar but does
> not work with the below patch (when adapted to match his PID).
> And like under Windows, the HID mouse report format is just not enough under
> Linux. We need to have access to the raw touches to be able to provide a
> consistent experience. So we need to get his device access to the
> proprietary raw format.
> 
> I think what makes Jurgen's device unhappy is that the length of the
> report 0x5d is 27 instead of 31 (according to the report descriptors).
> But elan_i2c_i2c.c checks for the length of the report and fails (only
> suppositions).
> 
> I would be happy to help here, but it looks like it is going to be
> difficult to remotely debug this and switch the whole driver into HID,
> especially given that elan_i2c_i2c uses a non-HID command to set the
> touchpad in the absolute mode.
> 
> So basically, I don't know what to do for Jurgen, but we could still
> enable Alessio's touchpad (the ELAN0600, below). Jiri, Dmitry?

Yes, if the controller indeed has basic HID mode + advanced proprietary
protocol we should blacklist it in HID and let elan driver handle the
device. Devices that speak proper HID (both basic and multitouch) should
be handled by HID.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
