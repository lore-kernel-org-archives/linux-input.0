From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] devicetree: bindings: use input-event-codes.h for
 evdev codes
Date: Thu, 17 Sep 2015 15:35:03 -0400
Message-ID: <55FB15E7.6080502@redhat.com>
References: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
 <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
 <1442316292.3549.386.camel@hellion.org.uk> <55F97C3D.5020702@redhat.com>
 <1442414443.18856.110.camel@hellion.org.uk>
 <1442487617.18856.177.camel@hellion.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442487617.18856.177.camel-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 09/17/2015 07:00 AM, Ian Campbell wrote:
> On Wed, 2015-09-16 at 15:40 +0100, Ian Campbell wrote:
>>> The intend of the symlink was that the conversion script would copy the target,
>>> rather then follow the symlink. This sorta assumes that there are will be not
>>> symlinks under dt-bindings which link to files inside dt-bindings and thus
>>> should be preserved as symlinks.
>>>
>>> If the copy done in the script will follow the symlink then nothing should
>>> really change for the split DT repo.
>>
>> Interesting idea. I'll see if I can make the conversion routine do that.
>>
>> TBH I have a horrid feeling that this is going to be beyond git rewrite
>> -branch, at least in the mode it is used in today.
>
> It seems that it is possible, after a fashion.
>
> The downside is that either _all_ symlinks (which end up in the output) get
> flattened or some sort of black/whitelisting is needed in the conversion
> scripts themselves (potentially leading to issues or discontinuities) as
> new stuff arrives).
>
> It isn't possible AFAICT tell if a symlink points to something outside of
> the converted set of paths and adjust, at least not without an unreasonable
> amount of overhead on each commit during the rewrite.
>
> Since this new file would be the first symlink in the converted repo I took
> the former approach in my lash up to try it out

Ack, sounds good.

> which was essentially to
> insert the below script into the middle of the "git ls-files | rewrite
> -paths.sed" pipeline which is called by git filter-branch --index-filter.
> Not pretty but it does seem to work.
>
> I want to avoid switching to --tree-filter if at all possible because it
> checks out the tree and is therefore a _little_ I/O intensive ;-)

Thanks for your work on this, so what does this mean for moving forward
with the patch-set I posted. Can this be merged now ? And if not what
are we waiting for ?

Regards,

Hans



>
> Ian.
>
> #!/bin/bash
>
> set -e
>
> while read mode object stage path ; do
>      case "$mode" in
> 	120000)
> 	    # symbolic link
> 	    deref=$(echo $GIT_COMMIT:$path | git cat-file --batch-check='deref-ok %(objectname)' --follow-symlinks)
> 	    case "$deref" in
> 		deref-ok*)
> 		    echo -e "100644 ${deref#deref-ok } $stage\t$path"
> 		    ;;
> 		dangling*) # skip
> 		    ;;
> 		*) # the rest, missing etc
> 		    echo >&2 "Failed to parse symlink $GIT_COMMIT:$path $deref"
> 		    exit 1
> 		    ;;
> 	    esac
> 	    ;;
> 	100*)
> 	    # Regular file, just pass through
> 	    echo -e "$mode $object $stage\t$path"
> 	    ;;
> 	*)
> 	    echo >&2 "Unhandled ls-tree entry: $line"
> 	    exit 1
> 	    ;;
>      esac
> done
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
