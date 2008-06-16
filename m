From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 06/10] HID: move logitech report quirks
Date: Mon, 16 Jun 2008 12:15:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806161214130.10085@jikos.suse.cz>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-2-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-3-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-4-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-5-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-6-git-send-email-jirislaby@gmail.com>
 <Pine.LNX.4.64.0806041415130.10085@jikos.suse.cz> <484D061E.5000308@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752749AbYFPKP4@vger.kernel.org>
In-Reply-To: <484D061E.5000308@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com
List-Id: linux-input@vger.kernel.org

On Mon, 9 Jun 2008, Jiri Slaby wrote:

> > > Move them from core code to a separate driver.
> > is there a reason why this moves only the report descriptor 
> > Logitech-specific quirks, but leaves the input mapping still in 
> > hid-input-quirks.c and doesn't move it into ->input_mapping method 
> > too?
> No, there is no strong reason, I just postponed it to the second round of
> changes. I wanted to hear comments first, so I only moved fully only apple
> driver (to present how the concept was thought). After things settle down, I'm
> going to move the rest of quirks including this one.

Thanks a lot. Would you please care to do another round of submission, 
with the missing assignment fixed in the apple driver, and also with the 
->input_mapping added too?

I would like to avoid a situation when we have a part of functionality for 
certain devices implemented in generic driver and a part in specialized 
driver, if possible.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
