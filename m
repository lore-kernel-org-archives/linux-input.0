From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 10:15:25 -0600
Message-ID: <CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
References: <20111116095030.GC3335@slate>
	<CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
	<20111116102514.GA3831@slate>
	<CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
	<20111116145518.GA7080@slate>
	<20111116154049.GA8444@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab1KPQP1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 11:15:27 -0500
Received: by eye27 with SMTP id 27so615083eye.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 08:15:26 -0800 (PST)
In-Reply-To: <20111116154049.GA8444@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 9:40 AM, Cedric Sodhi <manday@gmx.net> wrote:
> Thanks to Benjamin's help and his neat patch which allows tempering with
> quirks through sysfs, I got the device
>
> eGalax 0eef:a001
>
> to work. It works with the quirks
>
> MT_QUIRK_SLOT_IS_CONTACTID | MT_QUIRK_ALWAYS_VALID ( = 18 )
>
> so, using Benjamin's interface:
>
> (1) Adding the device with
> $ cd '/sys/modules/hid_multitouch/driver/hid:hid-multitouch'
> $ echo "3 0eef a001 1" > new_id
>
> (2) Setting the quirks with
> $ echo 18 > '0003:0EEF:A001.0001/quirks'
>
> That's it. The device works!

Benjamin, do you have a take away from this?  We are setting quirks to
0x62 which should same as 0x12 for most purposes.  Combine this with
the Acer eGalax patch and my guess is its .maxcontacts = 2 thats
hurting things?

If so, do you have enough report descriptors to know if we can remove
it for all or if we need to create an MT_CLS_EGALAX_HAS_MAXCONTACTS?
My guess is for the ones that have correct MAXCONTACTS, they also have
valid logical X/Y sizes and so we can remote that quirk as well.  At
least this one does.

Chris

>
> regards,
> Cedric
>
