From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Wed, 10 Mar 2010 16:09:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003101607560.18642@pobox.suse.cz>
References: <1268065277-30129-1-git-send-email-tissoire@cena.fr> <1268065277-30129-2-git-send-email-tissoire@cena.fr> <1268065277-30129-3-git-send-email-tissoire@cena.fr> <1268065277-30129-4-git-send-email-tissoire@cena.fr> <1268065277-30129-5-git-send-email-tissoire@cena.fr>
 <4B95255B.5010900@cena.fr> <alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz> <4B952C77.3080505@cena.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51663 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077Ab0CJPJl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Mar 2010 10:09:41 -0500
In-Reply-To: <4B952C77.3080505@cena.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <tissoire@cena.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

On Mon, 8 Mar 2010, Benjamin Tissoires wrote:

> > Well ... I don't see any patch titled "HID: deletion of unused code in
> > hid-magicmouse" neither in my inbox nor in my linux-input@ folder. Could
> > you perhaps please resend?
> > 
> > Thanks,
> 
> Of course, I attached it. Do I need to send it in mbox format or is it ok ?

Well, magicmouse_setup_input() is actually used from inside the probe 
routine, so we'd rather not remove it.

I have already merged Michael's patch with calls hid_hw_start() with 
HID_CONNECT_HIDINPUT flag cleared out, so the registration of the input 
device is now performed properly.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
