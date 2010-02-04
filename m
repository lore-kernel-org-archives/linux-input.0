From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 1/1] media: dvb-usb/af9015, fix disconnection crashes
Date: Thu, 04 Feb 2010 12:05:52 -0200
Message-ID: <4B6AD440.9060300@redhat.com>
References: <1264007972-6261-1-git-send-email-jslaby@suse.cz> <4B5CDB53.6030009@iki.fi> <4B5D6098.7010700@gmail.com> <4B5DDDFB.5020907@iki.fi> <alpine.LRH.2.00.1001261406010.15694@twin.jikos.cz> <4B6AA211.1060707@gmail.com> <4B6AB7E9.40607@redhat.com> <4B6AC333.6030308@gmail.com> <4B6ACEA3.3080900@redhat.com> <4B6AD0EE.9060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4B6AD0EE.9060801@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Antti Palosaari <crope@iki.fi>, mchehab@infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Pekka Sarnila <sarnila@adit.fi>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Jiri Slaby wrote:
> On 02/04/2010 02:41 PM, Mauro Carvalho Chehab wrote:
>> The point is that it is better to name the function right since the beginning.
> 
> Sorry, I misunderstood you for the first time. It's .event member of
> hid_driver. Hence I named it dvb_event (or now rc_event or whatever).
> 
> The function may contain decisions on what to do with the event based
> for example on quirks set up in .probe. And if the function grows later,
> it may be factored out to rc_nokeyup_event. But rc_event is a root for
> the decision tree and it should be there forever. Does it make sense now?

Ah, ok. Due to the comments at the function, I misunderstood that you were
planning to have separate functions for separate quirks.


-- 

Cheers,
Mauro
