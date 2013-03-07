From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 1/2] HID: Extend the interface with idle requests
Date: Thu, 7 Mar 2013 15:53:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303071552280.28677@pobox.suse.cz>
References: <1361979498-24446-1-git-send-email-benjamin.tissoires@redhat.com> <1361979498-24446-2-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1303071526040.28677@pobox.suse.cz>
 <CAN+gG=EzYiUujj6XB96KF4c1OEQE65KeNeaufGOzykVgvG4Qjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39658 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab3CGOxv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Mar 2013 09:53:51 -0500
In-Reply-To: <CAN+gG=EzYiUujj6XB96KF4c1OEQE65KeNeaufGOzykVgvG4Qjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 7 Mar 2013, Benjamin Tissoires wrote:

> >> +static int usbhid_idle(struct hid_device *hid, int report, int idle,
> >> +             int reqtype)
> >
> > Where does the need for passing the report argument come from please?
> 
> Well, I haven't checked in the USB spec, but hid_set_idle() in
> usbhid/hid-core.c does require the reportID, so I add it to the
> request.
> I just gave a quick look at the HID/I2C spec, and it also requires the
> report ID. The set_idle request is report specific.

You are right, I have missed the special meaning of lower byte of wValue.

Okay, I think it makes sense. I will be taking the patches.

Thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs
