From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v0 7/8] Input: ims-pcu: use firmware_stat instead of
 completion
Date: Wed, 3 Aug 2016 10:39:55 -0700
Message-ID: <20160803173955.GD13516@tuxbot>
References: <c05a7b98-5ada-701f-9a77-65d81b841c17@bmw-carit.de>
 <ee9a29aa-0d29-a33f-e43a-057dc359cf89@broadcom.com>
 <20160730165817.GQ3296@wotan.suse.de>
 <C528E404-0CA5-46B4-B551-B1D4B58BC053@gmail.com>
 <37a3cd66-262e-ffbe-ea7a-a6d5b1ca1c8b@bmw-carit.de>
 <20160801194408.GZ3296@wotan.suse.de>
 <0f9350fa-e8b5-9d64-b2d3-afda5e5f6bbf@bmw-carit.de>
 <20160802063419.GG3296@wotan.suse.de>
 <2713d779-ef55-793d-f37e-d1414bb1bfc2@bmw-carit.de>
 <20160802074106.GI3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160802074106.GI3296-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Wagner <daniel.wagner-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Daniel Wagner <wagi-kQCPcA+X3s7YtjvyW6yDsg@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue 02 Aug 00:41 PDT 2016, Luis R. Rodriguez wrote:

> On Tue, Aug 02, 2016 at 08:53:55AM +0200, Daniel Wagner wrote:
> > On 08/02/2016 08:34 AM, Luis R. Rodriguez wrote:
> > >On Tue, Aug 02, 2016 at 07:49:19AM +0200, Daniel Wagner wrote:
> > >>>The sysdata API's main goal rather is to provide a flexible API first,
> > >>>compartamentalizing the usermode helper was secondary. But now it seems
> > >>>I may just also add devm support too to help simplify code further.
> > >>
> > >>I missed the point that you plan to add usermode helper support to
> > >>the sysdata API.
> > >
> > >I had no such plans, when I have asked folks so far about "hey are you
> > >really in need for it, OK what for? " and "what extended uses do you
> > >envision?" so I far I have not gotten any replies at all. So -- instead
> > >sysdata currently ignores it.
> > 
> > So you argue for the remoteproc use case with 100+ MB firmware that
> > if there is a way to load after pivot_root() (or other additional
> > firmware partition shows up) then there is no need at all for
> > usermode helper?
> 
> No, I'm saying I'd like to hear valid uses cases for the usermode helper and so
> far I have only found using coccinelle grammar 2 explicit users, that's it. My
> patch series (not yet merge) then annotates these as valid as I've verified
> through their documentation they have some quirky requirement.
> 

I think we're on the same page, but just to make sure; I do not want the
usermode helper, I only want a way to wait for the firmware files to
become available.

> Other than these two drivers I'd like hear to valid requirements for it.
> 
> The existential issue is a real issue but it does not look impossible to
> resolve. It may be a solution to bloat up the kernel with 100+ MB size just to
> stuff built-in firmware to avoid this issue, but it does not mean a solution
> is not possible.
> 
> Remind me -- why can remoteproc not stuff the firmware in initramfs ?
> 

RAM usage:
Storing the files in initramfs would consume 100MB RAM, we would then
allocate 100MB RAM for buffers during firmware loading and then we have
the reserved 100MB for the peripherals. The buffers could be easily be
removed with a mechanism for providing a buffer to the load operation,
but we would still double the RAM consumption.

Boot time:
Enlarging the kernel by 100MB will give noticeable addition to boot
times.

Development issues:
I have numerous concerns related to this, e.g. not being able to side
load the firmware files without rebuilding the initramfs. But most of
these are not technical issues, but rather a matter of convenience.

One large issue would be how to figure out how large to make the boot
partition in your Android phone, to cope with potential future growth in
firmware size - which has already proven to be a mess.

Legal matters:
Some of these firmware files are not redistributable, making it
impossible for end users to rebuild their kernel without loosing
functionality. There are even cases where these files are not allowed to
share partition with GPL binaries.


Most of these are just a major inconveniences to the developer but some
are show stoppers; especially the legal matters. So if we wave this off
as something people can live without then every downstream will sit on
their own solution to reimplement it.

> Anyway, here's a simple suggestion: fs/exec.c gets a sentinel file monitor
> support per enum kernel_read_file_id. For instance we'd have one for
> READING_FIRMWARE, one for READING_KEXEC_IMAGE, perhaps READING_POLICY, and this
> would in turn be used as the system configurable deterministic file for
> which to wait for to be present before enabling each enum kernel_read_file_id
> type read.
> 
> Thoughts ?

That does sound like a good generic solution for our problem and for the
other types of files as well. Do you have any ideas (patches?) on how
each sentinel would be triggered?

The only concern I can think of right now is that the
firmware_class.path might point to a separate partition; but based on
how the signaling of the sentinels are implemented this might not be an
issue.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
