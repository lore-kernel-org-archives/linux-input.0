From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 14:38:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006301437420.13809@pobox.suse.cz>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com> <4C2A1FA0.6020704@signal11.us> <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz> <AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com> <alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
 <4C2B3956.6080107@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C2B3956.6080107-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 30 Jun 2010, Alan Ott wrote:

> > > ioctl  which sets a flag so that when device sends a report , report
> > > id&  report type  is prefixed
> > > to output of read() .
> > > i mean when application calls read , it gets input report as<report
> > > id><report type><payload>
> > > right now we get<payload>  only .
> > >      
> > Please see the commit 5a38f2c7c4dd53d5be097930902c108e362584a3. That makes
> > sure that report id should be there properly. Do you still see any problem
> > with this commit applied? (2.6.34 is the first kernel to have this one).
> >    
> 
> That commit removes an extra byte from the beginning of reports handed to
> read(). If I understand correctly, it doesn't do what he's asking.
> 
> For devices which use numbered reports, reports which come from read() have
> the report ID at the beginning, in the form:
> <report_id><payload>
> 
> For devices which do _not_ use numbered reports, only the payload is sent. Of
> course, since the device only uses a single report, a report number does not
> even make sense, and is not needed, since you know which report it is (as
> there is only one). The form is:
> <payload>
> 
> It is not necessary to return the report type, because the read() interface
> will only give you INPUT reports which come over the INTERRUPT IN endpoint
> (usually EP 1 IN). FEATURE reports must come through the GET_FEATURE request
> over the CONTROL endpoint, initiated by the HIDIOCGFEATURE ioctl (Note that
> this ioctl is part of what Jiri has staged for the next merge window, and is
> not part of the current 2.6.34 Kernel). OUTPUT reports are never sent from the
> device on the INTERRUPT IN endpoint. In short, if it comes from read(), it's
> always an INPUT report.

Ah, OK, I likely misunderstood what Amit has been actually asking for. The 
situation is exactly the way Alan has described it.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
