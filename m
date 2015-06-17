From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] cap11xx: add LED support
Date: Wed, 17 Jun 2015 15:38:52 -0700
Message-ID: <20150617223852.GA11341@dtor-ws>
References: <1434422770-26896-1-git-send-email-mranostay@gmail.com>
 <1434422770-26896-3-git-send-email-mranostay@gmail.com>
 <557FD625.1080806@samsung.com>
 <CAKzfze9gneY_LmWaWGNKxLXBsw_k2d596CkGNat5RoTbn3cYEg@mail.gmail.com>
 <55809476.90407@zonque.org>
 <CAKzfze_TXP=qpyXJcktALW4V9b2SxH3qQSs=u3a8Xc=0diZ0Ng@mail.gmail.com>
 <CAKzfze8629xyiz1wufjoGbOu+npDRXyCgyGEhxY_1h7XHKeTQg@mail.gmail.com>
 <CAKzfze-M2aDY8p7FeazC7vBrigBGa-a6k43+=FZ9DEBOD0hHpw@mail.gmail.com>
 <558136FE.7060308@zonque.org>
 <CAKzfze-H=m55j-1ty4xOkrVzMswU7FpXe=6pHq4ws=P+3vcZNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKzfze-H=m55j-1ty4xOkrVzMswU7FpXe=6pHq4ws=P+3vcZNQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 17, 2015 at 02:53:26PM -0700, Matt Ranostay wrote:
> On Wed, Jun 17, 2015 at 1:59 AM, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:
> > On 06/17/2015 08:49 AM, Matt Ranostay wrote:
> >> Actually after further reading of the datasheet and testing with
> >> i2ctools it seems cap11xx_input_close() isn't putting the device in
> >> DEEP SLEEP mode.
> >>
> >> Any thoughts why?
> >
> > No, sorry. IIRC, the board I wrote the driver for didn't give me the
> > ability to measure power consumption.
> >
> 
> I can confirm it never goes to deep sleep or cap11xx_input_close()
> gets called. Does evdev kernel module increment/input_open_device even
> if nothing in userspace is accessing the /dev/event/inputX nodes?

No it does not. On the other hand there is VT that does keep all
keyboard-like devices open.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
