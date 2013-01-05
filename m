From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: asus_wmi: Unknown key pressed
Date: Sat, 5 Jan 2013 15:09:22 -0800
Message-ID: <20130105230922.GC6475@core.coreip.homeip.net>
References: <CAHR064jzPejiWM_XqeY0a+Uf7cYPUrYMNd0FDEUvwkgrMB1hDg@mail.gmail.com>
 <22009182.20.1357413346491.JavaMail.gkos@dynomob>
 <CAHR064hc+m1HXKVmbC5jrChQSarWLXWGZPFH-KTPwbyAnGD_7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54285 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab3AEXJ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Jan 2013 18:09:27 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so10022762pac.1
        for <linux-input@vger.kernel.org>; Sat, 05 Jan 2013 15:09:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHR064hc+m1HXKVmbC5jrChQSarWLXWGZPFH-KTPwbyAnGD_7w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>, Yong Wang <yong.y.wang@intel.com>, linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>

On Sat, Jan 05, 2013 at 08:06:32PM +0000, Corentin Chary wrote:
> On Sat, Jan 5, 2013 at 7:19 PM, Konstantin V. Gavrilenko
> <k.gavrilenko@arhont.com> wrote:
> > Thanks for a prompt response.
> >
> > for all three events the showkey generates the same data
> >
> > keycode 240 press
> > keycode 240 release
> >
> > ----- Original Message -----
> > From: "Corentin Chary" <corentincj@iksaif.net>
> > To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
> > Cc: "Yong Wang" <yong.y.wang@intel.com>, "Dmitry Torokhov" <dtor@mail.ru>
> > Sent: Saturday, 5 January, 2013 6:58:11 PM
> > Subject: Re: asus_wmi: Unknown key pressed
> >
> > Hi,
> >
> > On Sat, Jan 5, 2013 at 3:17 PM, Konstantin V. Gavrilenko
> > <k.gavrilenko@arhont.com> wrote:
> >> Hi Guys,
> >>
> >> sorry for writing out of the blue, but your email addresses where provided in the kernel modules. I hope you will direct me to a better place where I can report the problem or someone that can help solve the problem with asus_wmi module.
> >>
> >> In my new laptop UX51VZA v203 my syslog is constantly filled with the following lines, even though I do not press any buttons on the keyboard.
> >>
> >> Dec 30 08:28:52 dynomob kernel: [22731.108645] asus_wmi: Unknown key c6 pressed
> >> Dec 30 08:28:53 dynomob kernel: [22732.110834] asus_wmi: Unknown key c6 pressed
> >> Dec 30 08:28:58 dynomob kernel: [22737.079312] asus_wmi: Unknown key c6 pressed
> >> Dec 30 08:28:59 dynomob kernel: [22738.075352] asus_wmi: Unknown key c6 pressed
> >> Dec 30 08:29:00 dynomob kernel: [22739.076342] asus_wmi: Unknown key c6 pressed
> >> Dec 30 08:29:01 dynomob kernel: [22740.083493] asus_wmi: Unknown key c6 pressed
> >>
> >>
> >> It took me a while to work out that this was information from the ambient light sensor )) and since there is no way to operate it or disable it, I had to cover it with a piece of black paper. Such default behavior is very disruptive as it generates an actual unseen key press, that is extremely annoying if you trying to type a password.
> >
> > This should not generate any key if the key is unknown. But maybe
> > another key is generated (and not logged). Can you run showkey in a
> > terminal and try to see what keycode you are getting ?
> > I'll make a patch to ignore this key.
> >
> >> There are couple of other unknown signals tat I managed to figure out, namely
> >>
> >> Fn+A (ambient light button) generates
> >> Jan  5 15:12:08 dynomob kernel: [46786.001579] asus_wmi: Unknown key 7a pressed
> >
> > Will map this key to some keycode.
> >
> >> unplugging of the powercord generates
> >> Jan  5 15:13:08 dynomob kernel: [46845.606336] asus_wmi: Unknown key cf pressed
> >
> > Don't know what is means, so will probably just be ignored with a comment.
> >
> > Thanks,
> 
> Oh right, Seth added some code to send KEY_UNKNOWN keys in such cases.
> Seth, maybe keys present with KEY_IGNORE type should not send
> KEY_UNKNOWN to avoid this kind of issues ?

KEY_UNKNOWN should not really be mapped to any key so it should not
interfere with normal typing/other operations while still being able to
detect the events. The idea is for users to be able to notice the new
events and then developers can decide if they should be ignored or
mapped to some particular keycodes (or maybe routed through some other
subsystem).

-- 
Dmitry
