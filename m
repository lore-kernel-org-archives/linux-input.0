From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [WIP PATCH 2/4] ACPI: button: remove the LID input node when the
 state is unknown
Date: Tue, 6 Jun 2017 12:22:09 +0200
Message-ID: <20170606102209.GA14880@mail.corp.redhat.com>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
 <20170601184632.2980-3-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEC50F1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEC50F1@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Lv,

On Jun 05 2017 or thereabouts, Zheng, Lv wrote:
> Hi, Benjamin
> 
> > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > Subject: [WIP PATCH 2/4] ACPI: button: remove the LID input node when the state is unknown
> > 
> > Because of the variation of firmware implementation, there is a chance
> > the LID state is unknown:
> > 1. Some platforms send "open" ACPI notification to the OS and the event
> >    arrive before the button driver is resumed;
> > 2. Some platforms send "open" ACPI notification to the OS, but the event
> >    arrives after the button driver is resumed, ex., Samsung N210+;
> > 3. Some platforms never send an "open" ACPI notification to the OS, but
> >    update the cached _LID return value to "open", and this update arrives
> >    before the button driver is resumed;
> > 4. Some platforms never send an "open" ACPI notification to the OS, but
> >    update the cached _LID return value to "open", but this update arrives
> >    after the button driver is resumed, ex., Surface Pro 3;
> > 5. Some platforms never send an "open" ACPI notification to the OS, and
> >    _LID ACPI method returns a value which stays to "close", ex.,
> >    Surface Pro 1.
> > 
> > We can mark the unreliable platform (cases 2, 4, 5 above) as such and make
> > sure we do not export an input node with an unknown state to prevent
> > suspend loops.
> > 
> > The database of unreliable devices is left to userspace to handle with
> > a hwdb file and a udev rule.
> > 
> > Note that this patch removes the filtering of duplicate events when
> > calling blocking_notifier_call_chain(), but this will be addressed in
> > a following patch.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/acpi/button.c | 207 ++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 131 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 48bcdca..9ad7604 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/types.h>
> > +#include <linux/moduleparam.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/input.h>
> > @@ -79,6 +80,8 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
> >  static int acpi_button_add(struct acpi_device *device);
> >  static int acpi_button_remove(struct acpi_device *device);
> >  static void acpi_button_notify(struct acpi_device *device, u32 event);
> > +static int acpi_button_add_input(struct acpi_device *device);
> > +static int acpi_lid_update_reliable(struct acpi_device *device);
> > 
> >  #ifdef CONFIG_PM_SLEEP
> >  static int acpi_button_suspend(struct device *dev);
> > @@ -111,6 +114,8 @@ struct acpi_button {
> >  	bool suspended;
> >  };
> > 
> > +static DEFINE_MUTEX(button_input_lock);
> > +
> >  static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
> >  static struct acpi_device *lid_device;
> >  static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> > @@ -119,6 +124,44 @@ static unsigned long lid_report_interval __read_mostly = 500;
> >  module_param(lid_report_interval, ulong, 0644);
> >  MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
> > 
> > +static bool lid_reliable = true;
> > +
> > +static int param_set_lid_reliable(const char *val,
> > +				  const struct kernel_param *kp)
> > +{
> > +	bool prev_lid_reliable = lid_reliable;
> > +	int ret;
> > +
> > +	mutex_lock(&button_input_lock);
> > +
> > +	ret = param_set_bool(val, kp);
> > +	if (ret) {
> > +		mutex_unlock(&button_input_lock);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * prevent a loop when we show up the device to userspace because
> > +	 * of an acpi notification, and userspace immediately removes it
> > +	 * by marking it as unreliable when this was already known.
> > +	 */
> > +	if (lid_device && prev_lid_reliable != lid_reliable) {
> > +		ret = acpi_lid_update_reliable(lid_device);
> > +		if (ret)
> > +			lid_reliable = prev_lid_reliable;
> > +	}
> > +
> > +	mutex_unlock(&button_input_lock);
> > +	return ret;
> > +}
> > +
> > +static const struct kernel_param_ops lid_reliable_ops = {
> > +	.get = param_get_bool,
> > +	.set = param_set_lid_reliable,
> > +};
> > +module_param_cb(lid_reliable, &lid_reliable_ops, &lid_reliable, 0644);
> > +MODULE_PARM_DESC(lid_reliable, "Is the LID switch reliable (true|false)?");
> > +
> >  /* --------------------------------------------------------------------------
> >                                FS Interface (/proc)
> >     -------------------------------------------------------------------------- */
> > @@ -142,79 +185,22 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
> >  {
> >  	struct acpi_button *button = acpi_driver_data(device);
> >  	int ret;
> > -	ktime_t next_report;
> > -	bool do_update;
> > +
> > +	/* button_input_lock must be held */
> > +
> > +	if (!button->input)
> > +		return 0;
> > 
> >  	/*
> > -	 * In lid_init_state=ignore mode, if user opens/closes lid
> > -	 * frequently with "open" missing, and "last_time" is also updated
> > -	 * frequently, "close" cannot be delivered to the userspace.
> > -	 * So "last_time" is only updated after a timeout or an actual
> > -	 * switch.
> > +	 * If the lid is unreliable, always send an "open" event before any
> > +	 * other. The input layer will filter out the extra open if required,
> > +	 * and it will force the close event to be sent.
> >  	 */
> > -	if (lid_init_state != ACPI_BUTTON_LID_INIT_IGNORE ||
> > -	    button->last_state != !!state)
> > -		do_update = true;
> > -	else
> > -		do_update = false;
> > -
> > -	next_report = ktime_add(button->last_time,
> > -				ms_to_ktime(lid_report_interval));
> > -	if (button->last_state == !!state &&
> > -	    ktime_after(ktime_get(), next_report)) {
> > -		/* Complain the buggy firmware */
> > -		pr_warn_once("The lid device is not compliant to SW_LID.\n");
> > +	if (!lid_reliable)
> > +		input_report_switch(button->input, SW_LID, 0);
> > 
> > -		/*
> > -		 * Send the unreliable complement switch event:
> > -		 *
> > -		 * On most platforms, the lid device is reliable. However
> > -		 * there are exceptions:
> > -		 * 1. Platforms returning initial lid state as "close" by
> > -		 *    default after booting/resuming:
> > -		 *     https://bugzilla.kernel.org/show_bug.cgi?id=89211
> > -		 *     https://bugzilla.kernel.org/show_bug.cgi?id=106151
> > -		 * 2. Platforms never reporting "open" events:
> > -		 *     https://bugzilla.kernel.org/show_bug.cgi?id=106941
> > -		 * On these buggy platforms, the usage model of the ACPI
> > -		 * lid device actually is:
> > -		 * 1. The initial returning value of _LID may not be
> > -		 *    reliable.
> > -		 * 2. The open event may not be reliable.
> > -		 * 3. The close event is reliable.
> > -		 *
> > -		 * But SW_LID is typed as input switch event, the input
> > -		 * layer checks if the event is redundant. Hence if the
> > -		 * state is not switched, the userspace cannot see this
> > -		 * platform triggered reliable event. By inserting a
> > -		 * complement switch event, it then is guaranteed that the
> > -		 * platform triggered reliable one can always be seen by
> > -		 * the userspace.
> > -		 */
> > -		if (lid_init_state == ACPI_BUTTON_LID_INIT_IGNORE) {
> > -			do_update = true;
> > -			/*
> > -			 * Do generate complement switch event for "close"
> > -			 * as "close" is reliable and wrong "open" won't
> > -			 * trigger unexpected behaviors.
> > -			 * Do not generate complement switch event for
> > -			 * "open" as "open" is not reliable and wrong
> > -			 * "close" will trigger unexpected behaviors.
> > -			 */
> > -			if (!state) {
> > -				input_report_switch(button->input,
> > -						    SW_LID, state);
> > -				input_sync(button->input);
> > -			}
> > -		}
> > -	}
> 
> My dell latitude 6430u test platform sends multiple Notify(lid) before suspend and after resume.

Does this platform requires the not lid_reliable check as per this
series? Because if it doesn't, then we should not care.

> This is because the aml table puts many Notify(LID, 0x80) in various control methods.
> And not one of them but multiple of them will be invoked by various OS drivers during suspend/resume period.
> I think this is not an isolated platform that will invoke multiple redundant "Notify(lid)".
> 
> Fortunately, the lid state for the multiple notify(lid) should be same as the first "Notify(lid)".
> I suppose this is why SW_LID is invented, as it can really filter such redundant events.
> And user space finally can only see 1 "close" event.
> 
> But unconditionally prepending "open" before all "close" events surely can break the logic by
> delivering multiple "close" events to the user space.

That doesn't matter. What matters is the state of the switch, not the
event. So if user space receives (in case we marked the switch as not
reliable) several close events, all user space will do is realize that
the state is still closed and will act accordingly.

> 
> Another issue is, for case 5, when we use button.lid_init_state=method.
> Unconditionally prepending "open" before driver initiated "close" event
> sent due to acpi_lid_initialize_state(), we will see suspend/resume cycles.

Case 5 is broken anyway and needs to be handled specially. It was not
targeted in this WIP series.

> 
> Thus if we consider both cases, we should:
> 1. put a frequency check to filter possible redundant events.

This doesn't work and should be avoided. The state of the input switch
is known to the input layer only, and given there are spinlocks, you can
not know if the state is actually the one you expected beforehand.

You can however add frequency checks in the input handler, but that
would assume the input layer is not doing its job properly and so should
be avoided.

> 2. distinguish AML "Notify" call and button driver initiated lid notification.

Again, we don't care if the "event" comes from ACPI, the driver itself or
user space (libinput). All that matters is the current state of the
input node switch, that needs to match the physical world at any time.

> And we may reach a same result like the following:
> https://patchwork.kernel.org/patch/9756467/
> 
> 
> > -	/* Send the platform triggered reliable event */
> > -	if (do_update) {
> > -		input_report_switch(button->input, SW_LID, !state);
> > -		input_sync(button->input);
> > -		button->last_state = !!state;
> > -		button->last_time = ktime_get();
> > -	}
> > +	input_report_switch(button->input, SW_LID, !state);
> > +	input_sync(button->input);
> > 
> >  	if (state)
> >  		pm_wakeup_hard_event(&device->dev);
> > @@ -371,6 +357,21 @@ static int acpi_lid_update_state(struct acpi_device *device)
> >  	return acpi_lid_notify_state(device, state);
> >  }
> > 
> > +static int acpi_lid_notify(struct acpi_device *device)
> > +{
> > +	struct acpi_button *button = acpi_driver_data(device);
> > +	int ret;
> > +
> > +	mutex_lock(&button_input_lock);
> > +	if (!button->input)
> > +		acpi_button_add_input(device);
> > +	ret = acpi_lid_update_state(device);
> > +	mutex_unlock(&button_input_lock);
> > +
> > +
> > +	return ret;
> > +}
> > +
> >  static void acpi_lid_initialize_state(struct acpi_device *device)
> >  {
> >  	switch (lid_init_state) {
> > @@ -398,7 +399,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
> >  	case ACPI_BUTTON_NOTIFY_STATUS:
> >  		input = button->input;
> >  		if (button->type == ACPI_BUTTON_TYPE_LID) {
> > -			acpi_lid_update_state(device);
> > +			acpi_lid_notify(device);
> >  		} else {
> >  			int keycode;
> > 
> > @@ -433,6 +434,16 @@ static int acpi_button_suspend(struct device *dev)
> >  	struct acpi_button *button = acpi_driver_data(device);
> > 
> >  	button->suspended = true;
> > +
> > +	if (button->type == ACPI_BUTTON_TYPE_LID) {
> > +		/*
> > +		 * If lid is marked unreliable, this will have the effect
> > +		 * of unregistering the LID input node
> > +		 */
> > +		mutex_lock(&button_input_lock);
> > +		acpi_lid_update_reliable(device);
> > +		mutex_unlock(&button_input_lock);
> > +	}
> >  	return 0;
> >  }
> > 
> > @@ -442,8 +453,17 @@ static int acpi_button_resume(struct device *dev)
> >  	struct acpi_button *button = acpi_driver_data(device);
> > 
> >  	button->suspended = false;
> > -	if (button->type == ACPI_BUTTON_TYPE_LID)
> > +	if (button->type == ACPI_BUTTON_TYPE_LID) {
> > +		/*
> > +		 * If lid is marked reliable, this will have the effect
> > +		 * of registering a new LID input node if none was there
> > +		 */
> > +		mutex_lock(&button_input_lock);
> > +		acpi_lid_update_reliable(device);
> >  		acpi_lid_initialize_state(device);
> > +		mutex_unlock(&button_input_lock);
> > +	}
> > +
> >  	return 0;
> >  }
> >  #endif
> > @@ -452,6 +472,7 @@ static void acpi_button_remove_input(struct acpi_device *device)
> >  {
> >  	struct acpi_button *button = acpi_driver_data(device);
> > 
> > +	/* button_input_lock must be held */
> >  	input_unregister_device(button->input);
> >  	button->input = NULL;
> >  }
> > @@ -462,6 +483,8 @@ static int acpi_button_add_input(struct acpi_device *device)
> >  	struct input_dev *input;
> >  	int error;
> > 
> > +	/* button_input_lock must be held */
> > +
> >  	button->input = input = input_allocate_device();
> >  	if (!input) {
> >  		error = -ENOMEM;
> > @@ -500,6 +523,31 @@ static int acpi_button_add_input(struct acpi_device *device)
> >  	return error;
> >  }
> > 
> > +static int acpi_lid_update_reliable(struct acpi_device *device)
> > +{
> > +	struct acpi_button *button = acpi_driver_data(lid_device);
> > +	int error;
> > +
> > +	/* button_input_lock must be held */
> > +
> > +	if (lid_reliable && !button->input) {
> > +		error = acpi_button_add_input(device);
> > +		if (error)
> > +			return error;
> > +
> > +		error = acpi_lid_update_state(device);
> > +		if (error) {
> > +			acpi_button_remove_input(device);
> > +			return error;
> > +		}
> > +	}
> > +
> > +	if (!lid_reliable && button->input)
> > +		acpi_button_remove_input(device);
> > +
> > +	return 0;
> > +}
> > +
> >  static int acpi_button_add(struct acpi_device *device)
> >  {
> >  	struct acpi_button *button;
> > @@ -547,12 +595,7 @@ static int acpi_button_add(struct acpi_device *device)
> > 
> >  	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
> > 
> > -	error = acpi_button_add_input(device);
> > -	if (error)
> > -		goto err_remove_fs;
> > -
> >  	if (button->type == ACPI_BUTTON_TYPE_LID) {
> > -		acpi_lid_initialize_state(device);
> >  		/*
> >  		 * This assumes there's only one lid device, or if there are
> >  		 * more we only care about the last one...
> > @@ -560,6 +603,18 @@ static int acpi_button_add(struct acpi_device *device)
> >  		lid_device = device;
> >  	}
> > 
> > +	if (lid_reliable || button->type != ACPI_BUTTON_TYPE_LID) {
> > +		error = acpi_button_add_input(device);
> > +		if (error)
> > +			goto err_remove_fs;
> > +
> > +		if (button->type == ACPI_BUTTON_TYPE_LID) {
> > +			mutex_lock(&button_input_lock);
> > +			acpi_lid_initialize_state(device);
> > +			mutex_unlock(&button_input_lock);
> > +		}
> > +	}
> > +
> >  	device_init_wakeup(&device->dev, true);
> >  	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
> >  	return 0;
> 
> This is another major differences between your proposal and mine.
> 
> First of all, I think it should be in a separate patch.

Well, that's already a patch on its own :/

> 
> Second, I have concerns related to such a change:
> I can see that, you are trying to address a problem that:
> The input layer requires a determined initial SW_LID state while ACPI button driver cannot offer.
> So by adding/removing input node, you can introduce a tristate SW_LID input node.

You can put it that way. I prefer putting it: "when we export the LID
switch input node, you are guaranteed to have the proper state".

> However I doubt if this is necessary and can solve real issues, as:
> systemd now works fine with button driver for all cases,

I do not care about systemd or the suspend lopps introduced by systemd.
All I care is that the kernel provides correct behavior. If systemd can
work around some issues we see because we are too lazy to fix them in
the kernel (this is not a personal attack, sometimes being lazy is the
right solution), fine. But the current state of this driver doesn't
follow the specification of the input subsystem on some platform, and
this is what this series fixes.

> only desktop managers should be changed to be compliant to case 2/4/5

As long as the kernel lies, we should not even remotely envision asking
user space to change.

> (or if we improve by adding a timer, they should only be changed to be compliant to case 5).
> And doing this won't help desktop managers to be able to work fine with case 5.
> So this finally may only remove ACPI SW_LID support from Surface Pro 1.

I haven't decided how to solve case 5 completely. So please do not take
this case into account yet.

> While with latest systemd, closing lid on that platform can correctly triggers suspend.
> And no suspend/resume cycles should be seen.
> So why do we need to remove this feature (ACPI SW_LID) from Surface Pro 1?

Well, with this change, if you mark the surface pro 1 as unreliable, the
event will be forwarded to user space correctly. Just that there is a
systemd bug in which the state is not synced when the device appears.

So yes, it'll expose a new bug in userspace, but given the blacklist of
unreliable LID switches will be handled in userspace, user space can
make sure this will not show up before systemd can handle it.

> If you really want to propose an ABI change for user space.
> Why don't you do this in input layer by defining SW_LID as tristate?

Because this proposal is not a kABI change, and the kABI change you
propose is just not doable. We have too many users of EV_SW to be able
to say that we change the semantic. A solution would be to add a new
EV_* event, but we don't really need.

Cheers,
Benjamin

> 
> Thanks and best regards
> Lv
