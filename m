From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: 2.6.30-rc1: touchpad disabled on hibernation
Date: Tue, 7 Jul 2009 00:40:14 +0200
Message-ID: <200907070040.14796.rjw@sisk.pl>
References: <4A438BA7.9010800@tuffmail.co.uk> <8db1092f0906251016l5ac85bfdpbac841b939cfac2a@mail.gmail.com> <4A43B1FC.7060609@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A43B1FC.7060609-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, Maciej Rutecki <maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thursday 25 June 2009, Alan Jenkins wrote:
> Maciej Rutecki wrote:
> > 2009/6/25 Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>:
> >   
> >> The synaptics touchpad on my EeePC 701 dies on hibernation.  2.6.30 was
> >> fine, and it doesn't happen on suspend to ram either.  There are no
> >> obvious error messages, but maybe this boot message is relevant:
> >>
> >> Platform driver 'i8042' needs updating, please use dev_pm_ops
> >>
> >>     
> >
> > Similar on s2disk, HP/Compaq notebook. Try reload psmouse module. I
> > reported it, but nobody answer.
> >   
> That works, thanks.

Alan, Maciej, can you both try the patch at
http://patchwork.kernel.org/patch/34075/, please?

Rafael
