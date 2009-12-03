From: Peter Hutterer <peter.hutterer@redhat.com>
Subject: Re: [PATCH] HID: add multi-input quirk for NextWindow Touchscreen.
Date: Fri, 04 Dec 2009 08:07:34 +1000
Message-ID: <4B1836A6.405@redhat.com>
References: <20091203050810.GA26595@barra.bne.redhat.com> <87zl60s17o.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbZLCWI6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Dec 2009 17:08:58 -0500
In-Reply-To: <87zl60s17o.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/12/09 22:15, Peter Korsgaard wrote:
>>>>>> "Peter" == Peter Hutterer<peter.hutterer@redhat.com>  writes:
>
>   Peter>  These touchscreens are mounted onto HP TouchSmart and the Dell
>   Peter>  Studio One 19. Without a quirk they report a wrong button set
>   Peter>  and the x/y coordinates through ABS_Z/ABS_RX, confusing the
>   Peter>  higher levels (most notably X.Org's evdev driver).
>
> What exactly does this fix? I've been using NW touchscreens for a while
> and don't recall any issues (admittedly only used it with evtouch).

evtouch has the following code:

         if ( (ev->code == ABS_X) || (ev->code == ABS_Z) ) {
                 priv->raw_x = ev->value;
                 pos_changed = 1;
         }

         if ( (ev->code == ABS_Y) || (ev->code == ABS_RX) ) {
                 priv->raw_y = ev->value;
                 pos_changed = 1;
         }

it's a hack in userspace that works around wrong event reporting. So 
yes, it works if you're using evtouch but if you want to use any other 
driver that driver needs the same hack. treating Z as X and RX as Y 
doesn't work too well for a generic driver such as evdev, which has to 
deal with devices where RX is a valid axis.

Cheers,
   Peter
