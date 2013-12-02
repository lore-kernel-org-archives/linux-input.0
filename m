From: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Add logical min and max
Date: Mon, 02 Dec 2013 21:07:59 +0000
Message-ID: <529CF6AF.6010407@jic23.retrosnub.co.uk>
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5299CCAA.6090100@kernel.org> <alpine.LNX.2.00.1312021408290.24931@pobox.suse.cz> <b2e31404-966e-4f1a-a85b-a01fa63064b9@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b2e31404-966e-4f1a-a85b-a01fa63064b9-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 12/02/13 17:14, Jonathan Cameron wrote:
> Hi Jiri
>
> I tend to push a testing branch to catch any build issues before pushing to the real togreg branch. Normally there are only a few hours on between but sometimes it is a few days as here.  I will move these to the fixes-togreg branch - hopefully this evening...

Now applied to the fixes-togreg branch (this one does get pushed out to kernel.org
directly!)
>
> Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
>> On Sat, 30 Nov 2013, Jonathan Cameron wrote:
>>
>>> On 11/27/13 22:19, Srinivas Pandruvada wrote:
>>>> Exporting logical minimum and maximum of HID fields as part of the
>>>> hid sensor attribute info. This can be used for range checking and
>>>> to calculate enumeration base for NAry fields of HID sensor hub.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada
>> <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Hi,  I would have preffred this being done in two patches, the first
>>> refactoring the function call and the second doing the min and max.
>>>
>>> Anyhow, I'll take it anyway.
>>>
>>> Applied to the togreg branch of iio.git.
>> Where is that? I don't seem to see it in 
>>
>> 	https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=togreg
