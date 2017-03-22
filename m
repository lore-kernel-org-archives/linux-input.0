From: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Input: max11801_ts: Add missing of_match_table
Date: Thu, 23 Mar 2017 00:19:02 +0530
Message-ID: <CAMty3ZCtv1a=YNcZ+WXP=-P1DN5NQe975G4DbR-82Pi_O1asCg@mail.gmail.com>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
 <20170322183039.GA2899@dtor-ws> <CAMty3ZApz+GVkeoT4-75tiJcn6-CxkzdOrMcH7hjK1k2Ht=ZUQ@mail.gmail.com>
 <20170322184421.GB2899@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170322184421.GB2899@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jagan Teki <jagan-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matteo Lisi <matteo.lisi-4s7YQHO/iPVBDgjK7y7TUQ@public.gmane.org>, Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 23, 2017 at 12:14 AM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Mar 23, 2017 at 12:05:17AM +0530, Jagan Teki wrote:
>> On Thu, Mar 23, 2017 at 12:00 AM, Dmitry Torokhov
>> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Wed, Mar 22, 2017 at 04:36:46PM +0530, Jagan Teki wrote:
>> >> From: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
>> >>
>> >> Added missing of_match_table for max11801_ts driver with
>> >> compatible as "maxim,max11801_ts"
>> >>
>> >
>> > Why not "maxim,max11801"? Also, I think we'd need a binding document.
>>
>> Compatibility purpose to make this is for touchscreen and few of other
>
> Compatibility with what? The i2c id is "max11801" (without the "-ts").

Do we need to sync with i2c id as well? egalax_ts.c follow "_ts"
of-course the i2c there as follow the same.

>
>> *_ts.c files follow the same, and added binding documentation in 2/3
>> patch.
>
> Sorry, it seems I am only copied on 1/3 patch.

Sorry, will add in next version patches.

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
