From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when
 slot is closed
Date: Wed, 25 Jul 2018 16:21:10 -0700
Message-ID: <20180725232110.GA80336@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-9-nick@shmanahar.org>
 <20180723223347.GJ100814@dtor-ws>
 <CAO-hwJ+BoWdXbH1sbde2+qb_sgFBMarM0156a1VrRSQdhNf3xQ@mail.gmail.com>
 <20180725052641.GA7072@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725052641.GA7072@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nick Dyer <nick@shmanahar.org>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, cphealy@gmail.com, nikita.yoush@cogentembedded.com, l.stach@pengutronix.de, nick.dyer@itdev.co.uk
List-Id: linux-input@vger.kernel.org

On Wed, Jul 25, 2018 at 03:26:41PM +1000, Peter Hutterer wrote:
> On Tue, Jul 24, 2018 at 10:23:27AM +0200, Benjamin Tissoires wrote:
> > On Tue, Jul 24, 2018 at 12:34 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Jul 20, 2018 at 10:51:21PM +0100, Nick Dyer wrote:
> > > > From: Nick Dyer <nick.dyer@itdev.co.uk>
> > > >
> > > > input_mt_report_slot_state() ignores the tool when the slot is closed.
> > > > Remove the tool type from these function calls, which has caused a bit of
> > > > confusion.
> > >
> > > Hmm, maybe we could introduce MT_TOOL_NONE or MT_TOOL_INACTIVE and get
> > > rid of the 3rd parameter? It will require a bit of macro trickery for a
> > > release or 2...
> > 
> > I am not sure what would be the benefit of adding those new tools, if
> > the input_mt code discards them. Do you want to forward them to the
> > userspace with the release?
> > This reminds me the discussion we had recently with the touchscreens
> > releasing the slots with a MT_TOOL_PALM.
> > 
> > Anyway, better include Peter as he will be using this new MT_TOOL.
> 
> thanks for the CC, would've missed this.
> 
> From what I read this would be a helper for internal changes only, not
> exposed to userspace? If so maybe it's better/easier/more readable to break
> it into two functions
>   input_mt_open_slot(dev, MT_TOOL_FINGER)
>   input_mt_close_slot(dev)
>   
> This removes any ambiguity about the handling of the tool and should be a
> fairly trivial search/replace. Replace the 'open/close' terminology with
> whatever suits better.

Hmm, I do like the "input_mt_close_slot()", or
"input_mt_report_slot_inactive()". I think the
input_mt_report_slot_state() is fine for "opening" the slot, as, with it
now returning bool, we can do:

	if (input_mt_report_slot_state(dev, MT_TOOL_FINGER, state)) {
		...
		< report events for active slot >
	}


Thanks.

-- 
Dmitry
