From: Marvin Raaijmakers <marvin.nospam@gmail.com>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq	key
Date: Fri, 17 Aug 2007 10:25:12 +0200
Message-ID: <1187339112.3684.10.camel@localhost.localdomain>
References: <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
 <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>
 <469C647B.1000307@inwind.it>
 <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>
 <469E7E29.2050206@inwind.it>
 <d120d5000707191400w2725bbd1h64add33e3e227bdd@mail.gmail.com>
 <469FDA19.6020702@inwind.it>
 <d120d5000707191532x34ec7baen8e0de1155a4882cb@mail.gmail.com>
 <469FF3D9.4080307@inwind.it> <Pine.LNX.4.64.0707301556390.5747@twin.jikos.cz>
 <20070802212730.GA10153@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-reply-to: <20070802212730.GA10153@suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jiri Kosina <jikos@jikos.cz>, federico ferri <xaero@inwind.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, mzxrlshmm@0pointer.de
List-Id: linux-input@vger.kernel.org

What's the current state of this patch?

- Marvin Raaijmakers

On Thu, 2007-08-02 at 23:27 +0200, Vojtech Pavlik wrote:
> On Mon, Jul 30, 2007 at 04:09:04PM +0200, Jiri Kosina wrote:
> > **
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 7f81789..c604a1d 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -818,6 +818,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
> >  			field->dpad = usage->code;
> >  	}
> >  
> > +	if (usage->type == EV_KEY) {
> > +		set_bit(EV_MSC, input->evbit);
> > +		set_bit(usage->code, input->mscbit);
> 
> Should be set_bit(MSC_SCAN, input->mscbit);
> 
> > +	}
> > +
> >  	hid_resolv_event(usage->type, usage->code);
> >  #ifdef CONFIG_HID_DEBUG
> >  	printk("\n");
> > @@ -908,6 +913,9 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
> >  	if ((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
> >  		return;
> >  
> > +	if (usage->type == EV_KEY)
> > +		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
> > +
> >  	input_event(input, usage->type, usage->code, value);
> >  
> >  	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type == EV_KEY))
> 
> If you look back through the history of hid-input.c, you'll see that
> very much this usage reporting was already in there and was removed
> later because of excessive number of events generated.
> 
> It was partly because I didn't limit the usage reporting to keys, for
> the sake of genericity.
> 
> > There is an slight issue with this patch though. Imagine you have such a 
> > keyboard that sends in one field the status of Caps/Num/Shift/etc and in 
> > another field the pressed key(s) itself, i.e. something like this:
> > 
> >   INPUT[INPUT]
> >     Field(0)
> >       Usage(8)
> >         Keyboard.00e0
> >         Keyboard.00e1
> >         Keyboard.00e2
> >         Keyboard.00e3
> >         Keyboard.00e4
> >         Keyboard.00e5
> >         Keyboard.00e6
> >         Keyboard.00e7
> >       Logical Minimum(0)
> >       Logical Maximum(1)
> >       Report Size(1)
> >       Report Count(8)
> >       Report Offset(0)
> >       Flags( Variable Absolute )
> > ... 
> > 
> > and then the next field is used to transfer the actual keys. Therefore, 
> > with this patch, hid-input sees a report containing usages e0-e7 set to 
> > zero (when no caps/num/shift/... was pressed). This results in evtest 
> > seeing this (with the patch below applied) for a single keypress:
> > 
> > Event: time 1182930853.026146, type 4 (Misc), code 4 (ScanCode), value 700e0
> > Event: time 1182930853.026159, type 4 (Misc), code 4 (ScanCode), value 700e1
> > Event: time 1182930853.026168, type 4 (Misc), code 4 (ScanCode), value 700e2
> > Event: time 1182930853.026178, type 4 (Misc), code 4 (ScanCode), value 700e3
> > Event: time 1182930853.026187, type 4 (Misc), code 4 (ScanCode), value 700e4
> > Event: time 1182930853.026197, type 4 (Misc), code 4 (ScanCode), value 700e5
> > Event: time 1182930853.026206, type 4 (Misc), code 4 (ScanCode), value 700e6
> > Event: time 1182930853.026216, type 4 (Misc), code 4 (ScanCode), value 700e7
> > Event: time 1182930853.026227, type 4 (Misc), code 4 (ScanCode), value 70004
> > Event: time 1182930853.026233, type 1 (Key), code 30 (A), value 1
> > Event: time 1182930853.026237, -------------- Report Sync ------------
> > Event: time 1182930853.114137, type 4 (Misc), code 4 (ScanCode), value 700e0
> > Event: time 1182930853.114150, type 4 (Misc), code 4 (ScanCode), value 700e1
> > Event: time 1182930853.114160, type 4 (Misc), code 4 (ScanCode), value 700e2
> > Event: time 1182930853.114169, type 4 (Misc), code 4 (ScanCode), value 700e3
> > Event: time 1182930853.114179, type 4 (Misc), code 4 (ScanCode), value 700e4
> > Event: time 1182930853.114188, type 4 (Misc), code 4 (ScanCode), value 700e5
> > Event: time 1182930853.114198, type 4 (Misc), code 4 (ScanCode), value 700e6
> > Event: time 1182930853.114207, type 4 (Misc), code 4 (ScanCode), value 700e7
> > Event: time 1182930853.114218, type 4 (Misc), code 4 (ScanCode), value 70004
> > Event: time 1182930853.114223, type 1 (Key), code 30 (A), value 0
> > Event: time 1182930853.114227, -------------- Report Sync ------------
> > 
> > I don't think this is what you want. We could alternatively for example 
> > remember all the previous states of all the KEY controls and report 
> > scancodes only of those which got changed, this would solve this issue.
> > **
> > 
> > However, this might look like an overhead.
> 
> Well, the input subsystem knows whether a key state report will be
> forwarded or not. Maybe we could (ab)use the knowledge.
