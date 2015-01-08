From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Elantech touchpad detection fix for laptops
Date: Wed, 7 Jan 2015 17:23:06 -0800
Message-ID: <20150108012306.GC8570@dtor-ws>
References: <CAEK4c-_Kirwxj_Rgqn1c7x4h0Mj0r8vhSYb5qQcJvo5TbXdb0Q@mail.gmail.com>
 <CAEK4c-8CsrBaf8gaH2B2kuoMTHrLpLMgGQPrXTZAX3W5At0uoA@mail.gmail.com>
 <20150107074433.GC5256@dtor-ws>
 <CAEK4c-_xcj2JrNEcnARSwWwNQxow+JO1F1hf_d1befApXKNegw@mail.gmail.com>
 <CAEK4c-_GTLu0jRLaX-na2-mou6qGX4A8p2rS7Q_QnM+DNKZWdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44011 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbbAHBXM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 20:23:12 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so7085169ier.6
        for <linux-input@vger.kernel.org>; Wed, 07 Jan 2015 17:23:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEK4c-_GTLu0jRLaX-na2-mou6qGX4A8p2rS7Q_QnM+DNKZWdg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srihari Vijayaraghavan <linux.bug.reporting@gmail.com>
Cc: linux-input@vger.kernel.org, Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, Zakariya Dehlawi <zdehlawi@gmail.com>, Guillaume Bouchard <guillaum.bouchard@gmail.com>

On Wed, Jan 07, 2015 at 08:11:36PM +1100, Srihari Vijayaraghavan wrote:
> On 7 January 2015 at 19:23, Srihari Vijayaraghavan
> <linux.bug.reporting@gmail.com> wrote:
> > On 7 January 2015 at 18:44, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >> Hi Srihari,
> >
> > Hello Dimitry,
> >
> > Thanks for your feedback. Much appreciated.
> >
> >> On Mon, Jan 05, 2015 at 07:45:39PM +1100, Srihari Vijayaraghavan wrote:
> >>> Hello Folks & Dmitry,
> >>>
> >>> Further to the previous patch, here is the current version (against
> >>> mainline) updated with the DMI info of another laptop model where this
> >>> fix had helped a user.
> >>>
> >>> Can you please review it & give some feedback? If it looks good as it
> >>> is, then on behalf of all affected users (including yours truly), may
> >>> I request for it to be merged upstream (and possibly stable too)?
> >>>
> >>> (If the patch gets spoiled by gmail, please ref to this bugzilla URL,
> >>> where this patch is there as a file attachment:
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=81331)
> >>
> >> I am not terribly happy with having fiddling with keyboard from i8042
> >> core, but I guess that's what we have to do unless someone has better
> >> idea...
> >
> > Agreed 100%. Regrettably, seeing how psmouse_do_detect() doesn't even
> > get invoked, this heavy handed approach had to be taken at i8042 core.
> > However, as you've pointed out, if there is any better idea, we're all
> > ears.
> >
> >> I'll drop mention of Elantech from the option though as it may well be
> >> needed for other devices in the future.
> >
> > A version of the patch (against mainline) incorporating your ideas
> > (i.e., without too much Elantech bashing) is attached to this email
> > for your review.
> >
> >> Thanks!
> 
> [Sorry to respond to my own email.]
> 
> Here's a better version, removing Elantech ref from the table name.

Applied after massaging messages some more. Thank you.

-- 
Dmitry
