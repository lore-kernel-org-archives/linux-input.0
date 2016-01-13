From: Clement Calmels <clement.calmels@free.fr>
Subject: Re: [PATCH] Input: xpad - use LED API when identifying wireless
 controllers
Date: Wed, 13 Jan 2016 21:34:15 +0100
Message-ID: <20160113213415.24667399@gromit>
References: <20151216224408.GA14261@dtor-ws>
 <20151219221709.5b5947ec@gromit>
 <20151220075504.GA35575@dtor-ws>
 <CA+b0ujeD_qV-MtPx7ktxMWw-UgxZq8d9BN6SgwA3F+RKaXz6ng@mail.gmail.com>
 <20151221200650.GB40090@dtor-ws>
 <CA+b0ujepYgvgC6tTeWBphQLEr+KXXzA48uGzxUvfO8yyXey6UA@mail.gmail.com>
 <20160105005017.GA11801@dtor-ws>
 <20160112180451.GA32064@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:60768 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757839AbcAMUeW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 15:34:22 -0500
In-Reply-To: <20160112180451.GA32064@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Rojtberg <rojtberg@gmail.com>, linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, linux-kernel@vger.kernel.org

On Tue, 12 Jan 2016 10:04:51 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Jan 04, 2016 at 04:50:17PM -0800, Dmitry Torokhov wrote:
> > On Thu, Dec 24, 2015 at 07:11:22PM +0100, Pavel Rojtberg wrote:  
> > > 
> > > for me this one did the trick. The correct LED lights up after
> > > resume.
> > > 
> > > Integrated it here (master):
> > > https://github.com/paroj/xpad  
> > 
> > Pavel, I refreshed my xpad branch on kernel.org folding the
> > reset_resume and anchor changes into your original suspend/resume
> > patch. Could you please try it out so that I can send it to
> > mainline in the upcoming merge window?  
> 
> Gentle ping. I can still fit it in my 2nd pull request but time is
> running out...
> 
> Thanks.
> 

Hi Dimitry,

Source code from
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git, branch
xpad, head d9be398afb2c3333716324352d062c50112e4e86.

After suspend (systemctl suspend) my xpad wireless controller is still
blinking. Tried "echo 2 > /sys/class/leds/xpad0/brightness" but it did
not work.
That said, I also tried the same xpad code but built for my current
kernel (4.3.0 from debian/sid): led is still blinking after resume but
this time the sysfs file is functional.

Hopefully I did not make a mistake in the build process...

Best regards,
Clement
