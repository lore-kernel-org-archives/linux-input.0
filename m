From: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2] input: tablet: pegasus_notetaker: USB PM fixes
Date: Tue, 28 Jun 2016 18:17:13 +0200
Message-ID: <246597fa-6a85-1128-853d-3ebdf6f41032@posteo.de>
References: <1465903215-2351-1-git-send-email-martink@posteo.de>
 <20160623171835.GE32561@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160623171835.GE32561@dtor-ws>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am 2016-06-23 um 19:18 schrieb Dmitry Torokhov:
> Hi Martin,
> 
> On Tue, Jun 14, 2016 at 01:20:15PM +0200, Martin Kepplinger wrote:
>>  static int pegasus_reset_resume(struct usb_interface *intf)
>>  {
>> +	struct pegasus *pegasus = usb_get_intfdata(intf);
>> +
>> +	if (pegasus->dev->users)
>> +		pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
>> +
>>  	return pegasus_resume(intf);
> 
> Hmm, we need to take input mutex when using pegasus->dev->users, how
> about the version below instead?
> 
> Thanks.
> 

Sorry for the delay, give me a few more days to test and confirm this or
come up with a final patch.

thanks
                            martin
