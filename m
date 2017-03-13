From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/1] HID: clamp input to logical range if no null state
Date: Mon, 13 Mar 2017 10:47:20 +0100
Message-ID: <20170313094720.GC4378@mail.corp.redhat.com>
References: <20170308215211.24263-1-tk@the-tk.com>
 <20170309081606.GA28052@mail.corp.redhat.com>
 <20170312143247.GA938@gaia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170312143247.GA938@gaia.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mar 12 2017 or thereabouts, Tomasz Kramkowski wrote:
> On Thu, Mar 09, 2017 at 09:16:06AM +0100, Benjamin Tissoires wrote:
> > We have a "clamp()" function in the kernel that does the job directly
> > and which is more readable. Also, this makes testing the out of range
> > values twice.
> > 
> > How about:
> > 
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index cf8256a..781f400 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1150,19 +1150,26 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
> >  
> >  	/*
> >  	 * Ignore out-of-range values as per HID specification,
> > -	 * section 5.10 and 6.2.25.
> > +	 * section 5.10 and 6.2.25, when NULL state bit is present.
> > +	 * When it's not, clamp the value to match Microsoft's input
> > +	 * driver as mentioned in "Required HID usages for digitizers":
> > +	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
> >  	 *
> >  	 * The logical_minimum < logical_maximum check is done so that we
> >  	 * don't unintentionally discard values sent by devices which
> >  	 * don't specify logical min and max.
> >  	 */
> >  	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
> > -	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
> > -	    (field->logical_minimum < field->logical_maximum) &&
> > -	    (value < field->logical_minimum ||
> > -	     value > field->logical_maximum)) {
> > -		dbg_hid("Ignoring out-of-range value %x\n", value);
> > -		return;
> > +	    (field->logical_minimum < field->logical_maximum)) {
> >  	}
> 
> Yes, I don't mind the expansion of the comment and the usage of clamp (I
> didn't know this existed, but I will use it in the future). However if
> there is anything I would change, it would be this:
> 
> ---
>  drivers/hid/hid-input.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index cf8256aac2bd..a1ebdd7d4d4d 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1150,19 +1150,26 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  
>  	/*
>  	 * Ignore out-of-range values as per HID specification,
> -	 * section 5.10 and 6.2.25.
> +	 * section 5.10 and 6.2.25, when NULL state bit is present.
> +	 * When it's not, clamp the value to match Microsoft's input
> +	 * driver as mentioned in "Required HID usages for digitizers":
> +	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
>  	 *
>  	 * The logical_minimum < logical_maximum check is done so that we
>  	 * don't unintentionally discard values sent by devices which
>  	 * don't specify logical min and max.
>  	 */
>  	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
> -	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
> -	    (field->logical_minimum < field->logical_maximum) &&
> -	    (value < field->logical_minimum ||
> -	     value > field->logical_maximum)) {
> -		dbg_hid("Ignoring out-of-range value %x\n", value);
> -		return;
> +	    (field->logical_minimum < field->logical_maximum)) {
> +		if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
> +		    (value < field->logical_minimum ||
> +		     value > field->logical_maximum)) {
> +			dbg_hid("Ignoring out-of-range value %x\n", value);
> +			return;
> +		}
> +		value = clamp(value,
> +			      field->logical_minimum,
> +			      field->logical_maximum);
>  	}
>  
>  	/*
> -- 
> 2.12.0
> 
> For me it is a bit clearer on what is happening and still avoids doing
> the range check twice. But ultimately it is all up to you guys.

Works for me.

> 
> I can get both versions of this patch tested at some point in the next
> few days and re-submit whichever one you prefer as a v2.
> 
> I'm not sure what the procedures are on this, should I put a
> "Suggested-by:" for your suggested change to my patch, or is that not
> applicable here?

No need to add suggested-by. This tag, IMO, is there to give credit on
an idea, while here it was more a common effort :)

Just add my Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
if you resubmit it - after the tests :)

Cheers,
Benjamin


> 
> As always, thanks for your time.
> 
> -- 
> Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
