From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
Date: Sun, 21 Jun 2015 14:12:17 +0100
Message-ID: <5586B831.3030702@kernel.org>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>    <1434034458-1968-1-git-send-email-simon@mungewell.org>    <557D9564.9090800@kernel.org>    <d6702f5d19d2baea80132666fcf7654a.squirrel@mungewell.org>    <557DC084.6090205@kernel.org> <a740eca098128c7a830db825d7c0288c.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a740eca098128c7a830db825d7c0288c.squirrel-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 18/06/15 07:15, simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org wrote:
> 
>>> I have further advanced the patch to include reading via buffer, but I'm
>>> having trigger 'conceptual' problems getting my head around the HID
>>> device
>>> issuing an interrupt when a input report is received. Looking at
>>> iio_dummy_event and iios_sysfs for inspiration....
>> You can skip the triggers.  It's not obligatory, you can push directly
>> into a buffer.
>> Triggers are nice for 'data ready' type signals (which is closest to what
>> we
>> have here) if you might want to hang other sensors off the timing (so read
>> on demand ADCs etc.  They aren't actually 'required' as such.
> 
> After a bit of poking around I got the triggers working as well, I can
> self trigger and even trigger another (iio-dummy) device.
> 
> However I couldn't trigger two devices at the same time from a single
> trigger, is this normal for IIO?
You should be able to.   Defaults limit it to 2 per trigger, 
in Kconfig it is "Maximum number of consumers per trigger".
Any chance that has the value 1 for your build?

Otherwise, if you can do a bit of debugging to find out where things
get stuck, that would be great.  Can you bring up the buffers with the
trigger attached or is it failing before that?

After that it would just be a case of chasing in your trigger driver to
see if it gets reenabled correctly after the first trigger.

> 
> 
> Next is a little code clean-up and I'll post what I have for some more
> comments,
Cool.
