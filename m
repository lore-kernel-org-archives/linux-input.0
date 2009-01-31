From: Dmitry Torokhov <dtor@mail.ru>
Subject: Re: [PATCH 2.6.28] mousedev: Allow devices to be excluded from
	/dev/input/mice
Date: Fri, 30 Jan 2009 20:29:59 -0800
Message-ID: <20090131042959.GA3529@dtor-d630.eng.vmware.com>
References: <20090130120456.GA20461@arbonne.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754896AbZAaEbD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090130120456.GA20461@arbonne.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Atterer <atterer@debian.org>
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz, linux-input@vger.kernel.org, rubini@ipvvis.unipv.it, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

Hi Richard,

On Friday 30 January 2009 04:04:56 Richard Atterer wrote:
> From: Richard Atterer <atterer@debian.org>
>
> Allow devices to be excluded from /dev/input/mice
>
> This patch adds an "ignoreid=0x1234:0x5678" parameter to the mousedev
> module. If a mouse matches the given device ID(s), its movement and button
> presses will not be relayed via /dev/input/mice.
>

Thank you for the patch, however I don't think that it is the right solution.

> Why is this needed? In my case, I'm using some mice as sensors (robotic
> application, more or less), so their movement should not influence the
> mouse pointer at all.

I think this is the case where EVIOCGRAB use is warranted then.

> I could simply specify only my main mouse in
> xorg.conf rather than /dev/input/mice. However, /dev/input/mice is the only
> way to allow hot-plugging of mice with X.
>

The newer X does support input hotplug pretty well actually.

> This feature could also be used to disable non-working/buggy touchpads in
> laptops.
>

You can already do that by unbinding serio and usb devices from their 
respective drivers, no need to modify mousedev.

-- 
Dmitry
