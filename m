From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v2 6/8] HID: sony: Add an IDA allocator to assign unique
 device ids
Date: Mon, 10 Mar 2014 23:25:26 +0100
Message-ID: <20140310232526.4dde47de732f8498a58fb731@ao2.it>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
	<1394145176-24174-7-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:5362 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbaCJWZc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 18:25:32 -0400
In-Reply-To: <1394145176-24174-7-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

Hi Frank,

On Thu,  6 Mar 2014 17:32:54 -0500
Frank Praznik <frank.praznik@oh.rr.com> wrote:

> Add an IDA id allocator to assign unique, sequential device ids to Sixaxis and
> DualShock 4 controllers.
> 
> Use explicit module init and exit functions since the IDA allocator must be
> manually destroyed when the module is unloaded.
>
> Use the device id as the unique number for the battery identification string.
>

Have you thought about using the bdaddr as the battery id?

I think that decoupling led numbers (from the following patch) and
battery ids would be saner. For instance in a scenario when userspace
decided that the _second_ sixaxis has LEDs saying "controller
3" (because of different kind of joypads, remember?) we would have
battery still saying "2" because the battery id is assigned at probe
time while LEDs can change at any time. This mismatch may become
confusing.

> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 70 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index a9bcfbe..13af58c 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -33,6 +33,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> +#include <linux/idr.h>
>  #include <linux/input/mt.h>
>  
>  #include "hid-ids.h"
> @@ -749,6 +750,7 @@ union sixaxis_output_report_01 {
>  
>  static spinlock_t sony_dev_list_lock;
>  static LIST_HEAD(sony_device_list);
> +static DEFINE_IDA(sony_device_id_allocator);
>  
>  struct sony_sc {
>  	spinlock_t lock;
> @@ -758,6 +760,7 @@ struct sony_sc {
>  	unsigned long quirks;
>  	struct work_struct state_worker;
>  	struct power_supply battery;
> +	int device_id;
>  
>  #ifdef CONFIG_SONY_FF
>  	__u8 left;
> @@ -1413,8 +1416,6 @@ static int sony_battery_get_property(struct power_supply *psy,
>  
>  static int sony_battery_probe(struct sony_sc *sc)
>  {
> -	static atomic_t power_id_seq = ATOMIC_INIT(0);
> -	unsigned long power_id;
>  	struct hid_device *hdev = sc->hdev;
>  	int ret;
>  
> @@ -1424,15 +1425,13 @@ static int sony_battery_probe(struct sony_sc *sc)
>  	 */
>  	sc->battery_capacity = 100;
>  
> -	power_id = (unsigned long)atomic_inc_return(&power_id_seq);
> -
>  	sc->battery.properties = sony_battery_props;
>  	sc->battery.num_properties = ARRAY_SIZE(sony_battery_props);
>  	sc->battery.get_property = sony_battery_get_property;
>  	sc->battery.type = POWER_SUPPLY_TYPE_BATTERY;
>  	sc->battery.use_for_apm = 0;
> -	sc->battery.name = kasprintf(GFP_KERNEL, "sony_controller_battery_%lu",
> -				     power_id);
> +	sc->battery.name = kasprintf(GFP_KERNEL, "sony_controller_battery_%i",
> +				     sc->device_id);
>  	if (!sc->battery.name)
>  		return -ENOMEM;
>  
> @@ -1607,6 +1606,38 @@ static int sony_check_add(struct sony_sc *sc)
>  	return sony_check_add_dev_list(sc);
>  }
>  
> +static int sony_set_device_id(struct sony_sc *sc)
> +{
> +	int ret;
> +
> +	/*
> +	 * Only DualShock 4 or Sixaxis controller get an id.
> +	 * All others are set to -1.
> +	 */
> +	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
> +	    (sc->quirks & DUALSHOCK4_CONTROLLER)) {
> +		ret = ida_simple_get(&sony_device_id_allocator, 0, 0,
> +					GFP_KERNEL);
> +		if (ret < 0) {
> +			sc->device_id = -1;
> +			return ret;
> +		}
> +		sc->device_id = ret;
> +	} else {
> +		sc->device_id = -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sony_release_device_id(struct sony_sc *sc)
> +{
> +	if (sc->device_id >= 0) {
> +		ida_simple_remove(&sony_device_id_allocator, sc->device_id);
> +		sc->device_id = -1;
> +	}
> +}
> +
>  static inline void sony_init_work(struct sony_sc *sc,
>  					void(*worker)(struct work_struct *))
>  {
> @@ -1658,6 +1689,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  	}
>  
> +	ret = sony_set_device_id(sc);
> +	if (ret < 0) {
> +		hid_err(hdev, "failed to allocate the device id\n");
> +		goto err_stop;
> +	}
> +
>  	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
>  		/*
>  		 * The Sony Sixaxis does not handle HID Output Reports on the
> @@ -1749,6 +1786,7 @@ err_stop:
>  		sony_battery_remove(sc);
>  	sony_cancel_work_sync(sc);
>  	sony_remove_dev_list(sc);
> +	sony_release_device_id(sc);
>  	hid_hw_stop(hdev);
>  	return ret;
>  }
> @@ -1769,6 +1807,8 @@ static void sony_remove(struct hid_device *hdev)
>  
>  	sony_remove_dev_list(sc);
>  
> +	sony_release_device_id(sc);
> +
>  	hid_hw_stop(hdev);
>  }
>  
> @@ -1813,6 +1853,22 @@ static struct hid_driver sony_driver = {
>  	.report_fixup  = sony_report_fixup,
>  	.raw_event     = sony_raw_event
>  };
> -module_hid_driver(sony_driver);
> +
> +static int __init sony_init(void)
> +{
> +	dbg_hid("Sony:%s\n", __func__);
> +
> +	return hid_register_driver(&sony_driver);
> +}
> +
> +static void __exit sony_exit(void)
> +{
> +	dbg_hid("Sony:%s\n", __func__);
> +
> +	ida_destroy(&sony_device_id_allocator);
> +	hid_unregister_driver(&sony_driver);
> +}
> +module_init(sony_init);
> +module_exit(sony_exit);
>  
>  MODULE_LICENSE("GPL");
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
