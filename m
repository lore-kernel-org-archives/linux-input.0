From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v0 7/8] Input: ims-pcu: use firmware_stat instead of
 completion
Date: Wed, 3 Aug 2016 17:55:40 +0200
Message-ID: <20160803155540.GL3296@wotan.suse.de>
References: <ee9a29aa-0d29-a33f-e43a-057dc359cf89@broadcom.com>
 <20160730165817.GQ3296@wotan.suse.de>
 <C528E404-0CA5-46B4-B551-B1D4B58BC053@gmail.com>
 <37a3cd66-262e-ffbe-ea7a-a6d5b1ca1c8b@bmw-carit.de>
 <20160801194408.GZ3296@wotan.suse.de>
 <0f9350fa-e8b5-9d64-b2d3-afda5e5f6bbf@bmw-carit.de>
 <20160802063419.GG3296@wotan.suse.de>
 <2713d779-ef55-793d-f37e-d1414bb1bfc2@bmw-carit.de>
 <20160802074106.GI3296@wotan.suse.de>
 <ef14dc68-d2f8-0934-7be5-dfb3a4771f27@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ef14dc68-d2f8-0934-7be5-dfb3a4771f27-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Wagner <daniel.wagner-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jeff Mahoney <jeffm-IBi9RG/b67k@public.gmane.org>
Cc: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Wagner <wagi-kQCPcA+X3s7YtjvyW6yDsg@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 03, 2016 at 08:57:09AM +0200, Daniel Wagner wrote:
> On 08/02/2016 09:41 AM, Luis R. Rodriguez wrote:
> >On Tue, Aug 02, 2016 at 08:53:55AM +0200, Daniel Wagner wrote:
> >>On 08/02/2016 08:34 AM, Luis R. Rodriguez wrote:
> >>>On Tue, Aug 02, 2016 at 07:49:19AM +0200, Daniel Wagner wrote:
> >>So you argue for the remoteproc use case with 100+ MB firmware that
> >>if there is a way to load after pivot_root() (or other additional
> >>firmware partition shows up) then there is no need at all for
> >>usermode helper?
> >
> >No, I'm saying I'd like to hear valid uses cases for the usermode helper and so
> >far I have only found using coccinelle grammar 2 explicit users, that's it. My
> >patch series (not yet merge) then annotates these as valid as I've verified
> >through their documentation they have some quirky requirement.
> 
> I got that question wrong. It should read something like 'for the
> remoteproc 100+MB there is no need for the user help?'.

That's not a question for me but for those who say that the usermode helper
is needed for remoteproc, so far from what folks are saying it seems the only
reason for the usermodehelper was to try to avoid the deterministic issue,
but I suggested a way to resolve that without the usermode helper now so
would be curious to hear if there are any more reasons for it.

> I've gone
> through your patches and they make perfectly sense too. Maybe I can
> convince you to take a better version of my patch 3 into your queue.
> And I help you converting the exiting drivers. Obviously if you like
> my help at all.

I accept all help and would be glad to make enhancements instead of
the old API through new API. The biggest thing here first I think is
adding devm support, that I think should address what seemed to be
the need to add more code for a transformation into the API. I'd
personally only want to add that and be done with an introduction
of the sysdata API. Further changes IMHO are best done atomically
after that on top of it, but I'm happy to queue in the changes.

> >Other than these two drivers I'd like hear to valid requirements for it.
> >
> >The existential issue is a real issue but it does not look impossible to
> >resolve. It may be a solution to bloat up the kernel with 100+ MB size just to
> >stuff built-in firmware to avoid this issue, but it does not mean a solution
> >is not possible.
> >
> >Remind me -- why can remoteproc not stuff the firmware in initramfs ?
> 
> I don't know. I was just bringing it up with the hope that Bjorn
> will defend it. It seems my tactics didn't work out :)

OK.

> >Anyway, here's a simple suggestion: fs/exec.c gets a sentinel file monitor
> >support per enum kernel_read_file_id. For instance we'd have one for
> >READING_FIRMWARE, one for READING_KEXEC_IMAGE, perhaps READING_POLICY, and this
> >would in turn be used as the system configurable deterministic file for
> >which to wait for to be present before enabling each enum kernel_read_file_id
> >type read.
> >
> >Thoughts ?
> 
> Not sure if I get you here correctly. Is the 'system configurable
> deterministic file' is a knob which controlled by user space? Or it
> this something you define at compile time?

I meant at compile time on the kernel. So CONFIG_READ_READY_SENTINEL
or something like this, and it be a string, which if set then when
the kernel read APIs are used, then a new API could be introduced
that would *only* enable reading through once that sentinel has
been detected by the kernel to allowed through reads. Doing this
per mount / target filesystem is rather cumbersome given possible
overlaps in mounts and also pivot_root() being possible, so instead
targeting simply the fs/exec.c enum kernel_read_file_id would seem
more efficient and clean but we would need a decided upon set of
paths per enum kernel_read_file_id as base (or just one path per
enum kernel_read_file_id). For number of paths I mean the number
of target directories to look for the sentinel per enum kernel_read_file_id,
so for instance for READING_FIRMWARE perhaps just deciding on /lib/firmware/
would suffice, but if this supported multiple paths another option may be
for the sentinel to also be looked for in /lib/firmware/updates/,
/lib/firmware/" UTS_RELEASE -- etc. It would *stop* after finding one
sentinel on any of these paths.

If a system has has CONFIG_READ_READY_SENTINEL it would mean an agreed upon
system configuration has been decided so that at any point in time reads
against READING_FIRMWARE using a new kernel_read_file_from_path_sentinel()
(or something like it) would only allow the read to go through once
the sentinel has been found for READING_FIRMWARE on the agreed upon
paths.

The benefit of the sentintel approach is it avoids complexities with
pivot_root(), and makes the deterministic aspect of the target left
only to a system-configuration enabled target path / file.

This is just an idea. I'd like some FS folks to review.

> Hmm, so it would allow to decided to ask a userspace helper or load
> the firmware directly (to be more precised the kernel_read_file_id
> type). If yes, than it is what currently already have just
> integrated nicely into the new sysdata API.

Sorry, no, the above description is better of what I meant. This
actually would not need to go into the sysdata API, unless of
course we wanted it just as a new "feature" of it, but I don't
think that's needed unless it has some implications behind the
scenes. Given that firmware_class now uses a common core kernel
API for reading files kernel_read_file_from_path() we could
for instance add kernel_read_file_from_sentintel() and only
if CONFIG_READ_READY_SENTINEL() would it block and wait until
the sentinel clears. This should mean being able to make the
change for both the old API and the new proposed sysdata API.
Likewise for other kernel_read_file*() users -- they'd benefit
from it as well.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
