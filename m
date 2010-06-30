From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 12:55:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com> <4C2A1FA0.6020704@signal11.us> <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz> <AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 30 Jun 2010, Amit Nagal wrote:

> 1)
> 
> ioctl with which application can get  input / output feature report and size .

I am not sure I understand what exactly you mean.

hidraw intentionally doesn't interpret the reports, it's completely up to 
userspace application to do that.

> 2)
> 
> ioctl  which sets a flag so that when device sends a report , report
> id & report type  is prefixed
> to output of read() .
> i mean when application calls read , it gets input report as <report
> id ><report type ><payload >
> right now we get <payload > only .

Please see the commit 5a38f2c7c4dd53d5be097930902c108e362584a3. That makes 
sure that report id should be there properly. Do you still see any problem 
with this commit applied? (2.6.34 is the first kernel to have this one).

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
