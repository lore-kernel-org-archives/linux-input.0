From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH 0/4 incremental 1/2] Generalize controller handling to
 support different devices
Date: Thu, 18 Aug 2011 11:26:38 -0400
Message-ID: <4E4D2F2E.20105@signal11.us>
References: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it> <1313677340-4441-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35437 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769Ab1HRP0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 11:26:41 -0400
In-Reply-To: <1313677340-4441-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

On 08/18/2011 10:22 AM, Antonio Ospite wrote:
> Remove hardcoded #defines and put the values in a struct so we can handle 
> different device types.
>
> From the USB dumps I've seen[1], different devices have just different ways to 
> get and set the bdaddrs, the pairing algorithm is the same.
>
> [1] http://ps3.jim.sh/sixaxis/dumps/ 
>
> ---
>  plugins/sixaxis.c |   80 ++++++++++++++++++++++++++++++++++------------------
>  1 files changed, 52 insertions(+), 28 deletions(-)
>
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index e08222c..608474f 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -70,12 +70,38 @@
>  
>  #define BDADDR_STR_SIZE 18 /* strlen("00:00:00:00:00:00") + 1 */
>  
> -/* Vendor and product ID for the Sixaxis PS3 controller */
> -#define VENDOR 0x054c
> -#define PRODUCT 0x0268
> -#define SIXAXIS_NAME "PLAYSTATION(R)3 Controller"
> -#define SIXAXIS_PNP_RECORD "3601920900000A000100000900013503191124090004350D35061901000900113503190011090006350909656E09006A0901000900093508350619112409010009000D350F350D350619010009001335031900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E7465727461696E6D656E740902000901000902010901000902020800090203082109020428010902052801090206359A35980822259405010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C0090207350835060904090901000902082800090209280109020A2801090
 20B09010009020C093E8009020D280009020E2800"
> -#define HID_UUID "00001124-0000-1000-8000-00805f9b34fb"
> +struct sony_controller {
> +	uint16_t vendor_id;
> +	uint16_t product_id;
> +	char *name;
> +	char *pnp_record;
> +	char *hid_uuid;
> +
> +	/* device specific callbacks to get master/device bdaddr and set
> +	 * master bdaddr
> +	 */
> +	char * (*get_device_bdaddr)(int);
> +	char * (*get_master_bdaddr)(int);
> +	int (*set_master_bdaddr) (int, char *);
> +};
> +
> +static char *sixaxis_get_device_bdaddr(int fd);
> +static char *sixaxis_get_master_bdaddr(int fd);
> +static int sixaxis_set_master_bdaddr(int fd, char *adapter_bdaddr);
> +
> +static struct sony_controller controllers[] = {
> +	{
> +		.vendor_id = 0x054c,
> +		.product_id = 0x0268,
> +		.name = "PLAYSTATION(R)3 Controller",
> +		.pnp_record = "3601920900000A000100000900013503191124090004350D35061901000900113503190011090006350909656E09006A0901000900093508350619112409010009000D350F350D350619010009001335031900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E7465727461696E6D656E740902000901000902010901000902020800090203082109020428010902052801090206359A35980822259405010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C0090207350835060904090901000902082800090209280109020A280109020B09010009
 020C093E8009020D280009020E2800",
> +		.hid_uuid = "00001124-0000-1000-8000-00805f9b34fb",

Where do the pnp_record and hid_uuid come from? It seems a bit odd to
have a giant hard-coded identifier string (pnp), but I'm not an expert
on this stuff, and I'm mostly just curious about it.

> +		.get_device_bdaddr = sixaxis_get_device_bdaddr,
> +		.get_master_bdaddr = sixaxis_get_master_bdaddr,
> +		.set_master_bdaddr = sixaxis_set_master_bdaddr,
> +	},
> +};
> +
>  
>  #define LED_1 (0x01 << 1)
>  #define LED_2 (0x01 << 2)
> @@ -90,12 +116,9 @@ static struct udev_monitor *monitor;
>  static guint watch_id;
>  
>  
> -static int create_sixaxis_association(struct btd_adapter *adapter,
> -					const char *name,
> +static int create_controller_association(struct btd_adapter *adapter,
>  					const char *address,
> -					guint32 vendor_id,
> -					guint32 product_id,
> -					const char *pnp_record)
> +					struct sony_controller *controller)
>  {
>  	DBusConnection *conn;
>  	sdp_record_t *rec;
> @@ -108,15 +131,16 @@ static int create_sixaxis_association(struct btd_adapter *adapter,
>  	adapter_get_address(adapter, &src);
>  	ba2str(&src, srcaddr);
>  
> -	write_device_name(&dst, &src, (char *) name);
> +	write_device_name(&dst, &src, controller->name);
>  
>  	/* Store the device's SDP record */
> -	rec = record_from_string(pnp_record);
> +	rec = record_from_string(controller->pnp_record);
>  	store_record(srcaddr, address, rec);
>  	sdp_record_free(rec);
>  
>  	/* Set the device id */
> -	store_device_id(srcaddr, address, 0xffff, vendor_id, product_id, 0);
> +	store_device_id(srcaddr, address, 0xffff, controller->vendor_id,
> +			controller->product_id, 0);
>  	/* Don't write a profile here,
>  	 * it will be updated when the device connects */
>  
> @@ -137,8 +161,8 @@ static int create_sixaxis_association(struct btd_adapter *adapter,
>  	}
>  
>  	device_set_temporary(device, FALSE);
> -	device_set_name(device, name);
> -	btd_device_add_uuid(device, HID_UUID);
> +	device_set_name(device, controller->name);
> +	btd_device_add_uuid(device, controller->hid_uuid);
>  
>  fail_device:
>  	dbus_connection_unref(conn);
> @@ -184,7 +208,7 @@ static int set_feature_report(int fd, uint8_t *report, int len)
>  	return ret;
>  }
>  
> -static char *get_device_bdaddr(int fd)
> +static char *sixaxis_get_device_bdaddr(int fd)
>  {
>  	unsigned char *buf;
>  	char *address;
> @@ -210,7 +234,7 @@ static char *get_device_bdaddr(int fd)
>  	return address;
>  }
>  
> -static char *get_master_bdaddr(int fd)
> +static char *sixaxis_get_master_bdaddr(int fd)
>  {
>  	unsigned char *buf;
>  	char *address;
> @@ -236,7 +260,7 @@ static char *get_master_bdaddr(int fd)
>  	return address;
>  }
>  
> -static int set_master_bdaddr(int fd, char *adapter_bdaddr)
> +static int sixaxis_set_master_bdaddr(int fd, char *adapter_bdaddr)
>  {
>  	uint8_t *report;
>  	uint8_t addr[6];
> @@ -282,7 +306,7 @@ out:
>  	return ret;
>  }
>  
> -static int sixpair(int fd, struct btd_adapter *adapter)
> +static int controller_pair(int fd, struct btd_adapter *adapter, struct sony_controller *controller)
>  {
>  	char *device_bdaddr;
>  	char *master_bdaddr;
> @@ -294,7 +318,7 @@ static int sixpair(int fd, struct btd_adapter *adapter)
>  	ba2str(&dst, adapter_bdaddr);
>  	DBG("Adapter bdaddr %s", adapter_bdaddr);
>  
> -	master_bdaddr = get_master_bdaddr(fd);
> +	master_bdaddr = controller->get_master_bdaddr(fd);
>  	if (master_bdaddr == NULL) {
>  		DBG("Failed to get the Old master Bluetooth address from the device");
>  		return -EPERM;
> @@ -305,7 +329,7 @@ static int sixpair(int fd, struct btd_adapter *adapter)
>  	 */
>  	if (g_strcmp0(master_bdaddr, adapter_bdaddr) != 0) {
>  		DBG("Old master Bluetooth address was: %s", master_bdaddr);
> -		ret = set_master_bdaddr(fd, adapter_bdaddr);
> +		ret = controller->set_master_bdaddr(fd, adapter_bdaddr);
>  		if (ret < 0) {
>  			DBG("Failed to set the master Bluetooth address");
>  			free(master_bdaddr);
> @@ -313,7 +337,7 @@ static int sixpair(int fd, struct btd_adapter *adapter)
>  		}
>  	}
>  
> -	device_bdaddr = get_device_bdaddr(fd);
> +	device_bdaddr = controller->get_device_bdaddr(fd);
>  	if (device_bdaddr == NULL) {
>  		DBG("Failed to get the Bluetooth address from the device");
>  		free(master_bdaddr);
> @@ -322,10 +346,7 @@ static int sixpair(int fd, struct btd_adapter *adapter)
>  
>  	DBG("Device bdaddr %s", device_bdaddr);
>  
> -	ret = create_sixaxis_association(adapter,
> -					SIXAXIS_NAME,
> -					device_bdaddr,
> -					VENDOR, PRODUCT, SIXAXIS_PNP_RECORD);
> +	ret = create_controller_association(adapter, device_bdaddr, controller);
>  	free(device_bdaddr);
>  	free(master_bdaddr);
>  	return ret;
> @@ -424,6 +445,7 @@ static void handle_device_plug(struct udev_device *udevice)
>  	unsigned char is_usb = FALSE;
>  	int js_num = 0;
>  	int fd;
> +	struct sony_controller *controller;
>  
>  	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice,
>  								"hid", NULL);
> @@ -439,6 +461,8 @@ static void handle_device_plug(struct udev_device *udevice)
>  	if (!is_sixaxis(hid_name))
>  		return;
>  
> +	controller = &controllers[0];
> +

I'd expect the part above to have a for loop checking over all the
entries in the controller array instead of hard-coding to the first one.
With only one right now, of course it works, but making it a loop now
would make it trivial to add the second device (PSMove?) in the future.

>  	DBG("Found a Sixaxis device");
>  
>  	hidraw_node = udev_device_get_devnode(udevice);
> @@ -507,7 +531,7 @@ static void handle_device_plug(struct udev_device *udevice)
>  			DBG("No adapters, exiting");
>  			return;
>  		}
> -		sixpair(fd, adapter);
> +		controller_pair(fd, adapter, controller);
>  	}
>  
>  	if (js_num > 0) {

Hey, looks good overall. I like it. It seems much cleaner.

Alan.


