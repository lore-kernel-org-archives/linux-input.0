From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: spi: Driver for SPI data stream driven vibrator
Date: Wed, 27 Oct 2010 01:58:44 -0700
Message-ID: <20101027085844.GA7039@core.coreip.homeip.net>
References: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
 <20101026111344.GB24714@angua.secretlab.ca>
 <F80267346F10C541946CBE8909F1C39E35932598BB@NOK-EUMSG-02.mgdnok.nokia.com>
 <20101027084730.GC6797@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101027084730.GC6797@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: ilkka.koskinen@nokia.com, linux-input@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 27, 2010 at 09:47:30AM +0100, Grant Likely wrote:
> On Tue, Oct 26, 2010 at 06:50:33PM +0200, ilkka.koskinen@nokia.com wrote:
> > Hi Grant and thanks for comments,
> [...]
> > >> +static int vibra_spi_playback(struct input_dev *input, int effect_id,
> > >int value)
> > >> +{
> > >> +    struct vibra_data *vibra = input_get_drvdata(input);
> > >> +    struct effect_info *einfo = &vibra->effects[effect_id];
> > >> +    struct ff_effect *ff_effect = &input->ff->effects[effect_id];
> > >> +
> > >> +    if (!vibra->workqueue)
> > >> +            return -ENODEV;
> > >> +
> > >> +    if (test_bit(FF_EFFECT_UPLOADING, &einfo->flags))
> > >> +            return -EBUSY;
> > >> +
> > >> +    if (value == 0) {
> > >> +            /* Abort the given effect */
> > >> +            if (test_bit(FF_EFFECT_PLAYING, &einfo->flags))
> > >> +                    __set_bit(FF_EFFECT_ABORTING, &einfo->flags);
> > >> +
> > >> +            __clear_bit(FF_EFFECT_QUEUED, &einfo->flags);
> > >> +    } else {
> > >> +            /* Move the given effect as the next one */
> > >> +            __clear_bit(FF_EFFECT_QUEUED,
> > >> +                    &vibra->effects[vibra->next_effect].flags);
> > >> +
> > >> +            vibra->next_effect = effect_id;
> > >> +            __set_bit(FF_EFFECT_QUEUED, &einfo->flags);
> > >> +            __clear_bit(FF_EFFECT_ABORTING, &einfo->flags);
> > >> +            einfo->stop_at = jiffies +
> > >> +                    msecs_to_jiffies(ff_effect->replay.length);
> > >> +
> > >> +            if (vibra->status == IDLE) {
> > >> +                    vibra->status = STARTED;
> > >> +                    queue_work(vibra->workqueue, &vibra->play_work);
> > >> +            }
> > >> +    }
> > >
> > >I can't speak anything about the input event handling because I'm not
> > >very familiar with it.  However, it looks like the shared effect data
> > >(vibra->effects) is getting modified outside of a critical region.  Is
> > >this safe?
> 
> Hmmm, I don't know why the force feedback layer is using a spin lock,
> but it looks like overkill.  Since you're already deferring work, I
> would look at queueing the request and pushing down the spin lock
> exposure as much as possible, but I'm really not the expert on the
> input layer.
> 

Events are often sent from IRQ context so input core has to use spinlocks to
protect its internal data structures. Since output events travel the
same data path the event handlers are also called in atomic context.

-- 
Dmitry
