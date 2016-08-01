From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v0 7/8] Input: ims-pcu: use firmware_stat instead of
 completion
Date: Mon, 1 Aug 2016 21:44:08 +0200
Message-ID: <20160801194408.GZ3296@wotan.suse.de>
References: <1469692512-16863-1-git-send-email-wagi@monom.org>
 <1469692512-16863-8-git-send-email-wagi@monom.org>
 <20160728183343.GD16852@dtor-ws>
 <20160728190151.GV13516@tuxbot>
 <c05a7b98-5ada-701f-9a77-65d81b841c17@bmw-carit.de>
 <ee9a29aa-0d29-a33f-e43a-057dc359cf89@broadcom.com>
 <20160730165817.GQ3296@wotan.suse.de>
 <C528E404-0CA5-46B4-B551-B1D4B58BC053@gmail.com>
 <37a3cd66-262e-ffbe-ea7a-a6d5b1ca1c8b@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37a3cd66-262e-ffbe-ea7a-a6d5b1ca1c8b-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Wagner <daniel.wagner-98C5kh4wR6ohFhg+JK9F0w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Wagner <wagi-kQCPcA+X3s7YtjvyW6yDsg@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 01, 2016 at 02:26:04PM +0200, Daniel Wagner wrote:
> On 07/31/2016 09:23 AM, Dmitry Torokhov wrote:
> >On July 30, 2016 9:58:17 AM PDT, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >>On Sat, Jul 30, 2016 at 02:42:41PM +0200, Arend van Spriel wrote:
> >>>On 29-07-16 08:13, Daniel Wagner wrote:
> >>>>On 07/28/2016 09:01 PM, Bjorn Andersson wrote:
> >>>>>On Thu 28 Jul 11:33 PDT 2016, Dmitry Torokhov wrote:
> 
> >>>+ Luis (again) ;-)
> 
> That was not on purpose :) My attempt to keep the Cc list a bit
> shorter was a failure.
> 
> >>>>>>Do not quite like it... I'd rather asynchronous request give out
> >>>>>>firmware status pointer that could be used later on.
> >>>
> >>>Excellent. Why not get rid of the callback function as well and have
> >>>fw_loading_wait() return result (0 = firmware available, < 0 = fail).
> >>>Just to confirm, you are proposing a new API function next to
> >>>request_firmware_nowait(), right?
> >>
> >>If proposing new firmware_class patches please bounce / Cc me, I've
> >>recently asked for me to be added to MAINTAINERS so I get these
> >>e-mails as I'm working on a new flexible API which would allow us
> >>to extend the firmware API without having to care about the old
> >>stupid usermode helper at all.
> 
> These patches here are a first attempt to clean up a bit of the code
> around the completion API. As Dmitry correctly pointed out, it makes
> more sense to go bit further and make the async loading a bit more
> convenient for the drivers.
> 
> >I am not sure why we started calling usermode helper "stupid". We
> >only  had to implement direct kernel firmware loading because udev/stsremd
> >folks had "interesting" ideas how events should be handled; but having
> >userspace to feed us data is not stupid.
> 
> I was ignorant on all the nasty details around the firmware loading.
> If I parse Luis' patches correctly they introduce an API which calls
> kernel_read_file_from_path() asynchronously:
> 
> sysdata_file_request_async(..., &cookie)
>   *coookie = async_schedule_domain(request_sysdata_file_work_func(), ..)
> 
>   request_sysdata_file_work_fun()
>     _sysdata_file_request()
>       fw_get_filesystem_firmware()
> 	kernel_read_file_from_path()
> 
> sysdata_synchronize_request(&cookie);
> 
> Doesn't look like what your asking for.

No, but its also a generic kernel read issue as I noted in my last
reply.

> >If we want to overhaul firmware loading support we need to figure
> >out  how to support case when a driver want to [asynchronously] request
> >firmware/config/blob and the rest of the system is not ready. Even if we
> >want kernel to do read/load the data we need userspace to tell kernel
> >when firmware partition is available, until then the kernel should not
> >fail the request.
> 
> I gather from Luis' blog post and comments that he is on the quest
> on removing userspace support completely.

No, I explained in my last proposed documentation patch series that we cannot
get rid of the usermode helper. Its not well understood why so I explained and
documented why. Best we can do is compartamentalize its uses.

The sysdata API's main goal rather is to provide a flexible API first,
compartamentalizing the usermode helper was secondary. But now it seems
I may just also add devm support too to help simplify code further.

What Dmitry notes is an existential issue with kernel_read_file_from_path()
and we need a common solution for it.

> Maybe this attempt here could be a step before. Step 1 would be
> changing request_firmware_nowait() to request_firmware_async so
> drivers don't have to come up with their own sync primitives, e.g.
> 
>   cookie = request_firmware_async()
>   fw_load_wait(cookie)

That's one of the features already part of async mechanism of the sysdata API :)

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
